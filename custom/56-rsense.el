;; -------------------- Autocomplete --------------------
;; Use with Rsense for Ruby autocomplete:
;; http://cx4a.org/software/rsense/
;; Follow instructions on: http://itstickers.blogspot.com/2010/11/all-about-emacs.html

(use-package rsense
  :init
  (setq rsense-home "/opt/rsense-0.3")
  (add-to-list 'load-path (concat rsense-home "/etc"))  
  ;; Rsense + Autocomplete
  (add-hook 'ruby-mode-hook
            (lambda ()
              (add-to-list 'ac-sources 'ac-source-rsense-method)
              (add-to-list 'ac-sources 'ac-source-rsense-constant)))

  ;; Complete by C-c .
  (add-hook 'ruby-mode-hook
            (lambda ()
              (local-set-key (kbd "C-c .") 'rsense-complete)))
  :defer 5)
