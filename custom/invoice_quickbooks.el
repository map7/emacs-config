;;; invoice_quickbooks.el --- Create QBO invoices from org-mode DONE items -*- lexical-binding: t; -*-

;; Scans the current org buffer for DONE headings that have no tags,
;; groups their CLOCK entries by day, and creates an invoice in
;; QuickBooks Online (Digitech Corporation) with one line per day at
;; $100/hr + 10% GST. The invoice is created but not sent.
;;
;; Bindings (inside org-mode):
;;   C-c q i  invoice-qbo-create-from-buffer
;;   C-c q p  invoice-qbo-preview-from-buffer
;;   C-c q a  invoice-qbo-authorize
;;   C-c q l  invoice-qbo-logout

(require 'json)
(require 'url)
(require 'org)
(require 'org-element)
(require 'cl-lib)

;;; -------------------------------------------------------------------
;;; Configuration

(defgroup invoice-qbo nil
  "QuickBooks Online invoicing from org-mode."
  :group 'org)

(defcustom invoice-qbo-client-id-env "REPORTCRAFT_QBO_API_CLIENT_ID"
  "Environment variable holding the QBO OAuth client id."
  :type 'string :group 'invoice-qbo)

(defcustom invoice-qbo-client-secret-env "REPORTCRAFT_QBO_API_CLIENT_SECRET"
  "Environment variable holding the QBO OAuth client secret."
  :type 'string :group 'invoice-qbo)

(defcustom invoice-qbo-company-name "Digitech Corporation"
  "Friendly name of the QBO company we expect to be authorised against."
  :type 'string :group 'invoice-qbo)

(defcustom invoice-qbo-redirect-uri "http://localhost:8080/callback"
  "OAuth redirect URI. Must match the one registered for the QBO app."
  :type 'string :group 'invoice-qbo)

(defcustom invoice-qbo-environment 'production
  "Which QBO environment to use."
  :type '(choice (const production) (const sandbox))
  :group 'invoice-qbo)

(defcustom invoice-qbo-hourly-rate 100.0
  "Default hourly rate in AUD applied to each invoice line."
  :type 'number :group 'invoice-qbo)

(defcustom invoice-qbo-gst-rate 0.10
  "GST rate. 0.10 = 10%."
  :type 'number :group 'invoice-qbo)

(defcustom invoice-qbo-token-file
  (expand-file-name ".invoice-qbo-tokens.el" user-emacs-directory)
  "Where to persist OAuth tokens."
  :type 'file :group 'invoice-qbo)

(defcustom invoice-qbo-cache-file
  (expand-file-name ".invoice-qbo-cache.el" user-emacs-directory)
  "Where to persist chosen customer / item / tax code IDs."
  :type 'file :group 'invoice-qbo)

;;; -------------------------------------------------------------------
;;; Internal state

(defvar invoice-qbo--tokens nil
  "Plist with :access-token :refresh-token :expires-at :realm-id.")

(defvar invoice-qbo--cache nil
  "Plist with :customer-id :customer-name :item-id :item-name :tax-code-id :tax-code-name.")

(defun invoice-qbo--api-base ()
  (if (eq invoice-qbo-environment 'sandbox)
      "https://sandbox-quickbooks.api.intuit.com"
    "https://quickbooks.api.intuit.com"))

(defun invoice-qbo--client-id ()
  (or (getenv invoice-qbo-client-id-env)
      (user-error "Env var %s not set" invoice-qbo-client-id-env)))

(defun invoice-qbo--client-secret ()
  (or (getenv invoice-qbo-client-secret-env)
      (user-error "Env var %s not set" invoice-qbo-client-secret-env)))

;;; -------------------------------------------------------------------
;;; Persistence

(defun invoice-qbo--save-tokens ()
  (with-temp-file invoice-qbo-token-file
    (set-buffer-file-coding-system 'utf-8)
    (insert ";; -*- mode: emacs-lisp; -*-\n")
    (prin1 invoice-qbo--tokens (current-buffer)))
  (set-file-modes invoice-qbo-token-file #o600))

(defun invoice-qbo--load-tokens ()
  (when (file-readable-p invoice-qbo-token-file)
    (with-temp-buffer
      (insert-file-contents invoice-qbo-token-file)
      (goto-char (point-min))
      (condition-case nil
          (setq invoice-qbo--tokens (read (current-buffer)))
        (error (setq invoice-qbo--tokens nil))))))

(defun invoice-qbo--save-cache ()
  (with-temp-file invoice-qbo-cache-file
    (insert ";; -*- mode: emacs-lisp; -*-\n")
    (prin1 invoice-qbo--cache (current-buffer))))

(defun invoice-qbo--load-cache ()
  (when (file-readable-p invoice-qbo-cache-file)
    (with-temp-buffer
      (insert-file-contents invoice-qbo-cache-file)
      (goto-char (point-min))
      (condition-case nil
          (setq invoice-qbo--cache (read (current-buffer)))
        (error (setq invoice-qbo--cache nil))))))

;;; -------------------------------------------------------------------
;;; OAuth 2.0

(defun invoice-qbo--basic-auth-header ()
  (concat "Basic "
          (base64-encode-string
           (format "%s:%s" (invoice-qbo--client-id) (invoice-qbo--client-secret))
           t)))

(defun invoice-qbo--urlencode (alist)
  (mapconcat (lambda (p)
               (format "%s=%s"
                       (url-hexify-string (car p))
                       (url-hexify-string (cdr p))))
             alist "&"))

(defun invoice-qbo--token-request (form)
  "POST FORM (alist) to the token endpoint, return parsed JSON plist."
  (let ((url-request-method "POST")
        (url-request-extra-headers
         `(("Accept" . "application/json")
           ("Content-Type" . "application/x-www-form-urlencoded")
           ("Authorization" . ,(invoice-qbo--basic-auth-header))))
        (url-request-data (invoice-qbo--urlencode form)))
    (with-current-buffer
        (url-retrieve-synchronously
         "https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer" t)
      (goto-char (point-min))
      (unless (re-search-forward "^\r?$" nil t)
        (error "Malformed token endpoint response"))
      (let* ((body (buffer-substring-no-properties (point) (point-max)))
             (json-object-type 'plist)
             (json-array-type 'list)
             (json-key-type 'keyword)
             (data (json-read-from-string body)))
        (when (plist-get data :error)
          (error "QBO token error: %s — %s"
                 (plist-get data :error)
                 (or (plist-get data :error_description) "")))
        data))))

(defun invoice-qbo--store-token-response (data &optional realm-id)
  (let ((expires (plist-get data :expires_in)))
    (setq invoice-qbo--tokens
          (list :access-token (plist-get data :access_token)
                :refresh-token (or (plist-get data :refresh_token)
                                   (plist-get invoice-qbo--tokens :refresh-token))
                :expires-at (when expires (+ (float-time) expires -30))
                :realm-id (or realm-id
                              (plist-get invoice-qbo--tokens :realm-id)))))
  (invoice-qbo--save-tokens))

(defun invoice-qbo-authorize ()
  "Run the OAuth authorization-code flow interactively.
Opens a browser; user pastes the redirected URL back into Emacs."
  (interactive)
  (let* ((state (format "emacs-%d" (random 1000000)))
         (auth-url
          (concat "https://appcenter.intuit.com/connect/oauth2?"
                  (invoice-qbo--urlencode
                   `(("client_id"     . ,(invoice-qbo--client-id))
                     ("response_type" . "code")
                     ("scope"         . "com.intuit.quickbooks.accounting")
                     ("redirect_uri"  . ,invoice-qbo-redirect-uri)
                     ("state"         . ,state))))))
    (browse-url auth-url)
    (message "Opened browser. Sign in to %s and authorize." invoice-qbo-company-name)
    (let* ((redirected
            (read-string
             "Paste the full URL you were redirected to: "))
           (q (cdr (url-path-and-query (url-generic-parse-url redirected))))
           (params (when q (url-parse-query-string q)))
           (code   (cadr (assoc "code"    params)))
           (rstate (cadr (assoc "state"   params)))
           (realm  (cadr (assoc "realmId" params))))
      (unless code  (user-error "No code in callback URL"))
      (unless realm (user-error "No realmId in callback URL"))
      (unless (string= rstate state)
        (user-error "OAuth state mismatch — abort"))
      (let ((data (invoice-qbo--token-request
                   `(("grant_type"   . "authorization_code")
                     ("code"         . ,code)
                     ("redirect_uri" . ,invoice-qbo-redirect-uri)))))
        (invoice-qbo--store-token-response data realm)
        (message "Authorized. Realm: %s" realm)))))

(defun invoice-qbo--refresh ()
  (let ((rt (plist-get invoice-qbo--tokens :refresh-token)))
    (unless rt (user-error "No refresh token — run M-x invoice-qbo-authorize"))
    (let ((data (invoice-qbo--token-request
                 `(("grant_type"    . "refresh_token")
                   ("refresh_token" . ,rt)))))
      (invoice-qbo--store-token-response data))))

(defun invoice-qbo--ensure-token ()
  (unless invoice-qbo--tokens (invoice-qbo--load-tokens))
  (unless (plist-get invoice-qbo--tokens :access-token)
    (invoice-qbo-authorize))
  (let ((exp (plist-get invoice-qbo--tokens :expires-at)))
    (when (or (null exp) (< exp (float-time)))
      (invoice-qbo--refresh))))

(defun invoice-qbo-logout ()
  "Forget cached tokens (cache of customer/item/tax is kept)."
  (interactive)
  (setq invoice-qbo--tokens nil)
  (when (file-exists-p invoice-qbo-token-file)
    (delete-file invoice-qbo-token-file))
  (message "QBO tokens cleared."))

;;; -------------------------------------------------------------------
;;; HTTP

(defun invoice-qbo--request (method path &optional body params)
  "METHOD = \"GET\"/\"POST\". PATH joined under /v3/company/{realm}/.
BODY is an alist/plist for JSON; PARAMS is an alist for the query string.
Returns parsed response as a plist."
  (invoice-qbo--ensure-token)
  (let* ((realm (or (plist-get invoice-qbo--tokens :realm-id)
                    (user-error "No realm id — re-authorize")))
         (qs (when params (concat "?" (invoice-qbo--urlencode params))))
         (url (format "%s/v3/company/%s/%s%s"
                      (invoice-qbo--api-base) realm path (or qs "")))
         (url-request-method method)
         (url-request-extra-headers
          `(("Authorization" . ,(concat "Bearer "
                                        (plist-get invoice-qbo--tokens :access-token)))
            ("Accept"        . "application/json")
            ,@(when body '(("Content-Type" . "application/json")))))
         (url-request-data
          (when body (encode-coding-string (json-encode body) 'utf-8))))
    (with-current-buffer (url-retrieve-synchronously url t)
      (goto-char (point-min))
      (let* ((status-line (buffer-substring (point-min) (line-end-position)))
             (code (and (string-match " \\([0-9]+\\) " status-line)
                        (string-to-number (match-string 1 status-line)))))
        (unless (re-search-forward "^\r?$" nil t)
          (error "Malformed QBO response: %s" status-line))
        (let* ((raw (buffer-substring-no-properties (point) (point-max)))
               (json-object-type 'plist)
               (json-array-type 'list)
               (json-key-type 'keyword))
          (cond
           ((and code (= code 401))
            (invoice-qbo--refresh)
            (invoice-qbo--request method path body params))
           ((and code (>= code 400))
            (error "QBO %s %s -> %d: %s" method path code raw))
           ((string-empty-p (string-trim raw)) nil)
           (t (json-read-from-string raw))))))))

(defun invoice-qbo--query (sql)
  "Run a QBO SQL-like query and return the parsed result."
  (invoice-qbo--request "GET" "query" nil `(("query" . ,sql))))

;;; -------------------------------------------------------------------
;;; Lookups (customer / item / tax code) with caching

(defun invoice-qbo--load-cache-once ()
  (unless invoice-qbo--cache (invoice-qbo--load-cache)))

(defun invoice-qbo--all-rows (response key)
  "Pull rows named KEY (a keyword like :Customer) out of a QBO query response."
  (let ((qr (plist-get response :QueryResponse)))
    (or (plist-get qr key) '())))

(defun invoice-qbo--pick-customer ()
  (invoice-qbo--load-cache-once)
  (or (plist-get invoice-qbo--cache :customer-id)
      (let* ((rows (invoice-qbo--all-rows
                    (invoice-qbo--query
                     "SELECT Id, DisplayName FROM Customer WHERE Active = true MAXRESULTS 500")
                    :Customer))
             (choices (mapcar (lambda (c)
                                (cons (plist-get c :DisplayName)
                                      (plist-get c :Id)))
                              rows))
             (_ (unless choices (user-error "No active customers found in QBO")))
             (pick (completing-read "Bill to customer: " choices nil t))
             (id   (cdr (assoc pick choices))))
        (setq invoice-qbo--cache
              (plist-put (or invoice-qbo--cache '())
                         :customer-id id))
        (setq invoice-qbo--cache (plist-put invoice-qbo--cache :customer-name pick))
        (invoice-qbo--save-cache)
        id)))

(defun invoice-qbo--pick-item ()
  (invoice-qbo--load-cache-once)
  (or (plist-get invoice-qbo--cache :item-id)
      (let* ((rows (invoice-qbo--all-rows
                    (invoice-qbo--query
                     "SELECT Id, Name, Type FROM Item WHERE Active = true MAXRESULTS 500")
                    :Item))
             (choices (mapcar (lambda (i)
                                (cons (format "%s (%s)"
                                              (plist-get i :Name)
                                              (plist-get i :Type))
                                      (plist-get i :Id)))
                              rows))
             (_ (unless choices (user-error "No items found in QBO")))
             (pick (completing-read "Service item: " choices nil t))
             (id   (cdr (assoc pick choices))))
        (setq invoice-qbo--cache (plist-put (or invoice-qbo--cache '()) :item-id id))
        (setq invoice-qbo--cache (plist-put invoice-qbo--cache :item-name pick))
        (invoice-qbo--save-cache)
        id)))

(defun invoice-qbo--pick-tax-code ()
  (invoice-qbo--load-cache-once)
  (or (plist-get invoice-qbo--cache :tax-code-id)
      (let* ((rows (invoice-qbo--all-rows
                    (invoice-qbo--query
                     "SELECT Id, Name, Description FROM TaxCode MAXRESULTS 500")
                    :TaxCode))
             (choices (mapcar (lambda (tc)
                                (cons (format "%s — %s"
                                              (plist-get tc :Name)
                                              (or (plist-get tc :Description) ""))
                                      (plist-get tc :Id)))
                              rows))
             (_ (unless choices (user-error "No tax codes found in QBO")))
             (default (cl-find-if (lambda (c) (string-match-p "GST" (car c))) choices))
             (pick (completing-read "GST tax code: " choices nil t
                                    (when default (car default))))
             (id   (cdr (assoc pick choices))))
        (setq invoice-qbo--cache (plist-put (or invoice-qbo--cache '()) :tax-code-id id))
        (setq invoice-qbo--cache (plist-put invoice-qbo--cache :tax-code-name pick))
        (invoice-qbo--save-cache)
        id)))

(defun invoice-qbo-reset-cache ()
  "Forget cached customer / item / tax code selections."
  (interactive)
  (setq invoice-qbo--cache nil)
  (when (file-exists-p invoice-qbo-cache-file)
    (delete-file invoice-qbo-cache-file))
  (message "Invoice QBO selections cleared."))

;;; -------------------------------------------------------------------
;;; Org parsing — untagged DONE items with clocks grouped by day

(defun invoice-qbo--collect-tasks ()
  "Return list of plists (:title STR :assigned-date \"YYYY-MM-DD\"
:minutes N :marker M) for every untagged DONE heading.  Total minutes
are summed across all CLOCK rows; the assigned date is the date of the
most recent clock-in.  Marker points at the heading start."
  (let (tasks)
    (org-element-map (org-element-parse-buffer 'headline) 'headline
      (lambda (hl)
        (when (and (string= (org-element-property :todo-keyword hl) "DONE")
                   (null (org-element-property :tags hl)))
          (let ((title (org-element-property :raw-value hl))
                (beg   (org-element-property :begin hl))
                (end   (org-element-property :end hl))
                (total 0)
                latest-stamp latest-date)
            (save-excursion
              (goto-char beg)
              (let ((limit (save-excursion (goto-char end) (point))))
                (while (re-search-forward
                        "^[ \t]*CLOCK:[ \t]*\\[\\([0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}\\)[^ ]* +[A-Za-z]+ +\\([0-9]\\{2\\}:[0-9]\\{2\\}\\)\\][ \t]*--[ \t]*\\[[^]]*\\][ \t]*=>[ \t]*\\([0-9]+\\):\\([0-9]\\{2\\}\\)"
                        limit t)
                  (let* ((date  (match-string 1))
                         (time  (match-string 2))
                         (stamp (concat date " " time))
                         (hh    (string-to-number (match-string 3)))
                         (mm    (string-to-number (match-string 4)))
                         (mins  (+ (* hh 60) mm)))
                    (cl-incf total mins)
                    (when (or (null latest-stamp) (string> stamp latest-stamp))
                      (setq latest-stamp stamp
                            latest-date  date))))))
            (when latest-date
              (push (list :title title
                          :assigned-date latest-date
                          :minutes total
                          :marker (copy-marker beg))
                    tasks))))))
    (nreverse tasks)))

(defun invoice-qbo--group-by-day (tasks)
  "Group TASKS by :assigned-date into ((DATE . ((TITLE . MINUTES) ...)) ...).
Returned alist is sorted by date ascending."
  (let ((tbl (make-hash-table :test 'equal)))
    (dolist (tk tasks)
      (let* ((d (plist-get tk :assigned-date))
             (title (plist-get tk :title))
             (mins  (plist-get tk :minutes)))
        (puthash d (append (gethash d tbl) (list (cons title mins))) tbl)))
    (sort (let (out)
            (maphash (lambda (d v) (push (cons d v) out)) tbl)
            out)
          (lambda (a b) (string< (car a) (car b))))))

(defun invoice-qbo--day-description (titles-mins)
  "Build a description line from ((TITLE . MINUTES) ...) for one day."
  (mapconcat (lambda (tm)
               (format "- %s (%s)"
                       (car tm)
                       (invoice-qbo--fmt-hours (cdr tm))))
             titles-mins
             "\n"))

(defun invoice-qbo--fmt-hours (minutes)
  (format "%d:%02d" (/ minutes 60) (mod minutes 60)))

(defun invoice-qbo--day-hours (titles-mins)
  (/ (apply #'+ (mapcar #'cdr titles-mins)) 60.0))

;;; -------------------------------------------------------------------
;;; Invoice payload + create

(defun invoice-qbo--build-lines (grouped item-id tax-code-id)
  (mapcar
   (lambda (day)
     (let* ((date (car day))
            (work (cdr day))
            (qty  (invoice-qbo--day-hours work))
            (amt  (* qty invoice-qbo-hourly-rate))
            (desc (format "%s\n%s" date (invoice-qbo--day-description work))))
       `(:DetailType "SalesItemLineDetail"
         :Amount ,(/ (round (* amt 100)) 100.0)
         :Description ,desc
         :SalesItemLineDetail
         (:ItemRef     (:value ,item-id)
          :Qty         ,qty
          :UnitPrice   ,invoice-qbo-hourly-rate
          :TaxCodeRef  (:value ,tax-code-id)))))
   grouped))

(defun invoice-qbo--build-payload (grouped customer-id item-id tax-code-id)
  `(:CustomerRef (:value ,customer-id)
    :Line ,(invoice-qbo--build-lines grouped item-id tax-code-id)
    :TxnTaxDetail (:TxnTaxCodeRef (:value ,tax-code-id))
    :GlobalTaxCalculation "TaxExcluded"))

(defun invoice-qbo--summarise (grouped)
  (let* ((total-mins (apply #'+ (mapcar (lambda (d)
                                          (apply #'+ (mapcar #'cdr (cdr d))))
                                        grouped)))
         (hours (/ total-mins 60.0))
         (sub   (* hours invoice-qbo-hourly-rate))
         (gst   (* sub invoice-qbo-gst-rate)))
    (list :days (length grouped)
          :hours hours
          :subtotal sub
          :gst gst
          :total (+ sub gst))))

(defun invoice-qbo--iso-to-dmy (iso)
  "Convert YYYY-MM-DD to dd/mm/yyyy."
  (format "%s/%s/%s"
          (substring iso 8 10)
          (substring iso 5 7)
          (substring iso 0 4)))

(defcustom invoice-qbo-description-max 150
  "Maximum visible width for the description column in the preview."
  :type 'integer :group 'invoice-qbo)
;; defcustom won't overwrite an already-bound value, so re-apply on
;; eval-buffer during development.
(setq invoice-qbo-description-max 150)

(defun invoice-qbo--summarise-titles (titles max)
  "Join TITLES with commas; if longer than MAX, keep a fitting prefix
and append \" (+N more)\" for the dropped ones."
  (let ((full (mapconcat #'identity titles ", ")))
    (if (<= (length full) max) full
      (let ((kept '()) (used 0) (dropped 0))
        (dolist (tt titles)
          (let* ((sep (if kept ", " ""))
                 (need (+ (length sep) (length tt))))
            (if (and (zerop dropped)
                     (<= (+ used need) (- max 12))) ; leave room for " (+N more)"
                (progn (push tt kept) (cl-incf used need))
              (cl-incf dropped))))
        (concat (mapconcat #'identity (nreverse kept) ", ")
                (format " (+%d more)" dropped))))))

(defun invoice-qbo-preview-from-buffer ()
  "Show what would be invoiced without contacting QBO.
One line per day: date, comma-joined titles, hours, rate, GST, total.
Descriptions over `invoice-qbo-description-max' are summarised."
  (interactive)
  (let* ((entries (invoice-qbo--collect-tasks))
         (grouped (invoice-qbo--group-by-day entries))
         (sum (invoice-qbo--summarise grouped))
         (buf (get-buffer-create "*Invoice QBO Preview*"))
         (rows (mapcar
                (lambda (day)
                  (let* ((work (cdr day))
                         (hrs  (invoice-qbo--day-hours work))
                         (total (* hrs invoice-qbo-hourly-rate
                                   (+ 1 invoice-qbo-gst-rate))))
                    (list (invoice-qbo--iso-to-dmy (car day))
                          (mapconcat #'car work ", ")
                          hrs
                          total)))
                grouped))
         (desc-w  (apply #'max 11 (mapcar (lambda (r) (length (nth 1 r))) rows)))
         (hrs-w   (apply #'max  5 (mapcar (lambda (r) (length (format "%.2f" (nth 2 r)))) rows)))
         (total-w (apply #'max  8 (mapcar (lambda (r) (length (format "%.2f" (nth 3 r)))) rows)))
         (fmt (format "%%-10s  %%-%ds  %%%ds  RATE=%%.2f GST=%%.2f  TOTAL=%%%ds\n"
                      desc-w hrs-w total-w)))
    (unless grouped (user-error "No untagged DONE entries with CLOCK rows found"))
    (with-current-buffer buf
      (erase-buffer)
      (dolist (r rows)
        (insert (format fmt
                        (nth 0 r)
                        (nth 1 r)
                        (format "%.2f" (nth 2 r))
                        invoice-qbo-hourly-rate
                        invoice-qbo-gst-rate
                        (format "%.2f" (nth 3 r)))))
      (insert (format "\nDays: %d   Hours: %.2f   Subtotal: $%.2f   GST: $%.2f   Total: $%.2f\n"
                      (plist-get sum :days)
                      (plist-get sum :hours)
                      (plist-get sum :subtotal)
                      (plist-get sum :gst)
                      (plist-get sum :total)))
      (goto-char (point-min)))
    (display-buffer buf)))

(defvar-local invoice-qbo--last-invoice nil
  "Plist holding the most recent invoice created from this buffer.
Keys: :doc-number :id :tasks (list of plists from `invoice-qbo--collect-tasks').")

(defun invoice-qbo-create-from-buffer ()
  "Create a draft invoice in QBO from the current `org-mode' buffer.
Lines: one per day.  Rate $100/h, 10% GST.  Invoice is not sent.
After creation, the task list and invoice number are stashed so that
`invoice-qbo-mark-invoiced' can tag the source headings."
  (interactive)
  (let* ((tasks   (invoice-qbo--collect-tasks))
         (grouped (invoice-qbo--group-by-day tasks)))
    (unless grouped
      (user-error "No untagged DONE entries with CLOCK rows found"))
    (let* ((sum (invoice-qbo--summarise grouped))
           (_   (unless (yes-or-no-p
                         (format "Create draft invoice: %d day(s), %.2fh, $%.2f + GST $%.2f = $%.2f? "
                                 (plist-get sum :days)
                                 (plist-get sum :hours)
                                 (plist-get sum :subtotal)
                                 (plist-get sum :gst)
                                 (plist-get sum :total)))
                  (user-error "Cancelled")))
           (src-buf (current-buffer))
           (customer-id (invoice-qbo--pick-customer))
           (item-id     (invoice-qbo--pick-item))
           (tax-id      (invoice-qbo--pick-tax-code))
           (payload (invoice-qbo--build-payload grouped customer-id item-id tax-id))
           (resp (invoice-qbo--request "POST" "invoice" payload))
           (inv  (plist-get resp :Invoice)))
      (if inv
          (progn
            (with-current-buffer src-buf
              (setq invoice-qbo--last-invoice
                    (list :doc-number (plist-get inv :DocNumber)
                          :id         (plist-get inv :Id)
                          :tasks      tasks)))
            (message "QBO invoice #%s created (id %s) — total $%s. Not sent. Run C-c q m to tag the source headings."
                     (plist-get inv :DocNumber)
                     (plist-get inv :Id)
                     (plist-get inv :TotalAmt)))
        (message "QBO response: %S" resp)))))

(defun invoice-qbo--sanitise-tag (s)
  "Convert S into something safe to use as an org tag."
  (let ((out (replace-regexp-in-string "[^A-Za-z0-9_@]" "_" s)))
    (if (string-match-p "\\`[A-Za-z@_]" out) out (concat "n" out))))

(defun invoice-qbo-mark-invoiced ()
  "Tag the headings of the last invoice with :invoiced_DOCNUMBER:.
Uses the data stashed by `invoice-qbo-create-from-buffer'.  Adds an
`INVOICE_NUMBER' property and the org tag so future runs will skip
these entries (they are no longer untagged)."
  (interactive)
  (unless invoice-qbo--last-invoice
    (user-error "No recent invoice in this buffer — run C-c q i first"))
  (let* ((doc   (plist-get invoice-qbo--last-invoice :doc-number))
         (tasks (plist-get invoice-qbo--last-invoice :tasks))
         (tag   (concat "invoiced_" (invoice-qbo--sanitise-tag (format "%s" doc))))
         (count 0))
    (save-excursion
      (dolist (task tasks)
        (let ((m (plist-get task :marker)))
          (when (and m (marker-position m))
            (goto-char m)
            (when (and (org-at-heading-p)
                       (string= (org-get-todo-state) "DONE")
                       (null (org-get-tags nil t)))
              (org-set-tags (list tag))
              (org-entry-put (point) "INVOICE_NUMBER" (format "%s" doc))
              (cl-incf count))))))
    (message "Tagged %d heading(s) with :%s:" count tag)))

;;; -------------------------------------------------------------------
;;; Keybindings

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c q i") #'invoice-qbo-create-from-buffer)
  (define-key org-mode-map (kbd "C-c q p") #'invoice-qbo-preview-from-buffer)
  (define-key org-mode-map (kbd "C-c q m") #'invoice-qbo-mark-invoiced)
  (define-key org-mode-map (kbd "C-c q a") #'invoice-qbo-authorize)
  (define-key org-mode-map (kbd "C-c q l") #'invoice-qbo-logout))

(provide 'invoice_quickbooks)
;;; invoice_quickbooks.el ends here
