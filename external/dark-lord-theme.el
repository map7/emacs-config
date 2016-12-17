;;; Commentary:
;;
;; A dark theme inspired from zerodark.
;;

;;; Code:

(require 'all-the-icons)

(defmacro cached-for (secs &rest body)
  "Cache for SECS the result of the evaluation of BODY."
  (declare (debug t))
  (let ((cache (make-symbol "cache"))
        (last-run (make-symbol "last-run")))
    `(let (,cache ,last-run)
       (lambda ()
         (when (or (null ,last-run)
                   (> (- (time-to-seconds (current-time)) ,last-run)
                      ,secs))
           (setf ,cache (progn ,@body))
           (setf ,last-run (time-to-seconds (current-time))))
         ,cache))))

(deftheme dark-lord
  "A dark medium contrast theme")

(defgroup dark-lord
  nil
  "A dark theme inspired from zerodark.")

(defcustom dark-lord-use-paddings-in-mode-line t
  "When non-nil, use top and bottom paddings in the mode-line."
  :type 'boolean
  :group 'dark-lord)

(defface dark-lord-ro-face
  '((t :foreground "#0088CC" :weight bold))
  "Face for read-only buffer in the mode-line.")

(defface dark-lord-modified-face
  '((t :foreground "#ff6c6b" :height 0.9))
  "Face for modified buffers in the mode-line.")

(defface dark-lord-not-modified-face
  '((t :foreground "#98be65" :height 0.9))
  "Face for not modified buffers in the mode-line.")

(defface dark-lord-buffer-position-face
  '((t :height 0.9))
  "Face for line/column numbers in the mode-line.")

(defface dark-lord-vc-face
  '((t :foreground "#61afef"))
  "Face for vc status in the mode-line.")

(defface dark-lord-ok-face
  '((t :foreground "#61afef"))
  "Face for ok status in the mode-line.")

(defface dark-lord-warning-face
  '((t :foreground "#da8548"))
  "Face for warning status in the mode-line.")

(defface dark-lord-error-face
  '((t :foreground "#ff6c6b"))
  "Face for error status in the mode-line.")

(defvar dark-lord-modeline-position '(:eval (propertize ":%l:%c %p " 'face (if (dark-lord--active-window-p)
                                                                              'dark-lord-buffer-position-face
                                                                            'mode-line-inactive)))
  "Mode line construct for displaying the position in the buffer.")

(defvar dark-lord-modeline-buffer-identification '(:eval (propertize "%b" 'face 'bold))
  "Mode line construct for displaying the position in the buffer.")

(defvar dark-lord-modeline-modified '(:eval (if (buffer-modified-p (current-buffer))
                                               (all-the-icons-faicon "floppy-o"
                                                                     :height 0.9
                                                                     :v-adjust 0
                                                                     :face (if (dark-lord--active-window-p)
                                                                               'dark-lord-modified-face
                                                                             'mode-line-inactive))
                                             (all-the-icons-faicon "check"
                                                                   :height 0.9
                                                                   :v-adjust 0
                                                                   :face (if (dark-lord--active-window-p)
                                                                             'dark-lord-not-modified-face
                                                                           'mode-line-inactive)))))

(defvar dark-lord-modeline-ro '(:eval (if buffer-read-only
                                         (if (dark-lord--active-window-p)
                                             (progn
                                               (propertize "RO " 'face 'dark-lord-ro-face))
                                           (propertize "RO " 'face 'bold))
                                       "")))

(defvar dark-lord-buffer-coding '(:eval (unless (eq buffer-file-coding-system (default-value 'buffer-file-coding-system))
                                         mode-line-mule-info)))

(defvar dark-lord-modeline-vc '(vc-mode ("   "
                                        (:eval (all-the-icons-faicon "code-fork"
                                                                     :height 0.9
                                                                     :v-adjust 0
                                                                     :face (when (dark-lord--active-window-p)
                                                                             (dark-lord-git-face))))
                                        (:eval (propertize (truncate-string-to-width vc-mode 25 nil nil "...")
                                                           'face (when (dark-lord--active-window-p)
                                                                   (dark-lord-git-face)))))))

(defun dark-lord-modeline-flycheck-status ()
  "Return the status of flycheck to be displayed in the mode-line."
  (when flycheck-mode
    (let* ((text (pcase flycheck-last-status-change
                   (`finished (if flycheck-current-errors
                                  (let ((count (let-alist (flycheck-count-errors flycheck-current-errors)
                                                 (+ (or .warning 0) (or .error 0)))))
                                    (propertize (format "✖ %s Issue%s" count (if (eq 1 count) "" "s"))
                                                'face (dark-lord-face-when-active 'dark-lord-error-face)))
                                (propertize "✔ No Issues"
                                            'face (dark-lord-face-when-active 'dark-lord-ok-face))))
                   (`running     (propertize "⟲ Running"
                                             'face (dark-lord-face-when-active 'dark-lord-warning-face)))
                   (`no-checker  (propertize "⚠ No Checker"
                                             'face (dark-lord-face-when-active 'dark-lord-warning-face)))
                   (`not-checked "✖ Disabled")
                   (`errored     (propertize "⚠ Error"
                                             'face (dark-lord-face-when-active 'dark-lord-error-face)))
                   (`interrupted (propertize "⛔ Interrupted"
                                             'face (dark-lord-face-when-active 'dark-lord-error-face)))
                   (`suspicious  ""))))
      (propertize text
                  'help-echo "Show Flycheck Errors"
                  'local-map (make-mode-line-mouse-map
                              'mouse-1 #'flycheck-list-errors)))))

