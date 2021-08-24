(setq gc-cons-threshold 100000000)     ;; Delay the garabage collection

(setq read-process-output-max (* 1024 1024)) ;; 1mb

(setq file-name-handler-alist-original file-name-handler-alist) ; Save original
(setq file-name-handler-alist nil)

;; restore after startup
(add-hook 'after-init-hook #'(lambda ()
                               (setq gc-cons-threshold 800000)
                               (setq file-name-handler-alist file-name-handler-alist-original)))
