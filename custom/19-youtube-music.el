;; youtube-music - control YouTube Music playback from within Emacs
;; https://github.com/emacsmirror/youtube-music
;;
;; Loaded after 38-elfeed.el so the multimedia (XF86Audio*) keys bind to
;; youtube-music rather than elfeed's mpv controls.
(use-package youtube-music
  :vc (:url "https://github.com/emacsmirror/youtube-music" :rev :newest)
  :bind (("C-c y" . youtube-music)
         ("<XF86AudioPlay>" . youtube-music-play-pause)
         ("<XF86AudioNext>" . youtube-music-next)
         ("<XF86AudioPrev>" . youtube-music-prev)
         ("<XF86AudioStop>" . youtube-music-stop))
  :config (youtube-music-modeline-mode 1))