(setq 4gl-keywords
	  `(

		("\\s." . font-lock-type-face)
		("\\s(\\|\\s)" . font-lock-builtin-face)
		("\\bREPORT\\s-+.*(\\(.*\\))" (1 font-lock-variable-name-face))
		("\\bFUNCTION\\s-+.*(\\(.*\\))" (1 font-lock-variable-name-face))
		("\\bLET\\s-+\\(\\sw+\\)" (1 font-lock-variable-name-face))
		("\\bREPORT\\s-+\\(\\sw+\\)(" (1 font-lock-function-name-face))
		("\\bFUNCTION\\s-+\\(\\sw+\\)(" (1 font-lock-function-name-face))
		(, (regexp-opt (split-string "ABORT ABS ABSOLUTE ACCEPT ACCESS ACOS ADD AFTER ALL SFMT
ALLOCATE ALTER AND ANSI ANY APPEND ARG_VAL ARRAY ARR_COUNT
ARR_CURR AS ASC ASCENDING ASCII ASIN AT ATAN ATAN2 ATTACH
ATTRIBUTE ATTRIBUTES AUDIT AUTHORIZATION AUTO AUTONEXT AVERAGE AVG
BEFORE BEGIN BETWEEN BLACK BLINK BLUE BOLD BORDER BOTH BOTTOM
BREAK BUFFERED BY BYTE
CALL CASCADE CASE CHAR CHARACTER CHARACTER_LENGTH CHAR_LENGTH
CHECK CLASS_ORIGIN CLEAR CLIPPED CLOSE CLUSTER COLOR
COLUMN COLUMNS COMMAND COMMENT COMMENTS COMMIT COMMITTED
COMPOSITES COMPRESS CONCURRENT CONNECT CONNECTION
CONNECTION_ALIAS CONSTRAINED CONSTRAINT CONSTRAINTS CONSTRUCT
CONTINUE CONTROL COS COUNT CREATE CURRENT CURSOR CYAN
DATA DATABASE DATASKIP DATE DATETIME DAY DBA DBINFO DBSERVERNAME
DEALLOCATE DEBUG DEC DECIMAL DECLARE DEFAULT DEFAULTS DEFER
DEFERRED DEFINE DELETE DELIMITER DELIMITERS DESC DESCENDING
DESCRIBE DESCRIPTOR DETACH DIAGNOSTICS DIM DIRTY DISABLED
DISCONNECT DISPLAY DISTINCT DISTRIBUTIONS DO DORMANT DOUBLE
DOWN DOWNSHIFT DROP
EACH ELIF ELSE ENABLED END ENTRY ERROR ERRORLOG ERR_GET
ERR_PRINT ERR_QUIT ESC ESCAPE EVERY EXCEPTION EXCLUSIVE
EXEC EXECUTE EXISTS EXIT EXP EXPLAIN EXPRESSION EXTEND EXTENT
EXTERN EXTERNAL
F1 F10 F11 F12 F13 F14 F15 F16 F17 F18 F19 F2 F20 F21 F22 F23
F24 F25 F26 F27 F28 F29 F3 F30 F31 F32 F33 F34 F35 F36 F37 F38
F39 F4 F40 F41 F42 F43 F44 F45 F46 F47 F48 F49 F5 F50 F51 F52
F53 F54 F55 F56 F57 F58 F59 F6 F60 F61 F62 F63 F64 F7 F8 F9
FALSE FETCH FGL_GETENV FGL_KEYVAL FGL_LASTKEY FIELD FIELD_TOUCHED
FILE FILLFACTOR FILTERING FINISH FIRST FLOAT FLUSH FOR
FOREACH FOREIGN FORM FORMAT FORMONLY FORTRAN FOUND FRACTION
FRAGMENT FREE FROM FUNCTION GET_FLDBUF GLOBAL GLOBALS GO GOTO
GRANT GREEN GROUP HAVING HEADER HELP HEX HIDE HIGH HOLD HOUR
IDATA IF ILENGTH IMMEDIATE IN INCLUDE INDEX INDEXES INDICATOR
INFIELD INIT INITIALIZE INPUT INSERT INSTRUCTIONS INT INTEGER
INTERRUPT INTERVAL INTO INT_FLAG INVISIBLE IS ISAM ISOLATION
ITYPE
KEY LABEL
LANGUAGE LAST LEADING LEFT LENGTH LET LIKE LINE
LINENO LINES LOAD LOCATE LOCK LOG LOG10 LOGN LONG LOW
MAGENTA MAIN MARGIN MATCHES MAX MDY MEDIUM MEMORY MENU MESSAGE
MESSAGE_LENGTH MESSAGE_TEXT MIN MINUTE MOD MODE MODIFY MODULE
MONEY MONTH MORE
NAME NCHAR NEED NEW NEXT NEXTPAGE NO NOCR NOENTRY NONE NORMAL
NOT NOTFOUND NULL NULLABLE NUMBER NUMERIC NUM_ARGS NVARCHAR
OCTET_LENGTH OF OFF OLD ON ONLY OPEN OPTIMIZATION OPTION OPTIONS
OR ORDER OTHERWISE OUTER OUTPUT
PAGE PAGENO PAUSE PDQPRIORITY PERCENT PICTURE PIPE POW PRECISION
PREPARE PREVIOUS PREVPAGE PRIMARY PRINT PRINTER PRIOR PRIVATE
PRIVILEGES PROCEDURE PROGRAM PROMPT PUBLIC PUT
QUIT QUIT_FLAG
RAISE RANGE READ READONLY REAL RECORD RECOVER RED REFERENCES
REFERENCING REGISTER RELATIVE REMAINDER REMOVE RENAME REOPTIMIZATION
REPEATABLE REPORT REQUIRED RESOLUTION RESOURCE RESTRICT
RESUME RETURN RETURNED_SQLSTATE RETURNING REVERSE REVOKE RIGHT
ROBIN ROLE ROLLBACK ROLLFORWARD ROOT ROUND ROW ROWID ROWIDS
ROWS ROW_COUNT RUN
SCALE SCHEMA SCREEN SCROLL SCR_LINE SECOND SECTION SELECT
SERIAL SERIALIZABLE SERVER_NAME SESSION SET SET_COUNT SHARE
SHORT SHOW SITENAME SIZE SIZEOF SKIP SLEEP SMALLFLOAT SMALLINT
SOME SPACE SPACES SQL SQLAWARN SQLCA SQLCODE SQLERRD SQLERRM
SQLERROR SQLERRP SQLSTATE SQLWARNING SQRT STABILITY START
STARTLOG STATIC STATISTICS STATUS STDEV STEP STOP STRING STRUCT
SUBCLASS_ORIGIN SUM SWITCH SYNONYM SYSTEM
SysBlobs SysChecks SysColAuth SysColDepend SysColumns
SysConstraints SysDefaults SysDepend SysDistrib SysFragAuth
SysFragments SysIndexes SysObjState SysOpClstr SysProcAuth
SysProcBody SysProcPlan SysProcedures SysReferences SysRoleAuth
SysSynTable SysSynonyms SysTabAuth SysTables SysTrigBody
SysTriggers SysUsers SysViews SysViolations
TAB TABLE TABLES TAN TEMP TEXT THEN THROUGH THRU TIME TO
TODAY TOP TOTAL TRACE TRAILER TRAILING TRANSACTION TRIGGER
TRIGGERS TRIM TRUE TRUNC TYPE TYPEDEF
UNCOMMITTED UNCONSTRAINED UNDERLINE UNION UNIQUE UNITS UNLOAD
UNLOCK UNSIGNED UP UPDATE UPSHIFT USER USING
VALIDATE VALUE VALUES VARCHAR VARIABLES VARIANCE VARYING
VERIFY VIEW VIOLATIONS
WAIT WAITING WARNING WEEKDAY WHEN WHENEVER WHERE WHILE WHITE
WINDOW WITH WITHOUT WORDWRAP WORK WRAP WRITE
YEAR YELLOW
ZEROFILL")'words ) . font-lock-keyword-face)
		;;(,(regex-opt (split-string "   ") 'word) . font-lock-face)
	  ))


(setq 4gl-mode-syntax-table
      (let ((synTable (make-syntax-table)))
		(modify-syntax-entry ?\(  "()" synTable)
		(modify-syntax-entry ?\)  ")(" synTable)
		(modify-syntax-entry ?\_  "w" synTable)
		(modify-syntax-entry ?\'  "\"" synTable)
		(modify-syntax-entry ?\"  "\"" synTable)

		(modify-syntax-entry ?+  "." synTable)
		(modify-syntax-entry ?-  "." synTable)
		(modify-syntax-entry ?%  "." synTable)
		(modify-syntax-entry ?&  "." synTable)
		(modify-syntax-entry ?|  "." synTable)
		(modify-syntax-entry ?^  "." synTable)
		(modify-syntax-entry ?!  "." synTable)
		(modify-syntax-entry ?=  "." synTable)
		(modify-syntax-entry ?<  "." synTable)
		(modify-syntax-entry ?>  "." synTable)
		;; { } as comments (single-char delimiter)
		(modify-syntax-entry ?\{  "! 1n" synTable)
		(modify-syntax-entry ?\}  "! 4n" synTable)

		;; # line comments
        (modify-syntax-entry ?# "< b" synTable)
        (modify-syntax-entry ?\n "> b " synTable)

		;; -- SQL style comments
		;; also uses the new line comment ender above
		(modify-syntax-entry ?\- ". 12b" synTable)

        synTable))


(defun 4gl-indent ()
  "Indent current line for Informix 4GL."
  (let ((case-fold-search t)
        (open-col 0)
        (open-line-number -1)
        (close-col 0)
        (close-line-number -1))
    ;; Find nearest opening keyword above
    (save-excursion
      (beginning-of-line)
      (when (re-search-backward
             "^\\s-*\\(if\\b\\|main\\b\\|type\\b\\|function\\b\\|report\\b\\|construct\\b\\|dialog\\b\\|input\\b\\|foreach\\b\\|for\\b\\|while\\b\\|menu\\b\\|display\\s-+array\\b\\|input\\s-+array\\b\\|on\\s-\\|format\\b\\|before\\b\\|after\\b\\|else\\b\\|case\\b\\)"
             nil t)
        (back-to-indentation)
        (setq open-col (+ (current-column) 4))
        (setq open-line-number (line-number-at-pos))))
    ;; Find nearest closing keyword above
    (save-excursion
      (beginning-of-line)
      (when (re-search-backward "^\\s-*end\\s-" nil t)
        (back-to-indentation)
        (setq close-col (current-column))
        (setq close-line-number (line-number-at-pos))))
    (indent-line-to
     (cond
      ;; Current line is a closing or peer keyword — match its opener
      ((4gl--current-line-matches-p "^\\s-*end\\s-+if\\b")
       (4gl--opener-column "^\\s-*if\\b"))
      ((4gl--current-line-matches-p "^\\s-*end\\s-+main\\b")
       (4gl--opener-column "^\\s-*main\\b"))
      ((4gl--current-line-matches-p "^\\s-*else\\b")
       (4gl--opener-column "^\\s-*if\\b"))
      ((4gl--current-line-matches-p "^\\s-*end\\s-+type\\b")
       (4gl--opener-column "^\\s-*type\\b"))
      ((4gl--current-line-matches-p "^\\s-*end\\s-+input\\b")
       (4gl--opener-column "^\\s-*input\\b"))
      ((4gl--current-line-matches-p "^\\s-*end\\s-+case\\b")
       (4gl--opener-column "^\\s-*case\\b"))
      ((4gl--current-line-matches-p "^\\s-*when\\b")
       (4gl--opener-column "^\\s-*case\\b"))
      ((4gl--current-line-matches-p "^\\s-*end\\s-+dialog\\b")
       (4gl--opener-column "^\\s-*dialog\\b"))
      ((4gl--current-line-matches-p "^\\s-*end\\s-+construct\\b")
       (4gl--opener-column "^\\s-*construct\\b"))
      ((4gl--current-line-matches-p "^\\s-*end\\s-+foreach\\b")
       (4gl--opener-column "^\\s-*foreach\\b"))
      ((4gl--current-line-matches-p "^\\s-*end\\s-+for\\b")
       (4gl--opener-column "^\\s-*for\\b"))
      ((4gl--current-line-matches-p "^\\s-*end\\s-+while\\b")
       (4gl--opener-column "^\\s-*while\\b"))
      ((4gl--current-line-matches-p "^\\s-*end\\s-+menu\\b")
       (4gl--opener-column "^\\s-*menu\\b"))
      ((4gl--current-line-matches-p "^\\s-*end\\s-+display\\b")
       (4gl--opener-column "^\\s-*display\\s-+array\\b"))
      ((4gl--current-line-matches-p "^\\s-*end\\s-+function\\b") 0)
      ((4gl--current-line-matches-p "^\\s-*end\\s-+report\\b") 0)
      ((4gl--current-line-matches-p
        "^\\s-*\\(format\\|output\\|order\\s-\\|first\\|on\\s-+every\\|after\\s-+group\\|before\\s-+group\\|on\\s-+last\\s-\\|page\\s-\\)")
       (+ (4gl--opener-column "^\\s-*report\\s-") 4))
      ((4gl--current-line-matches-p "^\\s-*\\(on\\|after\\|before\\)\\b")
       (+ (4gl--opener-column "^\\s-*\\(input\\|construct\\|dialog\\)\\b") 4))
      ;; Default: use nearest open/close
      ((> open-line-number close-line-number) open-col)
      ((< open-line-number close-line-number) close-col)
      (t 0)))))

(defun 4gl--current-line-matches-p (regexp)
  "Return non-nil if current line matches REGEXP (case-insensitive)."
  (let ((case-fold-search t))
    (save-excursion
      (beginning-of-line)
      (looking-at regexp))))

(defun 4gl--opener-column (regexp)
  "Search backward for REGEXP and return its indentation column (case-insensitive)."
  (let ((case-fold-search t)
        (col 0))
    (save-excursion
      (beginning-of-line)
      (when (re-search-backward regexp nil t)
        (back-to-indentation)
        (setq col (current-column))))
    col))

(defun 4gl--project-root ()
  "Return the project root for 4GL files (git root or default-directory)."
  (or (locate-dominating-file default-directory ".git")
      default-directory))

(defun 4gl--xref-backend () '4gl)

(cl-defmethod xref-backend-identifier-at-point ((_backend (eql '4gl)))
  (let ((sym (thing-at-point 'symbol t)))
    (when sym (downcase sym))))

(cl-defmethod xref-backend-definitions ((_backend (eql '4gl)) identifier)
  "Find FUNCTION or REPORT definitions matching IDENTIFIER in .4gl files."
  (let* ((root (4gl--project-root))
         (default-directory root)
         (pattern (format "^[[:space:]]*(function|report)[[:space:]]+%s[[:space:]]*\\("
                          (shell-quote-argument identifier)))
         (output (shell-command-to-string
                  (format "git grep -inE %s -- '*.4gl'" (shell-quote-argument pattern))))
         (results nil))
    (dolist (line (split-string output "\n" t))
      (when (string-match "^\\([^:]+\\):\\([0-9]+\\):" line)
        (let ((file (expand-file-name (match-string 1 line) root))
              (lnum (string-to-number (match-string 2 line))))
          (push (xref-make
                 (format "%s in %s" identifier (match-string 1 line))
                 (xref-make-file-location file lnum 0))
                results))))
    (nreverse results)))

(defconst 4gl--doc-base-url
  "https://aubit4gl.sourceforge.net/aubit4gldoc/4glreference/pages/"
  "Base URL for Aubit 4GL / Informix 4GL reference documentation.")

(defconst 4gl--doc-pages
  '(;; Flow control
    ("call"           . "4GLREFCALL.htm")
    ("return"         . "4GLREFRETURN.htm")
    ("case"           . "4GLREFCASE.htm")
    ("continue"       . "4GLREFCONTINUE.htm")
    ("exit"           . "4GLREFEXIT.htm")
    ("for"            . "4GLREFFOR.htm")
    ("goto"           . "4GLREFGOTO.htm")
    ("if"             . "4GLREFIF.htm")
    ("label"          . "4GLREFLABEL00000450.htm")
    ("sleep"          . "4GLREFSLEEP.htm")
    ("while"          . "4GLREFWHILE.htm")
    ("end"            . "4GLREFEND.htm")
    ;; Variables and declarations
    ("define"         . "4GLREFDEFINE00000433.htm")
    ("initialize"     . "4GLREFINITIALIZE.htm")
    ("locate"         . "4GLREFLOCATE.htm")
    ("let"            . "4GLREFLET.htm")
    ("validate"       . "4GLREFVALIDATE.htm")
    ;; Program structure
    ("function"       . "4GLREFFUNCTION00000443.htm")
    ("main"           . "4GLREFMAIN.htm")
    ("globals"        . "4GLREFGLOBALS.htm")
    ("report"         . "4GLREFREPORT00000465.htm")
    ("run"            . "4GLREFRUN00000467.htm")
    ("defer"          . "4GLREFDEFER.htm")
    ("whenever"       . "4GLREFWHENEVER.htm")
    ;; Database
    ("database"       . "4GLREFDATABASE00000431.htm")
    ;; Cursors and SQL
    ("foreach"        . "4GLREFFOREACH.htm")
    ;; UI / Forms
    ("clear"          . "4GLREFCLEAR.htm")
    ("close form"     . "4GLREFCLOSE_FORM.htm")
    ("close window"   . "4GLREFCLOSE_WINDOW.htm")
    ("construct"      . "4GLREFCONSTRUCT.htm")
    ("current window" . "4GLREFCURRENT_WINDOW.htm")
    ("display"        . "4GLREFDISPLAY.htm")
    ("display array"  . "4GLREFDISPLAY_ARRAY.htm")
    ("display form"   . "4GLREFDISPLAY_FORM.htm")
    ("error"          . "4GLREFERROR00000438.htm")
    ("input"          . "4GLREFINPUT.htm")
    ("input array"    . "4GLREFINPUT_ARRAY.htm")
    ("menu"           . "4GLREFMENU00000455.htm")
    ("message"        . "4GLREFMESSAGE.htm")
    ("open form"      . "4GLREFOPEN_FORM.htm")
    ("open window"    . "4GLREFOPEN_WINDOW.htm")
    ("options"        . "4GLREFOPTIONS.htm")
    ("prompt"         . "4GLREFPROMPT.htm")
    ("scroll"         . "4GLREFSCROLL.htm")
    ;; Report
    ("finish report"  . "4GLREFFINISH_REPORT.htm")
    ("output to report" . "4GLREFOUTPUT_TO_REPORT.htm")
    ("start report"   . "4GLREFSTART_REPORT.htm")
    ("need"           . "4GLREFNEED00000457.htm")
    ("pause"          . "4GLREFPAUSE00000462.htm")
    ("print"          . "4GLREFPRINT00000463.htm")
    ("skip"           . "4GLREFSKIP00000469.htm"))
  "Alist mapping 4GL keywords (lowercase) to Aubit 4GL reference page filenames.")

(defun 4gl-lookup-docs (keyword)
  "Look up documentation for a 4GL KEYWORD.
With point on a keyword, opens the Aubit 4GL reference in the browser.
Falls back to a site search for keywords not in the lookup table."
  (interactive
   (list (let ((sym (thing-at-point 'symbol t)))
           (read-string (format-prompt "4GL keyword" sym)
                        nil nil sym))))
  (let* ((kw (downcase (string-trim keyword)))
         (page (cdr (assoc kw 4gl--doc-pages))))
    (browse-url
     (if page
         (concat 4gl--doc-base-url page)
       (format "https://google.com/search?q=site:aubit4gl.sourceforge.net+Informix+4GL+%s"
               (url-hexify-string kw))))))

(defun 4gl--electric-reindent ()
  "Reindent the current line after typing a dedent keyword like else or end."
  (when (eq major-mode '4gl-mode)
    (let ((case-fold-search t))
      (save-excursion
        (beginning-of-line)
        (when (looking-at "^\\s-*\\(else\\|end\\s-\\|when\\b\\)")
          (4gl-indent))))))

(define-derived-mode 4gl-mode prog-mode "4gl"
  :syntax-table 4gl-mode-syntax-table
  (setq-local font-lock-defaults '(4gl-keywords nil t))
  (setq-local comment-start "# ")
  (setq-local comment-end "")
  (setq-local tab-width 4)
  (setq-local indent-tabs-mode t)
  (setq-local indent-line-function #'4gl-indent)
  (add-hook 'post-self-insert-hook #'4gl--electric-reindent nil t)
  (add-hook 'xref-backend-functions #'4gl--xref-backend nil t)
  (keymap-local-set "C-c C-d" #'4gl-lookup-docs))

(add-to-list 'auto-mode-alist '("\\.4gl\\'" . 4gl-mode))
(add-to-list 'auto-mode-alist '("\\.per\\'" . 4gl-mode))

(provide '4gl-mode)
