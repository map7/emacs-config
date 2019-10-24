;; Customizable-light --- A light theme that is completely customizable
;;; Commentary:
;;; Code:

(deftheme customizable-light
  "Created 2019-10-16. A completely and easily customizable light theme")

(custom-theme-set-faces
 'customizable-light
 '(default ((t (:family "DejaVu Sans Mono"
                        :stipple nil
                        :background "white"
                        :foreground "black"
                        :inverse-video nil
                        :box nil
                        :strike-through nil
                        :overline nil
                        :underline nil
                        :slant normal
                        :weight normal
                        :height 120
                        :width normal
                        :foundry "PfEd"
                        :inherit nil))))
 '(cursor ((((background light)) (:background "black")) (((background dark)) (:background "white"))))
 '(fixed-pitch ((t (:family "Monospace"))))
 '(variable-pitch ((t (:family "Sans Serif"))))
 '(escape-glyph ((t (:foreground "DodgerBlue3" :weight bold))))
 '(homoglyph ((t (:foreground "DodgerBlue1"))))
 '(minibuffer-prompt ((t (:foreground "DarkBlue" :weight bold))))
 '(highlight ((t (:background "NavyBlue" :foreground "white")))) ;; In buffer Ivy search line highlight
 '(region ((t (:inherit (highlight))))) ;; In buffer text highlight background under cursor
 '(shadow ((((class color grayscale) (min-colors 88) (background light)) (:foreground "grey50")) (((class color grayscale) (min-colors 88) (background dark)) (:foreground "grey70")) (((class color) (min-colors 8) (background light)) (:foreground "green")) (((class color) (min-colors 8) (background dark)) (:foreground "yellow"))))
 '(secondary-selection ((((class color) (min-colors 88) (background light)) (:background "yellow1")) (((class color) (min-colors 88) (background dark)) (:background "SkyBlue4")) (((class color) (min-colors 16) (background light)) (:background "yellow")) (((class color) (min-colors 16) (background dark)) (:background "SkyBlue4")) (((class color) (min-colors 8)) (:foreground "black" :background "cyan")) (t (:inverse-video t))))
 '(trailing-whitespace ((((class color) (background light)) (:background "red1")) (((class color) (background dark)) (:background "red1")) (t (:inverse-video t))))
 ;; Base fonts
 '(font-lock-builtin-face ((t (:foreground "red3")))) ;; ruby requrie
 '(font-lock-comment-delimiter-face ((default (:inherit (font-lock-comment-face)))))
 '(font-lock-comment-face ((t (:foreground "DimGray")))) ;; ruby comment
 '(font-lock-constant-face ((t (:foreground "DodgerBlue4")))) ;; ruby :name (symbols)
 '(font-lock-doc-face ((t (:inherit (font-lock-string-face)))))
 '(font-lock-function-name-face ((t (:foreground "yellow4")))) ;; ruby method eg .run
 '(font-lock-keyword-face ((t (:foreground "green3")))) ;; ruby def
 '(font-lock-negation-char-face ((t (:inherit (font-lock-constant-face)))))
 '(font-lock-preprocessor-face ((t (:inherit (font-lock-type-face))))) ;; ruby =, <<, &&, >, <
 '(font-lock-regexp-grouping-backslash ((t (:inherit (bold)))))
 '(font-lock-regexp-grouping-construct ((t (:inherit (bold)))))
 '(font-lock-string-face ((t (:foreground "chocolate")))) ;; ruby quoted string
 '(font-lock-type-face ((t (:foreground "DodgerBlue3")))) ;; ruby class_name
 '(font-lock-variable-name-face ((t (:foreground "black"))))
 '(font-lock-warning-face ((t (:background "red" :foreground "black" :weight bold))))
 '(button ((t (:inherit (link)))))
 '(link ((((class color) (min-colors 88) (background light)) (:underline (:color foreground-color :style line) :foreground "RoyalBlue3")) (((class color) (background light)) (:underline (:color foreground-color :style line) :foreground "blue")) (((class color) (min-colors 88) (background dark)) (:underline (:color foreground-color :style line) :foreground "cyan1")) (((class color) (background dark)) (:underline (:color foreground-color :style line) :foreground "cyan")) (t (:inherit (underline)))))
 '(link-visited ((t (:inherit link :foreground "blue"))))
 '(fringe ((t (:background "white"))))
 '(header-line ((default (:inherit (mode-line))) (((type tty)) (:underline (:color foreground-color :style line) :inverse-video nil)) (((class color grayscale) (background light)) (:box nil :foreground "grey20" :background "grey90")) (((class color grayscale) (background dark)) (:box nil :foreground "grey90" :background "grey20")) (((class mono) (background light)) (:underline (:color foreground-color :style line) :box nil :inverse-video nil :foreground "black" :background "white")) (((class mono) (background dark)) (:underline (:color foreground-color :style line) :box nil :inverse-video nil :foreground "white" :background "black"))))
 '(tooltip ((((class color)) (:inherit (variable-pitch) :foreground "black" :background "lightyellow")) (t (:inherit (variable-pitch)))))
 ;; Modeline
 '(mode-line ((t (:background "gray" :foreground "black" :box -1))))
 '(mode-line-buffer-id ((t (:weight normal))))
 '(mode-line-emphasis ((t (:weight bold))))
 '(mode-line-highlight ((t (:box nil :weight bold))))
 '(mode-line-inactive ((t (:inherit mode-line :background "white" :foreground "black" :box (:line-width 1 :color "DimGray") :weight light))))
 ;; iSearch
 '(lazy-highlight ((t (:background "DimGray" :foreground "gold3"))))
 '(isearch ((t :background "DodgerBlue1" :foreground "white"))) ;; In buffer highlighting
 '(isearch-fail ((t (:background "red2" :foreground "black"))))
 '(match ((((class color) (min-colors 88) (background light)) (:background "yellow1")) (((class color) (min-colors 88) (background dark)) (:background "RoyalBlue3")) (((class color) (min-colors 8) (background light)) (:foreground "black" :background "yellow")) (((class color) (min-colors 8) (background dark)) (:foreground "white" :background "blue")) (((type tty) (class mono)) (:inverse-video t)) (t (:background "gray"))))
 '(next-error ((t (:inherit (region)))))
 '(query-replace ((t (:inherit (isearch)))))
 
 ;; mml
 '(message-mml-face ((t :foreground "chocolate1")))

 ;; linum (code line numbering)
 '(linum ((t :foreground "DimGray" :background "white")))
 ;; from hlinum
 '(linum-highlight-face ((t :foreground "DodgerBlue1")))

 ;; eshell
 '(eshell-prompt-face ((t :weight bold :foreground "orange3" :background "white")))
 '(eshell-ls-directory ((t :foreground "DodgerBlue1" :background "white" :weight bold)))
 '(eshell-ls-symlink ((t :weight bold :foreground "dark orange" :background "white")))
 '(eshell-ls-executable ((t :weight bold :foreground "dark green" :background "white")))

 ;; whitespace
 '(whitespace-space ((t :background unspecified :foreground "#3e4451"
                        :inverse-video unspecified)))
 '(whitespace-hspace ((t :background unspecified :foreground "#3e4451"
                         :inverse-video unspecified)))
 '(whitespace-tab ((t :background unspecified :foreground "#3e4451"
                      :inverse-video unspecified)))
 '(whitespace-newline ((t :background unspecified :foreground "#3e4451"
                          :inverse-video unspecified)))
 '(whitespace-trailing ((t :background "#ee0000" :foreground "white" :weight bold
                           :inverse-video nil)))
 '(whitespace-line ((t :background unspecified :foreground "#ee0000"
                       '                                        :inverse-video unspecified)))
 '(whitespace-space-before-tab ((t :inherit whitespace-space)))
 '(whitespace-space-after-tab ((t :inherit whitespace-space)))
 '(whitespace-indentation ((t :background unspecified :foreground "#3e4451"
                              :inverse-video unspecified)))
 '(whitespace-empty ((t :background "orange1" :foreground "#3e4451"
                        :inverse-video unspecified)))

 ;; Emacs menu (custom-face) 
 '(widget-field ((t (:background "gray" :foreground "black" :box (:line-width 1 :color "chocolate1")))))
 '(widget-button ((t :inherit link)))
 '(custom-button ((t :background "light gray" :box (:line-width 2 :style released-button))))
 '(custom-button-mouse ((t :background "gray" :box (:line-width 2 :style released-button))))
 '(custom-button-pressed ((t :background "dark gray" :box (:line-width 2 :style pressed-button))))
 '(custom-group-tag ((t :foreground "DodgerBlue1" :weight bold :height 1.4)))
 '(custom-variable-tag ((t :foreground "DodgerBlue1" :weight bold)))
 '(custom-state ((t :foreground "chartreuse")))

 ;; Highlighting faces
 '(fringe ((t :background "#24282f" :foreground "chocolate1")))
 ;; '(region ((t :background "red" :foreground "white"))) ;; defined in default faces
 '(secondary-selection ((t :background "#3e4451" :foreground "white")))

 ;; Buffer borders
 '(border ((t :foreground "#3a3f4b")))
 '(vertical-border ((t :foreground "black")))
 '(internal-border ((t :foreground "white"))) 

 ;; error & success
 '(error ((t :foreground "#ee0000" :weight bold)))
 '(warning ((t :foreground "orange1" :weight bold)))
 '(success ((t :foreground "chartreuse" :weight bold)))

 ;; dired
 '(dired-directory ((t :foreground "DodgerBlue1" :weight bold)))
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
 '(dired-subtree-depth-3-face ((t :background "white")))

 ;;; dired+
 '(diredp-dir-heading ((t :foreground "#4c3840")))
 '(diredp-dir-name ((t :foreground "LightSkyblue1")))
 '(diredp-file-name ((t :foreground "black")))
 '(diredp-file-suffix ((t :foreground "#cccccc")))
 '(diredp-ignored-file-name ((t :foreground "chocolate1")))
 '(diredp-symlink ((t :foreground "#ff87ba")))
 '(diredp-number ((t :foreground "orange1")))

 ;; diff
 '(diff-removed ((t :background "LightSalmon" :foreground "red4")))
 '(diff-added ((t :background "light green" :foreground "dark green")))
 '(diff-hunk-header ((t :background "white" :foreground "DodgerBlue1" :weight bold)))
 '(diff-file-header ((t :weight bold)))
 '(diff-header ((t :background "white" :foreground "DodgerBlue1")))
 '(diff-context ((t :foreground "black")))
 '(diff-refine-added ((t :background "light green" :foreground "dark green")))
 '(diff-refine-removed ((t :background "LightSalmon" :foreground "dark red")))

 ;; ediff
 '(ediff-fine-diff-B ((t :inherit diff-refine-added)))
 '(ediff-current-diff-B ((t :inherit diff-added)))
 '(ediff-fine-diff-A ((t :inherit diff-refine-removed)))
 '(ediff-current-diff-A ((t :inherit diff-removed)))
 '(ediff-fine-diff-C ((t :foreground "cyan" :background "blue")))
 '(ediff-current-diff-C ((t :background "navyblue" :foreground "cyan")))

 ;; X-Term
 '(term-color-blue ((t :foreground "DodgerBlue3")))   ;; foreground font color for xterm prompt & normal folders
 '(term-color-cyan ((t :foreground "orange3")))    ;; foreground font color for xterm symlinks

 ;; Magit
 '(magit-diff-context-highlight ((t :background "white")))
 '(magit-diff-file-heading ((t :weight bold :foreground "DodgerBlue1")))
 '(magit-diff-file-heading-highlight ((t :foreground "DodgerBlue1" :background "cyan" :weight bold)))
 '(magit-diff-removed-highlight ((t :inherit diff-removed)))
 '(magit-diff-removed ((t :inherit diff-removed)))
 '(magit-diff-our ((t :inherit diff-removed)))
 '(magit-diff-our-highlight ((t :inherit diff-removed)))
 '(magit-diff-added-highlight ((t :inherit diff-added)))
 '(magit-diff-added ((t :inherit diff-added)))
 '(magit-diff-their ((t :inherit diff-added)))
 '(magit-diff-their-highlight ((t :inherit diff-added)))
 '(magit-diff-lines-heading ((t :background "DodgerBlue1" :foreground "black")))
 '(magit-diff-hunk-heading ((t :background "DimGray")))
 '(magit-diff-hunk-heading-highlight ((t :background "DodgerBlue1")))
 '(magit-process-ok ((t :foreground "chartreuse" :weight bold)))
 '(magit-section-highlight ((t :background "gray")))
 '(magit-section-heading ((t :foreground "DimGray" :weight bold)))
 '(magit-branch-current ((t :foreground "DodgerBlue1" :background "cyan" :box 1)))
 '(magit-branch-local ((t :foreground "DarkOrange4" :background "orange" :box 1)))
 '(magit-branch-remote ((t :foreground "dark green" :background "light green" :box 1)))
 '(magit-reflog-reset ((t :background "#4c3840" :foreground "#4c3840" :weight bold)))
 '(magit-reflog-amend ((t :background "navyblue" :foreground "cyan" :weight bold)))
 '(magit-reflog-rebase ((t :background "navyblue" :foreground "cyan" :weight bold)))
 '(magit-reflog-commit ((t :background "#3d4a41" :foreground "chartreuse" :weight bold)))
 '(magit-reflog-checkout ((t :background "#4a473d" :foreground "orange1" :weight bold)))
 '(magit-reflog-cherry-pick ((t :background "blue1" :foreground "cyan" :weight bold)))
 '(magit-bisect-bad ((t :background "#4c3840" :foreground "#4c3840" :box 1)))
 '(magit-bisect-good ((t :background "navyblue" :foreground "cyan" :box 1)))
 '(magit-blame-heading ((t :foreground "chartreuse" :background "#3d4a41" :box 1)))
 '(magit-tag ((t :foreground "cyan" :weight bold :box 1 :background "#202020")))
 '(magit-sequence-part ((t :foreground "orange1" :weight bold)))
 '(magit-sequence-head ((t :foreground "chartreuse" :weight bold)))

 ;; Git
 '(git-commit-summary ((t :weight bold)))
 '(git-commit-known-pseudo-header ((t :foreground "black")))
 '(change-log-name ((t :foreground "firebrick")))
 '(change-log-date ((t :foreground "gray")))

 ;; Message faces
 '(message-header-name ((t :foreground "cyan" :weight bold)))
 '(message-header-cc ((t :foreground "cyan")))
 '(message-header-other ((t :foreground "cyan")))
 '(message-header-subject ((t :foreground "chartreuse")))
 '(message-header-to ((t :foreground "cyan")))
 '(message-cited-text ((t :foreground "chocolate1")))
 '(message-separator ((t :foreground "#4c3840" :weight bold)))

 ;; Org-Mode
 '(org-todo ((t :background "LightSalmon" :foreground "dark red" :weight bold)))
 '(org-done ((t :foreground "dark green" :background "chartreuse" :weight bold)))
 '(org-hide ((t :foreground "#3a3f4b")))
 '(org-link ((t :foreground "cyan3" :underline t)))
 '(org-date ((t :foreground "dark orange")))
 '(org-block-begin-line ((t :foreground "cyan")))
 '(org-block-background ((t :background "white")))
 '(org-block-end-line ((t :foreground "cyan")))
 '(org-tag ((t :foreground "DimGrey")))
 '(org-special-keyword ((t :foreground "gold")))
 '(org-priority ((t :foreground "chocolate1")))
 '(org-level-1 ((t :foreground "DodgerBlue3" :weight bold)))
 '(org-level-2 ((t :foreground "yellow3" :weight bold)))
 '(org-level-3 ((t :foreground "orange3" :weight bold)))
 '(org-level-4 ((t :foreground "firebrick1" :weight bold)))
 '(org-level-5 ((t :foreground "gray60" :weight bold))) ;; gray80 for black bg
 '(org-level-6 ((t :foreground "green3" :weight bold)))
 '(org-ellipsis ((t :foreground "#cccccc")))
 '(org-mode-line-clock ((t :background unspecified (:inherit mode-line))))

 ;; ERC
 '(erc-nick-default-face ((t :foreground "gold" :weight bold)))
 '(erc-current-nick-face ((t :foreground "gold" :weight bold)))
 '(erc-my-nick-face ((t :foreground "gold" :weight normal)))
 '(erc-nick-msg-face ((t :foreground "gray" :weight bold)))
 '(erc-notice-face ((t :foreground "chocolate1")))
 '(erc-input-face ((t :foreground "black" :weight bold)))
 '(erc-prompt-face ((t :foreground "gold" :background "white" :weight bold :box 1)))
 '(erc-timestamp-face ((t :foreground "DodgerBlue1" :weight bold)))

 ;; Ivy
 '(ivy-current-match ((t :background "gold" :foreground "DarkBlue" :weight bold)))
 '(ivy-minibuffer-match-face-1 ((t :foreground "dark orange")))
 '(ivy-minibuffer-match-face-2 ((t :foreground "DodgerBlue1")))
 '(ivy-minibuffer-match-face-3 ((t :foreground "dark orange")))
 '(ivy-minibuffer-match-face-4 ((t :foreground "DodgerBlue1")))
 '(ivy-match-required-face ((t :foreground "#4c3840" :background "#4c3840" :weight bold)))
 '(ivy-modified-buffer ((t :foreground "#4c3840")))
 '(ivy-remote ((t :background "cyan" :foreground "DodgerBlue4")))

 ;; Company
 '(company-preview ((t :background "orange3" :foreground "black"))) ;; Autocomplete single suggestion
 '(company-preview-common ((t :background "orange3" :foreground "NavyBlue" :weight bold)))
 '(company-preview-search ((t :background "cyan" :foreground "black")))
 '(company-tooltip ((t :background "gray60" :foreground "black"))) ;; Autocomplete background
 '(company-scrollbar-bg ((t :background "gray60"))) ;; Autocomplete Scroll bar background
 '(company-scrollbar-fg ((t :background "navyblue")))
 '(company-tooltip-common ((t :foreground "LightSkyblue1" :weight bold :background "#22252c")))
 '(company-tooltip-annotation ((t :foreground "cyan" :weight bold :background "navyblue")))
 '(company-tooltip-common-selection ((t :foreground "DodgerBlue1" :background "#3a3f4b" :weight bold)))
 '(company-tooltip-selection ((t :foreground "black" :background "#3a3f4b")))
 '(company-tooltip-mouse ((t :foreground "black" :background "#3a3f4b")))

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

(provide-theme 'customizable-light)
