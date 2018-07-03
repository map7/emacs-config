;;; package --- Summary
;;; Commentary:
;;; Code:
(setq
 alect-overriding-faces
   ;; Font lock faces
 '((alect-prompt           ((t :foreground "cyan" :weight bold)))
   (alect-author           ((t :foreground "firebrick")))
   (alect-time           ((t :foreground "grey")))
   (font-lock-string-face  ((t :foreground "orange1")))
   (font-lock-builtin-face ((t :foreground "#ee0000")))
   (font-lock-doc-face     ((t :inherit font-lock-string-face)))
   (font-lock-comment-face ((t :foreground "chocolate1")))
   (font-lock-constant-face ((t :foreground "dodgerblue1")))
   (font-lock-function-name-face ((t :foreground "yellow2")))
   (font-lock-keyword-face ((t :foreground "cyan")))
   (font-lock-string-face ((t :foreground "orange1")))
   (font-lock-type-face ((t :foreground "cyan")))
   (font-lock-variable-name-face ((t :foreground "white")))
   (font-lock-warning-face ((t :foreground "#ee0000" :weight bold :background "#4c3840")))

   ;; Modeline
   (mode-line-buffer-id    ((t :foreground "white" :weight bold)))
   (mode-line              ((((background light))
                             :foreground fg+1 :background "#1c2129"
                             :box (:line-width 2 :color "white"))
                            (((background dark))
                             :foreground fg+1 :background "#000000"
                             :box (:line-width 1 :color "gray"))))
   ;; Cursor
   (cursor ((t :background "white")))

   ;; mml
   (message-mml-face ((t :foreground "chocolate1")))

   ;; Escape and prompt faces
   (minibuffer-prompt ((t :foreground "cyan" :weight bold)))
   (escape-glyph ((t :foreground "cyan" :weight bold)))

   ;; linum
   (linum ((t :foreground "#cccccc" :background "#000000")))
   ;; from hlinum
   (linum-highlight-face ((t :foreground "cyan" :background "navyblue")))

   ;; eshell
   (eshell-prompt ((t :foreground "orange1" :background "#000000" :weight bold)))
   (eshell-ls-directory ((t :foreground "cyan" :background "#000000" :weight bold)))
   (eshell-ls-symlink ((t :foreground "orange1" :background "#000000" :weight normal)))
   (eshell-ls-executable ((t :foreground "chartreuse" :background "#000000" :weight bold)))

   ;; whitespace
   (whitespace-space ((t :background unspecified :foreground "#3e4451"
                                            :inverse-video unspecified)))
   (whitespace-hspace ((t :background unspecified :foreground "#3e4451"
                                             :inverse-video unspecified)))
   (whitespace-tab ((t :background unspecified :foreground "#3e4451"
                                          :inverse-video unspecified)))
   (whitespace-newline ((t :background unspecified :foreground "#3e4451"
                                              :inverse-video unspecified)))
   (whitespace-trailing ((t :background "#ee0000" :foreground "#000000" :weight bold
                                               :inverse-video nil)))
   (whitespace-line ((t :background unspecified :foreground "#ee0000"
                                           :inverse-video unspecified)))
   (whitespace-space-before-tab ((t :inherit whitespace-space)))
   (whitespace-space-after-tab ((t :inherit whitespace-space)))
   (whitespace-indentation ((t :background unspecified :foreground "#3e4451"
                                                  :inverse-video unspecified)))
   (whitespace-empty ((t :background "orange1" :foreground "#3e4451"
                                            :inverse-video unspecified)))

   ;; link faces
   (link ((t :foreground "cyan" :underline t)))
   (link-visited ((t :foreground "cyan" :underline t)))

   ;; widget faces
   (widget-field ((t :background "#3e4451" :box (:line-width 1 :color "chocolate1"))))
   (widget-button ((t :inherit link)))

   ;; custom
   (custom-button ((t :background "#3a3f4b" :box (:line-width 2 :style released-button))))
   (custom-button-mouse ((t :background "#3e4451" :box (:line-width 2 :style released-button))))
   (custom-button-pressed ((t :background "#3e4451" :box (:line-width 2 :style pressed-button))))
   (custom-group-tag ((t :foreground "cyan" :weight bold :height 1.4)))
   (custom-variable-tag ((t :foreground "cyan" :weight bold)))
   (custom-state ((t :foreground "chartreuse")))

   ;; Highlighting faces
   (fringe ((t :background "#24282f" :foreground "chocolate1")))
   (border ((t :foreground "#3a3f4b")))
   (vertical-border ((t :foreground "#3a3f4b")))
   (highlight ((t :background "#3e4451" :foreground "#ffffff" :underline nil)))
   (region ((t :background "#3e4451" :foreground "#ffffff")))
   (secondary-selection ((t :background "#3e4451" :foreground "#ffffff")))
   (isearch ((t :background "#ddbd78" :foreground "#3e4451")))
   (lazy-highlight ((t :background "#666666" :foreground "#ddbd78")))

   ;; error & success
   (error ((t :foreground "#ee0000" :weight bold)))
   (warning ((t :foreground "orange1" :weight bold)))
   (success ((t :foreground "chartreuse" :weight bold)))
   
   ;; dired
   (dired-directory ((t :foreground "cyan" :weight bold)))
   (dired-git-face ((t :foreground "#4c3840")))
   (dired-ignored ((t :foreground "#3a3f4b")))
   (dired-filetype-omit ((t :foreground "#3a3f4b")))
   (dired-filetype-common ((t :foreground "orange1")))
   (dired-filetype-execute ((t :foreground "#b3de81")))
   (dired-filetype-source ((t :foreground "yellow2")))
   (dired-filetype-plain ((t :foreground "chocolate1")))
   (dired-filetype-link ((t :foreground "LightSkyblue1" :underline t)))
   (dired-flagged ((t :foreground "#4c3840" :underline t)))
   (dired-marked ((t :foreground "orange1" :underline t)))
   (dired-subtree-depth-1-face ((t :background "#cccccc")))
   (dired-subtree-depth-2-face ((t :background "#666666")))
   (dired-subtree-depth-3-face ((t :background "#000000")))

   ;;; dired+
   (diredp-dir-heading ((t :foreground "#4c3840")))
   (diredp-dir-name ((t :foreground "LightSkyblue1")))
   (diredp-file-name ((t :foreground "white")))
   (diredp-file-suffix ((t :foreground "#cccccc")))
   (diredp-ignored-file-name ((t :foreground "chocolate1")))
   (diredp-symlink ((t :foreground "#ff87ba")))
   (diredp-number ((t :foreground "orange1")))

   ;; diff
   (diff-removed ((t :background "#4c3840" :foreground "#4c3840")))
   (diff-added ((t :background "#3d4a41" :foreground "chartreuse")))
   (diff-hunk-header ((t :background "navyblue" :weight bold :foreground "cyan")))
   (diff-file-header ((t :weight bold)))
   (diff-header ((t :background "#000000" :foreground "cyan")))
   (diff-context ((t :foreground "#ffffff")))
   (diff-refine-added ((t :foreground "chartreuse" :background "#3f6d54")))
   (diff-refine-removed ((t :background "#744a5b" :foreground "#4c3840")))

   ;; ediff
   (ediff-fine-diff-B ((t :inherit diff-refine-added)))
   (ediff-current-diff-B ((t :inherit diff-added)))
   (ediff-fine-diff-A ((t :inherit diff-refine-removed)))
   (ediff-current-diff-A ((t :inherit diff-removed)))
   (ediff-fine-diff-C ((t :foreground "cyan" :background "blue")))
   (ediff-current-diff-C ((t :background "navyblue" :foreground "cyan")))

   ;; magit
   (magit-diff-context-highlight ((t :background "#000000")))
   (magit-diff-file-heading ((t :weight bold :foreground "cyan")))
   (magit-diff-file-heading-highlight ((t :weight bold :foreground "cyan" :background "navyblue")))
   (magit-diff-removed-highlight ((t :inherit diff-removed)))
   (magit-diff-removed ((t :inherit diff-removed)))
   (magit-diff-added-highlight ((t :inherit diff-added)))
   (magit-diff-added ((t :inherit diff-added)))
   (magit-diff-lines-heading ((t :background "dodgerblue1" :foreground "white")))
   (magit-diff-hunk-heading ((t :background "#3a3f4b")))
   (magit-diff-hunk-heading-highlight ((t :background "dodgerblue1")))
   (magit-diff-hunk-heading ((t :background "#3a3f4b")))

   (magit-process-ok ((t :foreground "chartreuse" :weight bold)))

   (magit-section-highlight ((t :background "#000000")))
   (magit-section-heading ((t :foreground "#cccccc" :weight bold)))
   (magit-branch-current ((t :foreground "cyan" :background "#000000" :box 1)))
   (magit-branch-local ((t :foreground "orange1" :background "#000000" :box 1)))
   (magit-branch-remote ((t :foreground "chartreuse" :background "#000000" :box 1)))

   (magit-reflog-reset ((t :background "#4c3840" :foreground "#4c3840" :weight bold)))
   (magit-reflog-amend ((t :background "navyblue" :foreground "cyan" :weight bold)))
   (magit-reflog-rebase ((t :background "navyblue" :foreground "cyan" :weight bold)))
   (magit-reflog-commit ((t :background "#3d4a41" :foreground "chartreuse" :weight bold)))
   (magit-reflog-checkout ((t :background "#4a473d" :foreground "orange1" :weight bold)))
   (magit-reflog-cherry-pick ((t :background "blue1" :foreground "cyan" :weight bold)))

   (magit-bisect-bad ((t :background "#4c3840" :foreground "#4c3840" :box 1)))
   (magit-bisect-good ((t :background "navyblue" :foreground "cyan" :box 1)))

   (magit-blame-heading ((t :foreground "chartreuse" :background "#3d4a41" :box 1)))

   (git-commit-summary ((t :weight bold)))
   (git-commit-known-pseudo-header ((t :foreground "white")))
   (change-log-name ((t :foreground "firebrick")))
   (change-log-date ((t :foreground "gray")))

   (magit-tag ((t :foreground "cyan" :weight bold :box 1 :background "#202020")))
   (magit-sequence-part ((t :foreground "orange1" :weight bold)))
   (magit-sequence-head ((t :foreground "chartreuse" :weight bold)))

   ;; Diffs
   (diff-added ((t :background "#284437")))
   (diff-added-refined ((t :background "#1e8967")))
   (diff-removed ((t :background  "#580000")))
   (diff-removed-refined ((t :background  "#b33c49")))
   (diff-current ((t :background  "#29457b")))
   (diff-current-refined ((t :background  "#4174ae")))

   ;; Message faces
   (message-header-name ((t :foreground "cyan" :weight bold)))
   (message-header-cc ((t :foreground "cyan")))
   (message-header-other ((t :foreground "cyan")))
   (message-header-subject ((t :foreground "chartreuse")))
   (message-header-to ((t :foreground "cyan")))
   (message-cited-text ((t :foreground "chocolate1")))
   (message-separator ((t :foreground "#4c3840" :weight bold)))

   ;; Org-Mode
   (org-todo ((t :foreground "#4c3840")))
   (org-done ((t :foreground "chartreuse")))
   (org-hide ((t :foreground "#3a3f4b")))
   (org-link ((t :foreground "cyan" :underline t)))
   (org-date ((t :foreground "chocolate1")))
   (org-block-begin-line ((t :foreground "#ffdb45")))
   (org-block-background ((t :background "#000000")))
   (org-block-end-line ((t :foreground "#ffdb45")))
   (org-tag ((t :foreground "#3a3f4b")))
   (org-special-keyword ((t :foreground "#ffdb45")))
   (org-priority ((t :foreground "chocolate1")))
   (org-level-1 ((t :foreground "dodgerblue1" :weight bold)))
   (org-level-2 ((t :foreground "#bdb303" :weight bold)))
   (org-level-3 ((t :foreground "orange1" :weight bold)))
   (org-ellipsis ((t :foreground "#cccccc")))
   (org-mode-line-clock ((t :background unspecified (:inherit mode-line))))

   ;;ERC
   (erc-nick-default-face ((t :foreground "cyan" :background "navyblue" :weight bold)))
   (erc-current-nick-face ((t :foreground "#4c3840" :weight bold :background "#4c3840")))
   (erc-my-nick-face ((t :foreground "#4c3840" :weight bold :background "#4c3840")))
   (erc-notice-face ((t :foreground "chocolate1")))
   (erc-input-face ((t :foreground "#ffffff" :weight bold)))
   (erc-prompt-face ((t :foreground "cyan" :background "blue1" :weight bold :box 1)))
   (erc-timestamp-face ((t :foreground "cyan" :weight bold)))

   ;; ivy
   (ivy-current-match ((t :background "blue1" :weight bold :foreground "cyan")))
   (ivy-minibuffer-match-face-1 ((t :foreground "orange1")))
   (ivy-minibuffer-match-face-2 ((t :foreground "chartreuse")))
   (ivy-minibuffer-match-face-3 ((t :foreground "orange1")))
   (ivy-minibuffer-match-face-4 ((t :foreground "chartreuse")))
   (ivy-match-required-face ((t :foreground "#4c3840" :background "#4c3840" :weight bold)))
   (ivy-modified-buffer ((t :foreground "#4c3840")))
   (ivy-remote ((t :foreground "cyan")))

   ;; Company
   (company-preview ((t :background "#22252c" :foreground "#ffffff")))
   (company-preview-common ((t :background "#22252c" :foreground "LightSkyblue1")))
   (company-preview-search ((t :background "cyan" :foreground "#ffffff")))
   (company-tooltip ((t :background "#22252c" :foreground "#ffffff")))
   (company-scrollbar-bg ((t :background "#22252c")))
   (company-scrollbar-fg ((t :background "navyblue")))
   (company-tooltip-common ((t :foreground "LightSkyblue1" :weight bold :background "#22252c")))
   (company-tooltip-annotation ((t :foreground "cyan" :weight bold :background "navyblue")))
   (company-tooltip-common-selection ((t :foreground "dodgerblue1" :background "#3a3f4b" :weight bold)))
   (company-tooltip-selection ((t :foreground "#ffffff" :background "#3a3f4b")))
   (company-tooltip-mouse ((t :foreground "#ffffff" :background "#3a3f4b")))

   ;; Flycheck
   (flycheck-fringe-error ((t :foreground "#4c3840" :background "#4c3840" :weight bold :inverse-video t)))
   (flycheck-fringe-warning ((t :background "#4a473d" :foreground "orange1" :weight bold :inverse-video t)))
   (flycheck-fringe-info ((t :background "navyblue" :foreground "cyan" :weight bold :inverse-video t)))
   (flycheck-warning ((t :underline (:color "#4c3840" :style wave))))
   (flycheck-error ((t :underline (:color "#4c3840" :style wave))))

   ;; Visible mark
   (visible-mark-face1 ((t :foreground "orange1"-light :inverse-video t)))
   (visible-mark-face2 ((t :foreground "PeachPuff3" :inverse-video t)))

   ;; compilation
   (compilation-info ((t :foreground "cyan" :weight bold)))
   (compilation-warning ((t :foreground "orange1" :weight bold)))
   (compilation-error ((t :foreground "#4c3840" :weight bold)))
   (compilation-line-number ((t :foreground "chartreuse" :weight bold)))
   (compilation-mode-line-exit ((t :foreground "chartreuse" :weight bold :inverse-video nil)))
   (compilation-mode-line-run ((t :foreground "orange1" :weight bold)))
   (compilation-mode-line-fail ((t :foreground "#4c3840" :weight bold)))))

   ;; ;; Line Highlight
   ;; (hl-line (t  "#2c323b" "#333333"))

(provide '000-theme-colour-overrides)
;;; 000-theme-colour-overrides.el ends here
