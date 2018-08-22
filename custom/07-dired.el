;; colour your file names
(use-package diredful
  :init
  (diredful-mode 1)  
  :defer 5)

;; (use-package dired-details
;;   :init
;;   (dired-details-install)  
;;   :defer 5
;;   :config
;;   (setq-default dired-details-hidden-string "--- "))

(use-package dired-open
  :init
  (require 'dired-open)
  :defer 5)

(use-package dired-ranger
  :init
  (require 'dired-ranger)
  :defer 5)

(use-package dired-narrow
  :defer 5)


(use-package dired-rainbow
  :config
  (defconst my-dired-media-files-extensions
    '("mp3" "mp4" "MP3" "MP4" "avi" "mpg" "flv" "ogg")
    "Media files.")

  (dired-rainbow-define html "#4e9a06" ("htm" "html" "xhtml"))
  (dired-rainbow-define media "#ce5c00" my-dired-media-files-extensions)

  ; boring regexp due to lack of imagination
  (dired-rainbow-define log (:inherit default
                                      :italic t) ".*\\.log")

  ; highlight executable files, but not directories
  (dired-rainbow-define-chmod executable-unix "Green" "-[rw-]+x.*")
  
  :defer 5)

