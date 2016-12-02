(use-package multi-term)

(setq multi-term-program "/bin/zsh")

(global-set-key (kbd "C-x <up>") 'multi-term-next)
(global-set-key (kbd "C-x <down>") 'multi-term-prev)

;; Fix UTF8 characters in terminals
(add-hook 'term-exec-hook
          (function
           (lambda ()
             (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))))


(defun last-term-buffer (l)
  "Return most recently used term buffer."
  (when l
    (if (eq 'term-mode (with-current-buffer (car l) major-mode))
        (car l) (last-term-buffer (cdr l)))))

(defun get-term ()
  "Switch to the term buffer last used, or create a new one if
    none exists, or if the current buffer is already a term."
  (interactive)
  (let ((b (last-term-buffer (buffer-list))))
    (if (or (not b) (eq 'term-mode major-mode))
        (multi-term)
      (switch-to-buffer b))))

;; ;; Fix moving around keys and disable yanking mode.
;; (eval-after-load "term"
;;   '(progn
;;      ;; Fix forward/backward word when (term-in-char-mode).
;;      (define-key term-raw-map (kbd "<C-left>")
;;        (lambda () (interactive) (term-send-raw-string "\eb")))
;;      (define-key term-raw-map (kbd "<M-left>")
;;        (lambda () (interactive) (term-send-raw-string "\eb")))
;;      (define-key term-raw-map (kbd "<C-right>")
;;        (lambda () (interactive) (term-send-raw-string "\ef")))
;;      (define-key term-raw-map (kbd "<M-right>")
;;        (lambda () (interactive) (term-send-raw-string "\ef")))
;;      ;; Disable killing and yanking in char mode (term-raw-map).
;;      (mapc
;;       (lambda (func)
;;         (eval `(define-key term-raw-map [remap ,func]
;;                  (lambda () (interactive) (ding)))))
;;       '(backward-kill-paragraph
;;         backward-kill-sentence backward-kill-sexp backward-kill-word
;;         bookmark-kill-line kill-backward-chars kill-backward-up-list
;;         kill-forward-chars kill-line kill-paragraph kill-rectangle
;;         kill-region kill-sentence kill-sexp kill-visual-line
;;         kill-whole-line kill-word subword-backward-kill subword-kill
;;         yank yank-pop yank-rectangle))))
;; (backward-kill-paragraph backward-kill-sentence backward-kill-sexp backward-kill-word bookmark-kill-line kill-backward-chars kill-backward-up-list kill-forward-chars kill-line kill-paragraph kill-rectangle kill-region ...)

