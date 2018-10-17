;; Delay the garabage collection

(setq gc-cons-threshold-original gc-cons-threshold)
(setq gc-cons-threshold 100000000)      ;performace
(setq file-name-handler-alist-original file-name-handler-alist) ;performance
(setq file-name-handler-alist nil)
(run-with-idle-timer                    ;reset
 10 nil
 (lambda ()
   (setq gc-cons-threshold gc-cons-threshold-original)
   (setq file-name-handler-alist file-name-handler-alist-original)))