(defun true-color-p ()
  "Return non-nil on displays that support 256 colors."
  (or
   (display-graphic-p)
   (= (tty-display-color-cells) 16777216)))

(defvar dark-lord--git-face-cached (cached-for 1 (dark-lord--git-face-intern)))

(defun dark-lord--git-face-intern ()
  "Return the face to use based on the current repository status."
  (if (magit-git-success "diff" "--quiet")
      ;; nothing to commit because nothing changed
      (if (zerop (length (magit-git-string
                          "rev-list" (concat "origin/"
                                             (magit-get-current-branch)
                                             ".."
                                             (magit-get-current-branch)))))
          ;; nothing to push as well
          'dark-lord-ok-face
        ;; nothing to commit, but some commits must be pushed
        'dark-lord-warning-face)
    'dark-lord-error-face))

(defun dark-lord-git-face ()
  "Return the face to use based on the current repository status.
The result is cached for one second to avoid hiccups."
  (funcall dark-lord--git-face-cached))


(let ((class '((class color) (min-colors 89)))

      ;; Backgrounds
      (background (if (true-color-p) "#000000" "#000000"))
      (background-dark (if (true-color-p) "#24282f" "#222222"))
      (background-darker (if (true-color-p) "#22252c" "#222222"))
      (background-lighter (if (true-color-p) "#3a3f4b" "#5f5f5f"))
      (background-red (if (true-color-p) "#4c3840" "#5f5f5f"))
      (bright-background-red (if (true-color-p) "#744a5b" "#744a5b"))
      (background-blue (if (true-color-p) "blue1" "blue1"))
      (background-navyblue (if (true-color-p) "navyblue" "navyblue"))
      (bright-background-blue (if (true-color-p) "blue" "blue"))
      (background-green (if (true-color-p) "#3d4a41" "#5f5f5f"))
      (bright-background-green (if (true-color-p) "#3f6d54" "#3f6d54"))
      (background-orange (if (true-color-p) "#4a473d" "#5f5f5f"))
      
      ;; Modeline
      (mode-line-inactive (if "#1c2129" "#222222"))
      (mode-line-active (if (true-color-p) "#6f337e" "#875f87"))

      ;; Line Highlight
      (hl-line (if (true-color-p) "#2c323b" "#333333"))

      ;; White - Default font color
      (default (if (true-color-p) "#ffffff" "#ffffff"))
      (white (if (true-color-p) "#ffffff" "#ffffff"))

      ;; Grey Shades
      (anthracite (if (true-color-p) "#3a3f4b" "#3a3f4b"))
      (frost (if (true-color-p) "#cccccc" "#cccccc"))
      (grey (if (true-color-p) "#cccccc" "#cccccc"))
      (grey-dark (if (true-color-p) "#666666" "#666666"))
      
      (highlight (if (true-color-p) "#3e4451" "#5f5f5f"))

      ;; Red Shades
      (red (if (true-color-p) "#ee0000" "#ee0000"))
      (pink (if (true-color-p) "#ff87ba" "#ff87ba"))
      
      ;; Orange Shades
      (comment (if (true-color-p) "chocolate1" "#707070"))
      (orange (if (true-color-p) "orange1" "#d7875f"))
      (orange-light (if (true-color-p) "#ddbd78" "#d7af87"))
      (peach "PeachPuff3")
      
      ;; Yellow Shades
      (yellow (if (true-color-p) "yellow2" "yellow2"))
      (sunrise (if (true-color-p) "#ffdb45" "#ffdb45"))
      
      ;; Green Shades
      (green (if (true-color-p) "chartreuse" "chartreuse"))
      (green-light (if (true-color-p) "#b3de81" "#b3de81"))

      ;; Blue Shades
      (cyan (if (true-color-p) "cyan" "cyan"))
      (blue-light (if (true-color-p) "LightSkyblue1" "LightSkyblue1"))
      (light (if (true-color-p) "#ccd4e3" "#d7d7d7"))
      (blue-dodgerblue (if (true-color-p) "dodgerblue1" "dodgerblue1"))

      ;; Diffs
      (diff-added-background (if (true-color-p) "#284437" "#284437"))
      (diff-added-refined-background (if (true-color-p) "#1e8967" "#1e8967"))
      (diff-removed-background (if (true-color-p) "#583333" "#580000"))
      (diff-removed-refined-background (if (true-color-p) "#b33c49" "#b33c49"))
      (diff-current-background (if (true-color-p) "#29457b" "#29457b"))
      (diff-current-refined-background (if (true-color-p) "#4174ae" "#4174ae")))
  
  (custom-theme-set-faces
   'dark-lord
   `(default ((,class (:background ,background :foreground ,default))))
   `(cursor ((,class (:background ,default))))

   ;; Highlighting faces
   `(fringe ((,class (:background ,background-dark :foreground ,comment))))
   `(border ((,class (:foreground ,background-lighter))))
   `(vertical-border ((,class (:foreground ,background-lighter))))
   `(highlight ((,class (:background ,highlight :foreground ,default :underline nil))))
   `(region ((,class (:background ,highlight :foreground ,default))))
   `(secondary-selection ((,class (:background ,highlight :foreground ,default))))
   `(isearch ((,class (:background ,orange-light :foreground ,highlight))))
   `(lazy-highlight ((,class (:background ,grey-dark :foreground ,orange-light))))
   `(hl-line ((,class (:background ,hl-line :underline unspecified :inherit nil))))

   `(match ((,class (:background ,background-green))))

   ;; Font lock faces
   `(font-lock-builtin-face ((,class (:foreground ,red))))
   `(font-lock-comment-face ((,class (:foreground ,comment))))
   `(font-lock-constant-face ((,class (:foreground ,blue-dodgerblue))))
   `(font-lock-function-name-face ((,class (:foreground ,yellow))))
   `(font-lock-keyword-face ((,class (:foreground ,cyan))))
   `(font-lock-string-face ((,class (:foreground ,orange))))
   `(font-lock-doc-face ((,class (:foreground ,orange))))
   `(font-lock-type-face ((,class (:foreground ,cyan))))
   `(font-lock-variable-name-face ((,class (:foreground ,white))))
   `(font-lock-warning-face ((,class (:foreground ,red :weight bold :background ,background-red))))

   ;; Mode line faces
      `(mode-line ((,class (:background ,background-darker :height 0.9 :foreground ,white
                                     :box ,(when dark-lord-use-paddings-in-mode-line
                                              (list :line-width 6 :color background-darker))))))
      `(mode-line-inactive ((,class (:background ,background-darker :height 0.9 :foreground ,grey-dark
                                                 :box ,(when dark-lord-use-paddings-in-mode-line
                                                         (list :line-width 6 :color background-darker))))))
      `(header-line ((,class (:inherit mode-line-inactive))))

   ;; error & success
   `(error ((,class (:foreground ,red :weight bold))))
   `(warning ((,class (:foreground ,orange :weight bold))))
   `(success ((,class (:foreground ,green :weight bold))))

   ;; powerline
   `(powerline-active1 ((,class (:height 0.9 :foreground ,white :background ,background-darker))))
   `(powerline-active2 ((,class (:height 0.9 :foreground ,white :background ,background-lighter))))

   ;; mml
   `(message-mml-face ((,class (:foreground ,comment))))

   ;; Org-clock mode line
   `(org-mode-line-clock ((,class (:background unspecified (:inherit mode-line)))))

   ;; Escape and prompt faces
   `(minibuffer-prompt ((,class (:foreground ,cyan :weight bold))))
   `(escape-glyph ((,class (:foreground ,cyan :weight bold))))

   ;; linum
   `(linum ((,class (:foreground ,grey :background ,background))))
   ;; from hlinum
   `(linum-highlight-face ((,class (:foreground ,cyan ,background ,background-navyblue))))

   ;; eshell
   `(eshell-prompt ((,class (:foreground ,orange :background ,background :weight bold))))
   `(eshell-ls-directory ((,class (:foreground ,cyan :background ,background :weight bold))))
   `(eshell-ls-symlink ((,class (:foreground ,orange :background ,background :weight normal))))
   `(eshell-ls-executable ((,class (:foreground ,green :background ,background :weight bold))))

   ;; whitespace
   `(whitespace-space ((,class (:background unspecified :foreground ,highlight
                                            :inverse-video unspecified))))
   `(whitespace-hspace ((,class (:background unspecified :foreground ,highlight
                                             :inverse-video unspecified))))
   `(whitespace-tab ((,class (:background unspecified :foreground ,highlight
                                          :inverse-video unspecified))))
   `(whitespace-newline ((,class (:background unspecified :foreground ,highlight
                                              :inverse-video unspecified))))
   `(whitespace-trailing ((,class (:background ,red :foreground ,background :weight bold
                                               :inverse-video nil))))
   `(whitespace-line ((,class (:background unspecified :foreground ,red
                                           :inverse-video unspecified))))
   `(whitespace-space-before-tab ((,class (:inherit whitespace-space))))
   `(whitespace-space-after-tab ((,class (:inherit whitespace-space))))
   `(whitespace-indentation ((,class (:background unspecified :foreground ,highlight
                                                  :inverse-video unspecified))))
   `(whitespace-empty ((,class (:background ,orange :foreground ,highlight
                                            :inverse-video unspecified))))

   ;; link faces
   `(link ((,class (:foreground ,cyan :underline t))))
   `(link-visited ((,class (:foreground ,cyan :underline t))))

   ;; widget faces
   `(widget-field ((,class (:background ,highlight :box (:line-width 1 :color ,comment)))))
   `(widget-button ((,class (:inherit link))))

   ;; custom
   `(custom-button ((,class (:background ,background-lighter :box (:line-width 2 :style released-button)))))
   `(custom-button-mouse ((,class (:background ,highlight :box (:line-width 2 :style released-button)))))
   `(custom-button-pressed ((,class (:background ,highlight :box (:line-width 2 :style pressed-button)))))
   `(custom-group-tag ((,class (:foreground ,cyan :weight bold :height 1.4))))
   `(custom-variable-tag ((,class (:foreground ,cyan :weight bold))))
   `(custom-state ((,class (:foreground ,green))))

   ;; compilation
   `(compilation-info ((,class (:foreground ,cyan :weight bold))))
   `(compilation-warning ((,class (:foreground ,orange :weight bold))))
   `(compilation-error ((,class (:foreground ,red :weight bold))))
   `(compilation-line-number ((,class (:foreground ,green :weight bold))))
   `(compilation-mode-line-exit ((,class (:foreground ,green :weight bold :inverse-video nil))))
   `(compilation-mode-line-run ((,class (:foreground ,orange :weight bold))))
   `(compilation-mode-line-fail ((,class (:foreground ,red :weight bold))))

   ;; dired
   `(dired-directory ((,class (:foreground ,cyan :weight bold))))
   `(dired-git-face ((,class (:foreground ,red))))
   `(dired-ignored ((,class (:foreground ,anthracite))))
   `(dired-filetype-omit ((,class (:foreground ,anthracite))))
   `(dired-filetype-common ((,class (:foreground ,orange))))
   `(dired-filetype-execute ((,class (:foreground ,green-light))))
   `(dired-filetype-source ((,class (:foreground ,yellow))))
   `(dired-filetype-plain ((,class (:foreground ,comment))))
   `(dired-filetype-link ((,class (:foreground ,blue-light :underline t))))
   `(dired-flagged ((,class (:foreground ,red :underline t))))
   `(dired-marked ((,class (:foreground ,orange :underline t))))
   `(dired-subtree-depth-1-face ((,class (:background ,grey))))
   `(dired-subtree-depth-2-face ((,class (:background ,grey-dark))))
   `(dired-subtree-depth-3-face ((,class (:background ,background))))

   ;;; dired+
   `(diredp-dir-heading ((,class (:foreground ,red))))
   `(diredp-dir-name ((,class (:foreground ,blue-light))))
   `(diredp-file-name ((,class (:foreground ,white))))
   `(diredp-file-suffix ((,class (:foreground ,frost))))
   `(diredp-ignored-file-name ((,class (:foreground ,comment))))
   `(diredp-symlink ((,class (:foreground ,pink))))
   `(diredp-number ((,class (:foreground ,orange))))

   ;; diff
   `(diff-removed ((,class (:background ,background-red :foreground ,red))))
   `(diff-added ((,class (:background ,background-green :foreground ,green))))
   `(diff-hunk-header ((,class (:background ,background-navyblue :weight bold :foreground ,cyan))))
   `(diff-file-header ((,class (:weight bold))))
   `(diff-header ((,class (:background ,background :foreground ,cyan))))
   `(diff-context ((,class (:foreground ,default))))
   `(diff-refine-added ((,class (:foreground ,green :background ,bright-background-green))))
   `(diff-refine-removed ((,class (:background ,bright-background-red :foreground ,red))))

   ;; ediff
   `(ediff-fine-diff-B ((,class (:inherit diff-refine-added))))
   `(ediff-current-diff-B ((,class (:inherit diff-added))))
   `(ediff-fine-diff-A ((,class (:inherit diff-refine-removed))))
   `(ediff-current-diff-A ((,class (:inherit diff-removed))))
   `(ediff-fine-diff-C ((,class (:foreground ,cyan :background ,bright-background-blue))))
   `(ediff-current-diff-C ((,class (:background ,background-navyblue :foreground ,cyan))))

   ;; magit
   `(magit-diff-context-highlight ((,class (:background ,background))))
   `(magit-diff-file-heading ((,class (:weight bold :foreground ,cyan))))
   `(magit-diff-file-heading-highlight ((,class (:weight bold :foreground ,cyan :background ,background-navyblue))))
   `(magit-diff-removed-highlight ((,class (:inherit diff-removed))))
   `(magit-diff-removed ((,class (:inherit diff-removed))))
   `(magit-diff-added-highlight ((,class (:inherit diff-added))))
   `(magit-diff-added ((,class (:inherit diff-added))))
   `(magit-diff-lines-heading ((,class (:background ,blue-dodgerblue :foreground ,white))))
   `(magit-diff-hunk-heading ((,class (:background ,background-lighter))))
   `(magit-diff-hunk-heading-highlight ((,class (:background ,blue-dodgerblue))))
   `(magit-diff-hunk-heading ((,class (:background ,background-lighter))))

   `(magit-process-ok ((,class (:foreground ,green :weight bold))))

   `(magit-section-highlight ((,class (:background ,background))))
   `(magit-section-heading ((,class (:foreground ,grey :weight bold))))
   `(magit-branch-current ((,class (:foreground ,cyan :background ,background :box 1))))
   `(magit-branch-local ((,class (:foreground ,orange :background ,background :box 1))))
   `(magit-branch-remote ((,class (:foreground ,green :background ,background :box 1))))

   `(magit-reflog-reset ((,class (:background ,background-red :foreground ,red :weight bold))))
   `(magit-reflog-amend ((,class (:background ,background-navyblue :foreground ,cyan :weight bold))))
   `(magit-reflog-rebase ((,class (:background ,background-navyblue :foreground ,cyan :weight bold))))
   `(magit-reflog-commit ((,class (:background ,background-green :foreground ,green :weight bold))))
   `(magit-reflog-checkout ((,class (:background ,background-orange :foreground ,orange :weight bold))))
   `(magit-reflog-cherry-pick ((,class (:background ,background-blue :foreground ,cyan :weight bold))))

   `(magit-bisect-bad ((,class (:background ,background-red :foreground ,red :box 1))))
   `(magit-bisect-good ((,class (:background ,background-navyblue :foreground ,cyan :box 1))))

   `(magit-blame-heading ((,class (:foreground ,green :background ,background-green :box 1))))

   `(git-commit-summary ((,class (:weight bold))))

   `(magit-tag ((,class (:foreground ,cyan :weight bold :box 1 :background "#202020"))))
   `(magit-sequence-part ((,class (:foreground ,orange :weight bold))))
   `(magit-sequence-head ((,class (:foreground ,green :weight bold))))

   ;; Message faces
   `(message-header-name ((,class (:foreground ,cyan :weight bold))))
   `(message-header-cc ((,class (:foreground ,cyan))))
   `(message-header-other ((,class (:foreground ,cyan))))
   `(message-header-subject ((,class (:foreground ,green))))
   `(message-header-to ((,class (:foreground ,cyan))))
   `(message-cited-text ((,class (:foreground ,comment))))
   `(message-separator ((,class (:foreground ,red :weight bold))))

   ;; ido faces
   `(ido-first-match ((,class (:foreground ,orange :weight bold))))
   `(ido-only-match ((,class (:foreground ,orange :weight bold))))
   `(ido-subdir ((,class (:foreground ,blue-dodgerblue :weight bold))))
   `(ido-vertical-match-face ((,class (:foreground ,blue-light))))

   ;; notmuch
   `(notmuch-message-summary-face ((,class (:background ,highlight :box (:line-width 2 :color ,background)))))
   `(notmuch-search-count ((,class (:foreground ,red :weight bold))))
   `(notmuch-search-matching-authors ((,class (:foreground ,comment))))
   `(notmuch-search-subject ((,class (:foreground ,default))))
   `(notmuch-search-unread-face ((,class (:weight bold))))
   `(notmuch-search-date ((,class (:foreground ,cyan))))
   `(notmuch-crypto-part-header ((,class (:foreground ,cyan))))
   `(notmuch-crypto-decryption ((,class (:foreground ,cyan))))
   `(notmuch-crypto-signature-unknown ((,class (:foreground ,red))))
   `(notmuch-crypto-signature-good ((,class (:background ,cyan :foreground ,background :weight bold))))
   `(notmuch-crypto-signature-good-key ((,class (:background ,cyan :foreground ,background :weight bold))))
   `(notmuch-crypto-signature-bad ((,class (:background ,red :foreground ,background :weight bold))))
   `(notmuch-tag-face ((,class (:foreground ,green :weight bold))))
   `(notmuch-tree-match-author-face ((,class (:foreground ,cyan))))
   `(notmuch-tree-match-tag-face ((,class (:foreground ,green :weight bold))))

   ;; company
   `(company-preview ((,class (:background ,background-darker :foreground ,default))))
   `(company-preview-common ((,class (:background ,background-darker :foreground ,blue-light))))
   `(company-preview-search ((,class (:background ,cyan :foreground ,default))))
   `(company-tooltip ((,class (:background ,background-darker :foreground ,default))))
   `(company-scrollbar-bg ((,class (:background ,background-darker))))
   `(company-scrollbar-fg ((,class (:background ,background-navyblue))))
   `(company-tooltip-common ((,class (:foreground ,blue-light :weight bold :background ,background-darker))))
   `(company-tooltip-annotation ((,class (:foreground ,cyan :weight bold :background ,background-navyblue))))
   `(company-tooltip-common-selection ((,class (:foreground ,blue-dodgerblue :background ,background-lighter :weight bold))))
   `(company-tooltip-selection ((,class (:foreground ,default :background ,background-lighter))))
   `(company-tooltip-mouse ((,class (:foreground ,default :background ,background-lighter))))

   ;; web-mode
   `(web-mode-html-tag-face ((,class (:foreground ,blue-dodgerblue :weight bold))))
   `(web-mode-symbol-face ((,class (:foreground ,red :weight bold))))

   ;; js2-mode
   `(js2-function-param ((,class (:foreground ,cyan))))
   `(js2-error ((,class (:foreground ,red))))

   ;; flycheck
   `(flycheck-fringe-error ((,class (:foreground ,red :background ,background-red :weight bold :inverse-video t))))
   `(flycheck-fringe-warning ((,class (:background ,background-orange :foreground ,orange :weight bold :inverse-video t))))
   `(flycheck-fringe-info ((,class (:background ,background-navyblue :foreground ,cyan :weight bold :inverse-video t))))
   `(flycheck-warning ((,class (:underline (:color ,red :style wave)))))
   `(flycheck-error ((,class (:underline (:color ,red :style wave)))))

   ;; FIC
   `(font-lock-fic-face ((,class (:foreground ,background :background ,red :weight bold))))

   ;; Org-Mode
   `(org-todo ((,class (:foreground ,red))))
   `(org-done ((,class (:foreground ,green))))
   `(org-hide ((,class (:foreground ,anthracite))))
   `(org-link ((,class (:foreground ,cyan :underline t))))
   `(org-date ((,class (:foreground ,comment))))
   `(org-block-begin-line ((,class (:foreground ,sunrise))))
   `(org-block-background ((,class (:background ,background))))
   `(org-block-end-line ((,class (:foreground ,sunrise))))
   `(org-tag ((,class (:foreground ,anthracite))))
   `(org-special-keyword ((,class (:foreground ,sunrise))))
   `(org-priority ((,class (:foreground ,comment))))
   `(org-level-1 ((,class (:foreground ,blue-dodgerblue :weight bold))))
   `(org-level-2 ((,class (:foreground ,red :weight bold))))
   `(org-level-3 ((,class (:foreground ,orange :weight bold))))
   `(org-ellipsis ((,class (:foreground ,frost))))

   ;; Gnus faces -- from wombat, feel free to improve :)
   `(gnus-group-news-1 ((,class (:weight bold :foreground "#95e454"))))
   `(gnus-group-news-1-low ((,class (:foreground "#95e454"))))
   `(gnus-group-news-2 ((,class (:weight bold :foreground "#cae682"))))
   `(gnus-group-news-2-low ((,class (:foreground "#cae682"))))
   `(gnus-group-news-3 ((,class (:weight bold :foreground "#ccaa8f"))))
   `(gnus-group-news-3-low ((,class (:foreground "#ccaa8f"))))
   `(gnus-group-news-4 ((,class (:weight bold :foreground "#99968b"))))
   `(gnus-group-news-4-low ((,class (:foreground "#99968b"))))
   `(gnus-group-news-5 ((,class (:weight bold :foreground "#cae682"))))
   `(gnus-group-news-5-low ((,class (:foreground "#cae682"))))
   `(gnus-group-news-low ((,class (:foreground "#99968b"))))
   `(gnus-group-mail-1 ((,class (:weight bold :foreground "#95e454"))))
   `(gnus-group-mail-1-low ((,class (:foreground "#95e454"))))
   `(gnus-group-mail-2 ((,class (:weight bold :foreground "#cae682"))))
   `(gnus-group-mail-2-low ((,class (:foreground "#cae682"))))
   `(gnus-group-mail-3 ((,class (:weight bold :foreground "#ccaa8f"))))
   `(gnus-group-mail-3-low ((,class (:foreground "#ccaa8f"))))
   `(gnus-group-mail-low ((,class (:foreground "#99968b"))))
   `(gnus-header-content ((,class (:foreground "#8ac6f2"))))
   `(gnus-header-from ((,class (:weight bold :foreground "#95e454"))))
   `(gnus-header-subject ((,class (:foreground "#cae682"))))
   `(gnus-header-name ((,class (:foreground "#8ac6f2"))))
   `(gnus-header-newsgroups ((,class (:foreground "#cae682"))))

   ;; which-function
   `(which-func ((,class (:foreground ,blue-light))))

   `(ediff-even-diff-A ((,class (:background ,highlight :foreground unspecified))))
   `(ediff-even-diff-B ((,class (:background ,highlight :foreground unspecified))))
   `(ediff-even-diff-C ((,class (:background ,highlight :foreground unspecified))))
   `(ediff-odd-diff-A ((,class (:background ,highlight :foreground unspecified))))
   `(ediff-odd-diff-B ((,class (:background ,highlight :foreground unspecified))))
   `(ediff-odd-diff-C ((,class (:background ,highlight :foreground unspecified))))

   ;; ivy
   `(ivy-current-match ((,class (:background ,background-blue :weight bold :foreground ,cyan))))
   `(ivy-minibuffer-match-face-1 ((,class (:foreground ,orange))))
   `(ivy-minibuffer-match-face-2 ((,class (:foreground ,green))))
   `(ivy-minibuffer-match-face-3 ((,class (:foreground ,orange))))
   `(ivy-minibuffer-match-face-4 ((,class (:foreground ,green))))
   `(ivy-match-required-face ((,class (:foreground ,red :background ,background-red :weight bold))))
   `(ivy-modified-buffer ((,class (:foreground ,red))))
   `(ivy-remote ((,class (:foreground ,cyan))))

   ;; helm
   `(helm-candidate-number ((,class (:weight bold))))
   `(helm-header-line-left-margin ((,class (:weight bold :foreground ,red))))
   `(helm-source-header ((,class (:height 1.2 :weight bold :foreground ,cyan :background ,background-navyblue))))
   `(helm-selection ((,class (:background ,background-lighter))))
   `(helm-match ((,class (:foreground ,cyan :background ,background-blue :weight bold))))
   `(helm-match-item ((,class (:inherit isearch))))
   `(helm-M-x-key ((,class (:foreground ,cyan :weight bold :background ,background-navyblue))))
   `(helm-visible-mark ((,class (:weight bold :foreground ,orange :background ,background-darker))))
   `(helm-prefarg ((,class (:weight bold :foreground ,red :background ,background-red))))
   `(helm-separator ((,class (:weight bold :foreground , blue-dodgerblue))))

   `(helm-grep-file ((,class ())))
   `(helm-grep-finish ((,class (:foreground ,green))))
   `(helm-grep-running ((,class (:foreground ,red))))
   `(helm-grep-lineno ((,class (:foreground ,cyan))))
   `(helm-grep-match ((,class (:foreground ,cyan :background ,background-blue :weight bold))))

   `(helm-moccur-buffer ((,class ())))

   `(helm-buffer-directory ((,class (:foreground ,cyan))))
   `(helm-buffer-file ((,class ())))
   `(helm-buffer-process ((,class (:foreground ,cyan))))
   `(helm-buffer-size ((,class (:foreground ,cyan))))
   `(helm-buffer-saved-out ((,class (:foreground ,red :weight bold))))

   `(helm-ff-directory ((,class (:foreground ,cyan))))
   `(helm-ff-dotted-directory ((,class (:foreground ,cyan))))
   `(helm-ff-prefix ((,class (:weight bold :foreground ,red))))
   `(helm-ff-file ((,class ())))
   `(helm-ff-executable ((,class (:foreground ,green :weight bold :background ,background-green))))
   `(helm-ff-symlink ((,class (:foreground ,orange))))
   `(helm-ff-invalid-symlink ((,class (:foreground ,red :weight bold :background ,background-red))))
   `(helm-history-deleted ((,class (:foreground ,red :weight bold :background ,background-red))))

   ;; visible mark
   `(visible-mark-face1 ((,class (:foreground ,orange-light :inverse-video t))))
   `(visible-mark-face2 ((,class (:foreground ,peach :inverse-video t))))

   ;; show-paren
   `(show-paren-match ((,class (:background ,blue-dodgerblue))))

   ;; clojure
   `(clojure-keyword-face ((,class (:inherit font-lock-builtin-face))))

   ;; ledger
   `(ledger-font-report-clickable-face ((,class (:foreground ,cyan))))
   `(ledger-font-posting-amount-face ((,class (:foreground ,cyan))))
   `(ledger-font-posting-date-face ((,class (:foreground ,cyan :background ,background-navyblue :box 1))))
   `(ledger-font-payee-uncleared-face ((,class (:foreground ,default :weight bold))))
   `(ledger-font-payee-cleared-face ((,class (:foreground ,green :weight bold))))
   `(ledger-font-posting-account-face ((,class (:foreground ,default))))
   `(ledger-font-posting-account-pending-face ((,class (:foreground ,red))))
   `(ledger-font-xact-highlight-face ((,class (:background ,background-darker))))
   `(ledger-font-other-face ((,class (:inherit ,font-lock-comment-face))))
   `(ledger-font-periodic-xact-face ((,class (:foreground ,orange))))

   `(diff-hl-change ((,class (:foreground ,blue-dodgerblue :background ,background-navyblue))))
   `(diff-hl-delete ((,class (:foreground ,red :background ,background-red))))
   `(diff-hl-insert ((,class (:foreground ,green :background ,background-green))))

   `(term-color-black ((,class (:foreground ,default :background ,background-darker))))
   `(term-color-red ((,class (:foreground ,red :background ,background-red))))
   `(term-color-green ((,class (:foreground ,green :background ,background-green))))
   `(term-color-yellow ((,class (:foreground ,orange :background ,background-orange))))
   `(term-color-blue ((,class (:foreground ,cyan :background ,background-navyblue))))
   `(term-color-magenta ((,class (:foreground ,cyan :background ,background-blue))))
   `(term-color-cyan ((,class (:foreground ,blue-dodgerblue))))
   `(term-color-white ((,class (:foreground ,grey))))
   `(term ((,class (:foreground ,default :background ,background))))
   `(term-default-fg-color ((,class (:inherit term-color-white))))
   `(term-default-bg-color ((,class (:inherit term-color-black))))

   `(sh-heredoc ((,class (:foreground ,orange :weight bold))))

   `(avy-lead-face ((,class :foreground ,red :background ,background-red)))
   `(avy-lead-face-0 ((,class :foreground ,cyan :background ,background-blue)))
   `(avy-lead-face-1 ((,class :foreground ,cyan :background ,background-navyblue)))
   `(avy-lead-face-2 ((,class :foreground ,green :background ,background-green)))

   `(erc-nick-default-face ((,class :foreground ,cyan :background ,background-navyblue :weight bold)))
   `(erc-current-nick-face ((,class :foreground ,red :weight bold :background ,background-red)))
   `(erc-my-nick-face ((,class :foreground ,red :weight bold :background ,background-red)))
   `(erc-notice-face ((,class :foreground ,comment)))
   `(erc-input-face ((,class :foreground ,default :weight bold)))
   `(erc-prompt-face ((,class :foreground ,cyan :background ,background-blue :weight bold :box 1)))
   `(erc-timestamp-face ((,class :foreground ,cyan :weight bold)))

   `(hydra-face-red ((,class :foreground ,red :weight bold)))
   `(hydra-face-blue ((,class :foreground ,cyan :weight bold)))

   ;; elfeed
   `(elfeed-search-date-face ((,class (:foreground ,cyan))))
   `(elfeed-search-feed-face ((,class (:foreground ,cyan))))
   `(elfeed-search-tag-face ((,class (:foreground ,green))))
   `(elfeed-search-title-face ((,class (:foreground ,cyan))))

   ;; wgrep
   `(wgrep-face ((,class (:foreground ,orange))))
   `(wgrep-reject-face ((,class (:foreground ,red :weight bold :background ,background-red))))
   `(wgrep-done-face ((,class (:foreground ,cyan :weight bold))))

   ;; AucTeX
   `(font-latex-math-face ((,class :foreground ,green-light)))
   `(font-latex-sectioning-5-face ((,class :foreground ,cyan)))
   `(font-latex-string-face ((,class :inherit font-lock-string-face)))
   `(font-latex-warning-face ((,class :inherit warning)))

   ;; Anzu

   `(anzu-replace-highlight ((,class :foreground ,red :background ,background-red :strike-through t)))
   `(anzu-replace-to ((,class :foreground ,green :background ,background-green)))
   `(anzu-match-1 ((,class :foreground ,red :background ,background-red :box t)))
   `(anzu-match-2 ((,class :foreground ,red :background ,background-red :box t)))
   `(anzu-match-3 ((,class :foreground ,red :background ,background-red :box t)))
   `(anzu-mode-line ((,class :inherit mode-line :weight bold)))

   ;; jabber.el
   `(jabber-roster-user-online ((,class :foreground ,cyan :weight bold)))
   `(jabber-roster-user-error ((,class :foreground ,red :background ,background-red :weight bold)))
   `(jabber-rare-time-face ((,class :foreground ,comment)))
   `(jabber-chat-prompt-local ((,class :foreground ,cyan :background ,background-blue :weight bold)))
   `(jabber-chat-prompt-foreign ((,class :foreground ,green :background ,background-green :weight bold)))
   `(jabber-activity-personal-face ((,class :foreground ,red :background ,background-red :weight bold)))
   `(jabber-roster-user-away ((,class :foreground ,orange)))
   `(jabber-roster-user-xa ((,class :foreground ,orange)))

   ;; ace-window
   `(aw-leading-char-face ((,class :foreground ,red :weight bold)))
   `(aw-background-face ((,class :foreground ,comment)))

   ;; paren-face.el
   `(parenthesis ((,class (:foreground ,comment))))

   ;; makefile
   `(makefile-space ((,class (:background ,background-navyblue))))

   ;; epa
   `(epa-validity-high ((,class (:foreground ,green))))
   `(epa-validity-low ((,class (:foreground ,default))))
   `(epa-validity-disabled ((,class (:foreground ,red :weight bold :background ,background-red))))
   `(epa-field-name ((,class (:foreground ,cyan :weight bold))))
   `(epa-field-body ((,class (:foreground ,orange))))
   )

  (custom-theme-set-variables
   'dark-lord
   `(ansi-color-names-vector [,background
                              ,comment
                              ,white
                              ,red
                              ,green
                              ,orange
                              ,cyan
                              ,light
                              ,blue-dodgerblue
                              ,default])))

(defun dark-lord-face-when-active (face)
  "Return FACE if the window is active."
  (when (dark-lord--active-window-p)
    face))

;; So the mode-line can keep track of "the current window"
(defvar dark-lord-selected-window nil
  "Selected window.")

(defun dark-lord--set-selected-window (&rest _)
  "Set the selected window."
  (let ((window (frame-selected-window)))
    (when (and (windowp window)
               (not (minibuffer-window-active-p window)))
      (setq dark-lord-selected-window window))))

(defun dark-lord--active-window-p ()
  "Return non-nil if the current window is active."
  (eq (selected-window) dark-lord-selected-window))

(add-hook 'window-configuration-change-hook #'dark-lord--set-selected-window)
(add-hook 'focus-in-hook #'dark-lord--set-selected-window)
(advice-add 'select-window :after #'dark-lord--set-selected-window)
(advice-add 'select-frame  :after #'dark-lord--set-selected-window)


;;;###autoload
(defun dark-lord-setup-modeline-format ()
  "Setup the mode-line format for dark-lord."
  (interactive)
  (require 'flycheck)
  (require 'magit)
  (let ((class '((class color) (min-colors 89)))
        (white (if (true-color-p) "#ffffff" "#ffffff"))
        (cyan (if (true-color-p) "cyan" "cyan"))
        (grey-dark (if (true-color-p) "#666666" "#666666"))
        (mode-line (if "#1c2129" "#222222")))
    (custom-theme-set-faces
     'dark-lord

     ;; ;; mode line faces
     `(mode-line ((,class (:background ,mode-line
                                       :height 0.9
                                       :foreground ,white
                                       :box ,(when dark-lord-use-paddings-in-mode-line
                                               (list :line-width 6 :color mode-line))))))
     `(mode-line-inactive ((,class (:background ,mode-line
                                                :height 0.9
                                                :foreground ,grey-dark
                                                :box ,(when dark-lord-use-paddings-in-mode-line
                                                        (list :line-width 6 :color mode-line))))))
     `(anzu-mode-line ((,class :inherit mode-line :foreground ,cyan :weight bold)))
  (setq-default mode-line-format
                `("%e"
                  " "
                  ,dark-lord-modeline-ro " "
                  ,dark-lord-buffer-coding
                  mode-line-frame-identification " "
                  " "
                  ,dark-lord-modeline-modified
                  " "
                  ,dark-lord-modeline-buffer-identification
                  ,dark-lord-modeline-position
                  ,dark-lord-modeline-vc
                  "  "
                  (:eval (dark-lord-modeline-flycheck-status))
                  "  " mode-line-modes mode-line-misc-info mode-line-end-spaces
                  )))

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'dark-lord)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; dark-lord-theme.el ends here
