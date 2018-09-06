;; Customizable-dark --- A dark theme that is completely customizable
;;; Commentary:
;;; Code:

(deftheme customizable-dark
  "Created 2018-09-03. A completely and easily customizable dark theme")

(custom-theme-set-faces
 'customizable-dark
 '(default ((t (:family "DejaVu Sans Mono"
                        :foundry "unknown"
                        :width normal
                        :height 106
                        :weight normal
                        :slant normal
                        :underline nil
                        :overline nil
                        :strike-through nil
                        :box nil
                        :inverse-video nil
                        :foreground "#b2af95"
                        :background "#000000"
                        :stipple nil
                        :inherit nil))))

 '(fixed-pitch ((t (:family "Monospace"))))
 '(variable-pitch ((((type w32)) (:foundry "outline" :family "Arial")) (t (:family "Sans Serif"))))
 '(escape-glyph ((t (:weight bold :foreground "cyan"))))
 '(homoglyph ((((background dark)) (:foreground "cyan"))
              (((type pc)) (:foreground "magenta")) (t (:foreground "brown"))))
 '(minibuffer-prompt ((t (:weight bold :foreground "cyan"))))
 '(highlight ((t (:underline nil :foreground "#ffffff" :background "#3e4451"))))
 '(region ((t (:foreground "#ffffff" :background "#3e4451"))))
 '(shadow ((t (:foreground "#9b9b9b"))))
 '(secondary-selection ((t (:foreground "#ffffff" :background "#3e4451"))))
 '(trailing-whitespace ((t (:background "#a52621"))))


 ;; Base fonts
 '(font-lock-comment-delimiter-face ((default (:inherit (font-lock-comment-face)))))
 '(font-lock-comment-face ((((class grayscale) (background light)) (:slant italic :weight bold :foreground "DimGray"))
                           (((class grayscale) (background dark)) (:slant italic :weight bold :foreground "LightGray"))
                           (((class color) (min-colors 88) (background light)) (:foreground "Firebrick"))
                           (((class color) (min-colors 88) (background dark)) (:foreground "chocolate1"))
                           (((class color) (min-colors 16) (background light)) (:foreground "red"))
                           (((class color) (min-colors 16) (background dark)) (:foreground "red1"))
                           (((class color) (min-colors 8) (background light)) (:foreground "red"))
                           (((class color) (min-colors 8) (background dark)) (:foreground "yellow"))
                           (t (:slant italic :weight bold))))
 '(font-lock-string-face ((t (:foreground "orange1"))))
 '(font-lock-constant-face ((t (:foreground "dodgerblue1"))))
 '(font-lock-builtin-face ((t (:foreground "#ee0000"))))
 '(font-lock-doc-face ((t (:inherit (font-lock-string-face)))))
 '(font-lock-function-name-face ((t (:foreground "yellow2"))))
 '(font-lock-keyword-face ((t (:foreground "cyan"))))
 '(font-lock-negation-char-face ((t (:foreground "#00a2f5"))))
 '(font-lock-preprocessor-face ((t (:foreground "#29b029"))))
 '(font-lock-regexp-grouping-backslash ((t (:foreground "#ae2823"))))
 '(font-lock-regexp-grouping-construct ((t (:foreground "#c9d617"))))
 '(font-lock-type-face ((t (:foreground "cyan"))))
 '(font-lock-variable-name-face ((t (:foreground "white"))))
 '(font-lock-warning-face ((t (:weight bold :foreground "#ee0000" :background "#4c3840"))))

 
 '(button ((t (:underline (:color "#b2af95" :style line) :inherit (link)))))
 '(link ((t (:underline (:color foreground-color :style line) :foreground "cyan"))))
 '(link-visited ((t (:underline (:color foreground-color :style line) :foreground "cyan"))))
 '(fringe ((t (:foreground "chocolate1" :background "#24282f"))))
 '(header-line ((t (:height 1.13 :box (:line-width 1 :color "#d6cbae" :style nil) :foreground "#d6cbae"))))
 '(tooltip ((t (:foreground "#0a7874" :background "#404040" :inherit (variable-pitch)))))

 '(isearch ((t (:foreground "#3e4451" :background "#ddbd78"))))
 '(isearch-fail ((t (:background "#86201c"))))
 '(lazy-highlight ((t (:foreground "#ddbd78" :background "#666666"))))
 '(match ((t (:foreground "#b2af95" :background "#0c325a"))))
 '(next-error ((t (:inherit (region)))))
 '(query-replace ((t (:inherit (isearch)))))

 ;; Set Emacs background colour to black
 '(add-to-list 'default-frame-alist '(foreground-color . "white"))
 '(add-to-list 'default-frame-alist '(background-color . "black"))

 ;; Modeline
 '(mode-line              ((((background light))
                            :foreground "gray" :background "#1c2129"
                            :box (:line-width 2 :color "white"))
                           (((background dark))
                            :foreground "gray" :background "#000000"
                            :box (:line-width 1 :color "gray"))))
 '(mode-line-buffer-id ((t (:weight bold :foreground "white"))))
 '(mode-line-emphasis ((t (:weight bold :background "red")))) ;; Testing this atm
 '(mode-line-highlight ((t (:weight bold ))))
 '(mode-line-inactive ((t (:foreground "#8b806c" :background "#000000" :box (:line-width 1 :color "gray20")))))

 ;; Cursor
 '(cursor ((((background light)) (:background "black")) (((background dark)) (:background "white"))))

 ;; mml
 '(message-mml-face ((t :foreground "chocolate1")))

 ;; Escape and prompt faces
 '(minibuffer-prompt ((t :foreground "cyan" :weight bold)))
 '(escape-glyph ((t :foreground "cyan" :weight bold)))

 ;; linum (code line numbering)
 '(linum ((t :foreground "#cccccc" :background "#000000")))
 ;; from hlinum
 '(linum-highlight-face ((t :foreground "cyan" :background "navyblue")))

 ;; eshell
 '(eshell-prompt ((t :foreground "orange1" :background "#000000" :weight bold)))
 '(eshell-ls-directory ((t :foreground "cyan" :background "#000000" :weight bold)))
 '(eshell-ls-symlink ((t :foreground "orange1" :background "#000000" :weight normal)))
 '(eshell-ls-executable ((t :foreground "chartreuse" :background "#000000" :weight bold)))

 ;; whitespace
 '(whitespace-space ((t :background unspecified :foreground "#3e4451"
                        :inverse-video unspecified)))
 '(whitespace-hspace ((t :background unspecified :foreground "#3e4451"
                         :inverse-video unspecified)))
 '(whitespace-tab ((t :background unspecified :foreground "#3e4451"
                      :inverse-video unspecified)))
 '(whitespace-newline ((t :background unspecified :foreground "#3e4451"
                          :inverse-video unspecified)))
 '(whitespace-trailing ((t :background "#ee0000" :foreground "#000000" :weight bold
                           :inverse-video nil)))
 '(whitespace-line ((t :background unspecified :foreground "#ee0000"
                       '                                        :inverse-video unspecified)))
 '(whitespace-space-before-tab ((t :inherit whitespace-space)))
 '(whitespace-space-after-tab ((t :inherit whitespace-space)))
 '(whitespace-indentation ((t :background unspecified :foreground "#3e4451"
                              :inverse-video unspecified)))
 '(whitespace-empty ((t :background "orange1" :foreground "#3e4451"
                        :inverse-video unspecified)))

 ;; Hyperlink faces
 '(link ((t :foreground "cyan" :underline t)))
 '(link-visited ((t :foreground "cyan" :underline t)))

 ;; widget faces
 '(widget-field ((t :background "#3e4451" :box (:line-width 1 :color "chocolate1"))))
 '(widget-button ((t :inherit link)))

 ;; custom
 '(custom-button ((t :background "#3a3f4b" :box (:line-width 2 :style released-button))))
 '(custom-button-mouse ((t :background "#3e4451" :box (:line-width 2 :style released-button))))
 '(custom-button-pressed ((t :background "#3e4451" :box (:line-width 2 :style pressed-button))))
 '(custom-group-tag ((t :foreground "cyan" :weight bold :height 1.4)))
 '(custom-variable-tag ((t :foreground "cyan" :weight bold)))
 '(custom-state ((t :foreground "chartreuse")))

 ;; Highlighting faces
 '(fringe ((t :background "#24282f" :foreground "chocolate1")))
 '(border ((t :foreground "#3a3f4b")))
 '(vertical-border ((t :foreground "#3a3f4b")))
 '(highlight ((t :background "#3e4451" :foreground "#ffffff" :underline nil)))
 '(region ((t :background "#3e4451" :foreground "#ffffff")))
 '(secondary-selection ((t :background "#3e4451" :foreground "#ffffff")))
 '(isearch ((t :background "#ddbd78" :foreground "#3e4451")))
 '(lazy-highlight ((t :background "#666666" :foreground "#ddbd78")))

 ;; error & success
 '(error ((t :foreground "#ee0000" :weight bold)))
 '(warning ((t :foreground "orange1" :weight bold)))
 '(success ((t :foreground "chartreuse" :weight bold)))

 ;; dired
 '(dired-directory ((t :foreground "cyan" :weight bold)))
 '(dired-git-face ((t :foreground "#4c3840")))
 '(dired-ignored ((t :foreground "#3a3f4b")))
 '(dired-filetype-omit ((t :foreground "#3a3f4b")))
 '(dired-filetype-common ((t :foreground "orange1")))
 '(dired-filetype-execute ((t :foreground "#b3de81")))
 '(dired-filetype-source ((t :foreground "yellow2")))
 '(dired-filetype-plain ((t :foreground "chocolate1")))
 '(dired-filetype-link ((t :foreground "LightSkyblue1" :underline t)))
 '(dired-flagged ((t :foreground "#4c3840" :underline t)))
 '(dired-marked ((t :foreground "orange1" :underline t)))
 '(dired-subtree-depth-1-face ((t :background "#cccccc")))
 '(dired-subtree-depth-2-face ((t :background "#666666")))
 '(dired-subtree-depth-3-face ((t :background "#000000")))

 ;;; dired+
 '(diredp-dir-heading ((t :foreground "#4c3840")))
 '(diredp-dir-name ((t :foreground "LightSkyblue1")))
 '(diredp-file-name ((t :foreground "white")))
 '(diredp-file-suffix ((t :foreground "#cccccc")))
 '(diredp-ignored-file-name ((t :foreground "chocolate1")))
 '(diredp-symlink ((t :foreground "#ff87ba")))
 '(diredp-number ((t :foreground "orange1")))

 ;; diff
 '(diff-removed ((t :background "#4c3840" :foreground "red")))
 '(diff-added ((t :background "#3d4a41" :foreground "chartreuse")))
 '(diff-hunk-header ((t :background "navyblue" :weight bold :foreground "cyan")))
 '(diff-file-header ((t :weight bold)))
 '(diff-header ((t :background "#000000" :foreground "cyan")))
 '(diff-context ((t :foreground "#ffffff")))
 '(diff-refine-added ((t :foreground "chartreuse" :background "#3f6d54")))
 '(diff-refine-removed ((t :background "#744a5b" :foreground "#4c3840")))

 ;; ediff
 '(ediff-fine-diff-B ((t :inherit diff-refine-added)))
 '(ediff-current-diff-B ((t :inherit diff-added)))
 '(ediff-fine-diff-A ((t :inherit diff-refine-removed)))
 '(ediff-current-diff-A ((t :inherit diff-removed)))
 '(ediff-fine-diff-C ((t :foreground "cyan" :background "blue")))
 '(ediff-current-diff-C ((t :background "navyblue" :foreground "cyan")))

 ;; Magit
 '(magit-diff-context-highlight ((t :background "#000000")))
 '(magit-diff-file-heading ((t :weight bold :foreground "cyan3")))
 '(magit-diff-file-heading-highlight ((t :weight bold :foreground "cyan3" :background "NavyBlue")))
 '(magit-diff-removed-highlight ((t :inherit diff-removed)))
 '(magit-diff-removed ((t :inherit diff-removed)))
 '(magit-diff-added-highlight ((t :inherit diff-added)))
 '(magit-diff-added ((t :inherit diff-added)))
 '(magit-diff-lines-heading ((t :background "dodgerblue1" :foreground "white")))
 '(magit-diff-hunk-heading ((t :background "#3a3f4b")))
 '(magit-diff-hunk-heading-highlight ((t :background "dodgerblue1")))
 '(magit-diff-hunk-heading ((t :background "#3a3f4b")))

 '(magit-process-ok ((t :foreground "chartreuse" :weight bold)))

 '(magit-section-highlight ((t :background "#000000")))
 '(magit-section-heading ((t :foreground "#cccccc" :weight bold)))
 '(magit-branch-current ((t :foreground "cyan" :background "#000000" :box 1)))
 '(magit-branch-local ((t :foreground "orange1" :background "#000000" :box 1)))
 '(magit-branch-remote ((t :foreground "chartreuse" :background "#000000" :box 1)))

 '(magit-reflog-reset ((t :background "#4c3840" :foreground "#4c3840" :weight bold)))
 '(magit-reflog-amend ((t :background "navyblue" :foreground "cyan" :weight bold)))
 '(magit-reflog-rebase ((t :background "navyblue" :foreground "cyan" :weight bold)))
 '(magit-reflog-commit ((t :background "#3d4a41" :foreground "chartreuse" :weight bold)))
 '(magit-reflog-checkout ((t :background "#4a473d" :foreground "orange1" :weight bold)))
 '(magit-reflog-cherry-pick ((t :background "blue1" :foreground "cyan" :weight bold)))

 '(magit-bisect-bad ((t :background "#4c3840" :foreground "#4c3840" :box 1)))
 '(magit-bisect-good ((t :background "navyblue" :foreground "cyan" :box 1)))

 '(magit-blame-heading ((t :foreground "chartreuse" :background "#3d4a41" :box 1)))

 '(git-commit-summary ((t :weight bold)))
 '(git-commit-known-pseudo-header ((t :foreground "white")))
 '(change-log-name ((t :foreground "firebrick")))
 '(change-log-date ((t :foreground "gray")))

 '(magit-tag ((t :foreground "cyan" :weight bold :box 1 :background "#202020")))
 '(magit-sequence-part ((t :foreground "orange1" :weight bold)))
 '(magit-sequence-head ((t :foreground "chartreuse" :weight bold)))

 ;; Message faces
 '(message-header-name ((t :foreground "cyan" :weight bold)))
 '(message-header-cc ((t :foreground "cyan")))
 '(message-header-other ((t :foreground "cyan")))
 '(message-header-subject ((t :foreground "chartreuse")))
 '(message-header-to ((t :foreground "cyan")))
 '(message-cited-text ((t :foreground "chocolate1")))
 '(message-separator ((t :foreground "#4c3840" :weight bold)))

 ;; Org-Mode
 '(org-todo ((t :foreground "red")))
 '(org-done ((t :foreground "chartreuse")))
 '(org-hide ((t :foreground "#3a3f4b")))
 '(org-link ((t :foreground "cyan" :underline t)))
 '(org-date ((t :foreground "gold")))
 '(org-block-begin-line ((t :foreground "cyan")))
 '(org-block-background ((t :background "#000000")))
 '(org-block-end-line ((t :foreground "cyan")))
 '(org-tag ((t :foreground "#3a3f4b")))
 '(org-special-keyword ((t :foreground "gray40")))
 '(org-priority ((t :foreground "gray40")))
 '(org-level-1 ((t :foreground "DodgerBlue1" :weight bold)))
 '(org-level-2 ((t :foreground "yellow2" :weight bold))) 
 '(org-level-3 ((t :foreground "dark orange" :weight bold)))
 '(org-level-4 ((t :foreground "firebrick1" :weight bold)))
 '(org-level-5 ((t :foreground "lavender" :weight bold)))
 '(org-level-6 ((t :foreground "medium spring green" :weight bold)))
 '(org-ellipsis ((t :foreground "#cccccc")))
 '(org-mode-line-clock ((t :background unspecified (:inherit mode-line))))

 ;; ERC
 ;; '(erc-nick-default-face ((t :foreground "cyan" :background "navyblue" :weight bold)))
 '(erc-nick-default-face ((t :foreground "gold" :weight bold)))
 '(erc-current-nick-face ((t :foreground "gold" :weight bold)))
 '(erc-my-nick-face ((t :foreground "gold" :weight normal)))
 '(erc-nick-msg-face ((t :foreground "gray" :weight bold)))
 '(erc-notice-face ((t :foreground "chocolate1")))
 '(erc-input-face ((t :foreground "white" :weight bold)))
 '(erc-prompt-face ((t :foreground "gold" :background "black" :weight bold :box 1)))
 '(erc-timestamp-face ((t :foreground "DodgerBlue1" :weight bold)))

 ;; Ivy
 '(ivy-current-match ((t :background "blue1" :weight bold :foreground "cyan")))
 '(ivy-minibuffer-match-face-1 ((t :foreground "orange1")))
 '(ivy-minibuffer-match-face-2 ((t :foreground "chartreuse")))
 '(ivy-minibuffer-match-face-3 ((t :foreground "orange1")))
 '(ivy-minibuffer-match-face-4 ((t :foreground "chartreuse")))
 '(ivy-match-required-face ((t :foreground "#4c3840" :background "#4c3840" :weight bold)))
 '(ivy-modified-buffer ((t :foreground "#4c3840")))
 '(ivy-remote ((t :foreground "cyan")))

 ;; Company
 '(company-preview ((t :background "#22252c" :foreground "#ffffff")))
 '(company-preview-common ((t :background "#22252c" :foreground "LightSkyblue1")))
 '(company-preview-search ((t :background "cyan" :foreground "#ffffff")))
 '(company-tooltip ((t :background "#22252c" :foreground "#ffffff")))
 '(company-scrollbar-bg ((t :background "#22252c")))
 '(company-scrollbar-fg ((t :background "navyblue")))
 '(company-tooltip-common ((t :foreground "LightSkyblue1" :weight bold :background "#22252c")))
 '(company-tooltip-annotation ((t :foreground "cyan" :weight bold :background "navyblue")))
 '(company-tooltip-common-selection ((t :foreground "dodgerblue1" :background "#3a3f4b" :weight bold)))
 '(company-tooltip-selection ((t :foreground "#ffffff" :background "#3a3f4b")))
 '(company-tooltip-mouse ((t :foreground "#ffffff" :background "#3a3f4b")))

 ;; Flycheck
 '(flycheck-fringe-error ((t :foreground "#4c3840" :background "#4c3840" :weight bold :inverse-video t)))
 '(flycheck-fringe-warning ((t :background "#4a473d" :foreground "orange1" :weight bold :inverse-video t)))
 '(flycheck-fringe-info ((t :background "navyblue" :foreground "cyan" :weight bold :inverse-video t)))
 '(flycheck-warning ((t :underline (:color "#4c3840" :style wave))))
 '(flycheck-error ((t :underline (:color "#4c3840" :style wave))))

 ;; Visible mark
 '(visible-mark-face1 ((t :foreground "orange1"-light :inverse-video t)))
 '(visible-mark-face2 ((t :foreground "PeachPuff3" :inverse-video t)))

 ;; Compilation
 '(compilation-info ((t :foreground "cyan" :weight bold)))
 '(compilation-warning ((t :foreground "orange1" :weight bold)))
 '(compilation-error ((t :foreground "#4c3840" :weight bold)))
 '(compilation-line-number ((t :foreground "chartreuse" :weight bold)))
 '(compilation-mode-line-exit ((t :foreground "chartreuse" :weight bold :inverse-video nil)))
 '(compilation-mode-line-run ((t :foreground "orange1" :weight bold)))
 '(compilation-mode-line-fail ((t :foreground "#4c3840" :weight bold)))
 )

;; Auto load theme
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'customizable-dark)
;;; customizable-dark ends here
