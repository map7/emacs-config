;;; 38-elfeed.el --- Elfeed podcast/feed reader configuration

;;; Code:

(use-package elfeed
  :bind ("C-x w" . elfeed)
  :config
  (setq elfeed-feeds
        '(;; Podcasts - Accounting
          ("https://rss.buzzsprout.com/1761225.rss" podcast accounting)
          ;; Podcasts - Programming / Ruby
          ("https://rss.buzzsprout.com/1878319.rss" podcast ruby)           ; Code with Jason
          ("https://www.spreaker.com/show/6102073/episodes/feed" podcast ruby) ; Ruby Rogues
          ("https://rss.buzzsprout.com/2260490.rss" podcast ruby)           ; Remote Ruby
          ("https://bikeshed.thoughtbot.com/rss" podcast ruby)              ; The Bike Shed
          ("https://www.therubyonrailspodcast.com/rss" podcast ruby rails)  ; Ruby on Rails Podcast
          ;; Podcasts - Tech / Software
          ("https://changelog.com/podcast/feed" podcast tech)               ; The Changelog
          ("https://feed.syntax.fm/rss" podcast tech webdev)                ; Syntax
          ("https://feeds.transistor.fm/practical-ai-machine-learning-data-science-llm" podcast tech ai) ; Practical AI
          ;; Podcasts - Linux / Self-hosting
          ("https://feeds.jupiterbroadcasting.com/lup" podcast linux)       ; LINUX Unplugged
          ("https://feeds.fireside.fm/selfhosted/rss" podcast linux)        ; Self-Hosted
          ("https://feeds.redcircle.com/f8fe71b6-911e-4abb-8fdc-cebda631a2da" podcast homeassistant) ; Home Assistant
          ;; Podcasts - Science / Interviews
          ("https://feeds.megaphone.fm/hubermanlab" podcast science)        ; Huberman Lab
          ("https://lexfridman.com/feed/podcast/" podcast interviews)       ; Lex Fridman
          ("https://rss2.flightcast.com/xmsftuzjjykcmqwolaqn6mdn" podcast interviews) ; Diary of a CEO
          ;; Podcasts - Electronics
          ("https://theamphour.com/feed/podcast/" podcast electronics)      ; The Amp Hour
          ;; Podcasts - Other
          ("https://evilgeniuschronicles.org/feed.xml" podcast)))           ; Evil Genius Chronicles

  ;; Show entries from the last 2 weeks by default
  (setq elfeed-search-filter "@2-weeks-ago +unread")

  ;; Download directory for podcast enclosures
  (setq elfeed-enclosure-default-dir "~/gPodder/Downloads/")

  ;; Wider title column for podcast names
  (setq elfeed-search-title-max-width 80))

;; Play podcast enclosures with mpv
(defun my/elfeed-play-enclosure-mpv ()
  "Play the first enclosure of the current elfeed entry with mpv."
  (interactive)
  (let* ((entry (if (eq major-mode 'elfeed-show-mode)
                    elfeed-show-entry
                  (elfeed-search-selected :single)))
         (enclosures (elfeed-entry-enclosures entry)))
    (if enclosures
        (start-process "mpv" nil "mpv" "--no-video" (caar enclosures))
      (message "No enclosures found for this entry."))))

(defun my/elfeed-download-enclosure ()
  "Download the first enclosure of the current elfeed entry."
  (interactive)
  (let* ((entry (if (eq major-mode 'elfeed-show-mode)
                    elfeed-show-entry
                  (elfeed-search-selected :single)))
         (enclosures (elfeed-entry-enclosures entry)))
    (if enclosures
        (let* ((url (caar enclosures))
               (feed (elfeed-entry-feed entry))
               (feed-title (elfeed-feed-title feed))
               (dir (expand-file-name
                     (replace-regexp-in-string "[^a-zA-Z0-9 _-]" "" feed-title)
                     elfeed-enclosure-default-dir)))
          (unless (file-directory-p dir)
            (make-directory dir t))
          (let ((default-directory dir))
            (start-process "wget" "*elfeed-download*" "wget" "-c" url))
          (message "Downloading to %s" dir))
      (message "No enclosures found."))))

(with-eval-after-load 'elfeed-search
  (define-key elfeed-search-mode-map (kbd "P") #'my/elfeed-play-enclosure-mpv)
  (define-key elfeed-search-mode-map (kbd "D") #'my/elfeed-download-enclosure))

(with-eval-after-load 'elfeed-show
  (define-key elfeed-show-mode-map (kbd "P") #'my/elfeed-play-enclosure-mpv)
  (define-key elfeed-show-mode-map (kbd "D") #'my/elfeed-download-enclosure))

;;; 38-elfeed.el ends here
