;; Set font
;(set-frame-font "Droid Sans Mono-10" nil t)

;; Load Theme(s)
;; Through package manager first install following themes:
;; * moe-theme
;; * ample-theme
;; * color-theme-sanityinc-tomorrow
;; * jazz-theme
;; * base16-theme
;; * danneskjold-theme
;; * badger-theme

;; BEST THEME: Moe-theme best documentation, easily customisable & documented
;; Add proper powerline integration

(require 'moe-theme)

;; Load theme with customisations applied
(moe-dark) 

;; Choose a color for mode-line.(Default: blue)
(moe-theme-set-color 'w/b)

;; Resize titles
(setq moe-theme-resize-markdown-title '(2.0 1.7 1.5 1.3 1.0 1.0))
(setq moe-theme-resize-org-title '(2.2 1.8 1.6 1.4 1.2 1.0 1.0 1.0 1.0))
(setq moe-theme-resize-rst-title '(2.0 1.7 1.5 1.3 1.1 1.0))

;; Initialise powerline-moe-theme
(powerline-moe-theme)

(custom-set-faces
 ;;---Set Background To Black---
 '(default ((t (:background "#000000" :foreground "#ffffff"))))

 ;; ;; Set the default mouse face.
 '(mouse ((t (:background "grey"))))

 ;;---Flyspell---
 '(flyspell-incorrect ((t (:underline (:color "Red1" :style wave) :weight normal :foreground nil :background nil))))

 ;;---Highlighting-Text---
 '(region ((t (:background "dim gray"))))

 ;;---Ido---
 '(ido-first-match ((t (:foreground "dark orange" :weight semibold))))
 '(ido-subdir ((t (:foreground "deep sky blue"))))

 ;;---Font-lock---
 '(font-lock-comment-delimiter-face ((t (:foreground "chocolate1" :slant italic))))
 '(font-lock-comment-face ((t (:foreground "chocolate1" :slant italic))))
 '(font-lock-doc-face ((t (:foreground "orange1"))))
 '(font-lock-function-name-face ((t (:foreground "yellow2" :weight normal))))
 '(font-lock-preprocessor-face ((t (:foreground "LightSkyBlue1"))))
 '(font-lock-type-face ((t (:foreground "cyan" :weight normal))))
 '(font-lock-variable-name-face ((t (:foreground "chartreuse"))))
 
 ;;-lisp-
 '(font-lock-builtin-face ((t (:foreground "red2"))))
 '(font-lock-string-face ((t (:foreground "orange1"))))
 '(font-lock-keyword-face ((t (:foreground "chartreuse" :weight normal))))
 '(font-lock-constant-face ((t (:foreground "DodgerBlue1"))))

 ;;---Linum---
 '(linum ((t (:background "black" :foreground "#b2b2b2"))))

 ;;---Magit---
 '(magit-bisect-bad ((t (:foreground "IndianRed4" :background nil))))
 '(magit-bisect-good ((t (:foreground "DarkOliveGreen" :background nil))))
 '(magit-bisect-skip ((t (:foreground "DarkGoldenrod" :background nil))))
 '(magit-blame-date ((t (:inherit magit-blame-heading :foreground nil :background nil))))
 '(magit-blame-hash ((t (:inherit magit-blame-heading :foreground nil :background nil))))
 '(magit-blame-heading ((t (:background "grey25" :foreground "white"))))
 '(magit-blame-name ((t (:inherit magit-blame-heading :foreground nil :background nil))))
 '(magit-blame-summary ((t (:inherit magit-blame-heading :foreground nil :background nil))))
 '(magit-branch-current ((t (:inherit magit-branch-local :box 1 :weight normal :underline nil :foreground nil :background nil))))
 '(magit-branch-local ((t (:foreground "LightSkyBlue1" :weight normal :underline nil :background nil))))
 '(magit-branch-remote ((t (:foreground "DarkSeaGreen2" :weight normal :underline nil :background nil))))
 '(magit-cherry-equivalent ((t (:foreground "magenta"))))
 '(magit-cherry-unmatched ((t (:foreground "cyan"))))
 '(magit-diff-added ((t (:background "#335533" :foreground "#ddffdd" :weight normal))))
 '(magit-diff-added-highlight ((t (:background "#336633" :foreground "#cceecc" :weight normal))))
 '(magit-diff-base ((t (:background "#555522" :foreground "#ffffcc"))))
 '(magit-diff-base-highlight ((t (:background "#666622" :foreground "#eeeebb" :weight normal :inherit nil))))
 '(magit-diff-conflict-heading ((t (:inherit magit-diff-hunk-heading :foreground nil :background nil))))
 '(magit-diff-context ((t (:foreground "grey70"))))
 '(magit-diff-context-highlight ((t (:background "grey20" :foreground "grey70" :inherit nil))))
 '(magit-diff-file-heading ((t (:weight bold :foreground nil))))
 '(magit-diff-file-heading-highlight ((t (:weight bold :background nil))))
 '(magit-diff-file-heading-selection ((t (:inherit magit-diff-file-heading-highlight :foreground "LightSalmon3" :weight normal :background nil))))
 '(magit-diff-hunk-heading ((t (:background "grey25" :foreground "grey70"))))
 '(magit-diff-hunk-heading-highlight ((t (:background "grey35" :foreground "grey70"))))
 '(magit-diff-hunk-heading-selection ((t (:inherit magit-diff-hunk-heading-highlight :foreground "LightSalmon3" :background nil))))
 '(magit-diff-hunk-region ((t (:inherit bold))))
 '(magit-diff-lines-boundary ((t (:inherit magit-diff-lines-heading :background nil :foreground nil))))
 '(magit-diff-lines-heading ((t (:inherit magit-diff-hunk-heading-highlight :background "salmon4" :foreground "grey80"))))
 '(magit-diff-our ((t (:inherit magit-diff-removed :foreground nil))))
 '(magit-diff-our-highlight ((t (:inherit magit-diff-removed-highlighted :foreground nil :background nil))))
 '(magit-diff-removed ((t (:background "#553333" :foreground "#ffdddd" :weight normal))))
 '(magit-diff-removed-highlight ((t (:background "#663333" :foreground "#eecccc" :weight normal :inherit nil))))
 '(magit-diff-their ((t (:inherit magit-diff-added :foreground nil))))
 '(magit-diff-their-highlight ((t (:inherit magit-diff-added-highlight :foreground nil :background nil))))
 '(magit-diff-whitespace-warning ((t (:inherit trailing-whitespace :foreground nil :background nil))))
 '(magit-diffstat-added ((t (:foreground "#448844" :weight normal :background nil))))
 '(magit-diffstat-removed ((t (:foreground "#aa4444" :weight normal :background nil))))
 '(magit-dimmed ((t (:foreground "grey50"))))
 '(magit-filename ((t (:weight medium :foreground nil))))
 '(magit-hash ((t (:foreground "grey40"))))
 '(magit-head ((t (:inherit magit-branch-local :foreground nil :background nil))))
 '(magit-header-line ((t (:inherit magit-section-heading :foreground nil))))
 '(magit-log-author ((t (:foreground "tomato"))))
 '(magit-log-date ((t (:foreground "grey80"))))
 '(magit-log-graph ((t (:foreground "grey80"))))
 '(magit-process-ng ((t (:inherit magit-section-heading :foreground "red" :underline nil :background nil))))
 '(magit-process-ok ((t (:inherit magit-section-heading :foreground "green" :underline nil :background nil))))
 '(magit-reflog-amend ((t (:foreground "magenta" :background nil))))
 '(magit-reflog-checkout ((t (:foreground "blue" :background nil))))
 '(magit-reflog-cherry-pick ((t (:foreground "green" :background nil))))
 '(magit-reflog-commit ((t (:foreground "green" :background nil))))
 '(magit-reflog-merge ((t (:foreground "green" :background nil))))
 '(magit-reflog-other ((t (:foreground "cyan" :background nil))))
 '(magit-reflog-rebase ((t (:foreground "magenta" :background nil))))
 '(magit-reflog-remote ((t (:foreground "cyan" :background nil))))
 '(magit-reflog-reset ((t (:foreground "red" :background nil))))
 '(magit-section-heading ((t (:foreground "LightGoldenrod2" :weight bold :underline nil))))
 '(magit-section-heading-selection ((t (:foreground "LightSalmon3" :background nil))))
 '(magit-section-highlight ((t (:background "grey20"))))
 '(magit-sequence-done ((t (:inherit magit-hash :foreground nil))))
 '(magit-sequence-drop ((t (:foreground "IndianRed"))))
 '(magit-sequence-head ((t (:foreground "LightSkyBlue1"))))
 '(magit-sequence-onto ((t (:inherit magit-sequence-done :foreground nil))))
 '(magit-sequence-part ((t (:foreground "LightGoldenrod2"))))
 '(magit-sequence-pick ((t (:inherit default :foreground nil))))
 '(magit-sequence-stop ((t (:foreground "DarkSeaGreen2"))))
 '(magit-signature-bad ((t (:foreground "red"))))
 '(magit-signature-good ((t (:foreground "green"))))
 '(magit-signature-untrusted ((t (:foreground "cyan"))))
 '(magit-tag ((t (:foreground "LightGoldenrod2" :background nil))))

 ;;---Mode-Line---
 '(mode-line ((t (:foreground "#030303" :background "#bdbdbd" :box nil))))
 '(mode-line-inactive ((t (:background "gray30" :foreground "#f9f9f9" :box nil))))
 '(mode-line-buffer-id ((t (:foreground "black" :box nil :weight bold))))

)

;; OKAY THEMES
;; (load-theme 'ample t) ;;black bg, good normal colours, ok
;; (load-theme 'sanityinc-tomorrow-bright t) ;;black bg, good normal colours
;; (load-theme 'jazz t) ;; Good looking theme, just needs black bg to be perfect
;; (load-theme 'danneskjold t) ;; great simple black bg, high contrast theme
;; (load-theme 'base16-pico t) ;; black bg, high contrast, pink highlighting...
;; (load-theme 'base16-bright t) ;; black bg, modeline not as good as others...
;; (load-theme 'base16-solarized-dark t);; not black bg, good colours, grey fog

;; TOLERABLE
;; (load-theme 'base16-seti-ui t) ;; dark bg, horrible modeline & linum green...
;; (load-theme 'base16-solar-flare t) ;; dark bg, grey looks like fog...
;; (load-theme 'base16-google-dark t) ;; not black bg but dark, colours ok
;; (load-theme 'base16-spacemacs t) ;; dark bg, ok colours, purple do & end...
;; (load-theme 'base16-phd t) ;; not black bg, colours not very high contrast
;; (load-theme 'base16-tomorrow-night t) ;; not black bg
;; (load-theme 'base16-twilight t) ;; not black bg
;; (load-theme 'base16-ir-black t) ;; black bg, grape do & end blocks...
;; (load-theme 'base16-pop t) ;; black bg, uses purple do & end blocks...
;; (load-theme 'base16-isotope t) ;; black bg, high contrast, pink & purple keywords...

;; CRAP
;; (load-theme 'badger t) ;; Cant read modeline, Black highlighting on dark bg!!!
;; (load-theme 'base16-summerfruit-dark t) ;; not great i think
;; (load-theme 'base16-railscasts t) ;; not great i think
;; (load-theme 'base16-macintosh t) ;; not great i think

;;OTHER THEMES
;;https://github.com/emacs-jp/replace-colorthemes

(set-frame-font "Droid Sans Mono-10" nil t)
