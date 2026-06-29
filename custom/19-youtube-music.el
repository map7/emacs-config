;; youtube-music - control YouTube Music playback from within Emacs
;; https://github.com/emacsmirror/youtube-music
;;
;; Bound to Shift + multimedia keys (S-XF86Audio*) so the plain media keys
;; stay free for elfeed's mpv controls.
(use-package youtube-music
  :vc (:url "https://github.com/emacsmirror/youtube-music" :rev :newest)
  :bind (("C-c y" . youtube-music)
         ("<S-XF86AudioPlay>" . youtube-music-play-pause)
         ("<S-XF86AudioNext>" . youtube-music-next)
         ("<S-XF86AudioPrev>" . youtube-music-prev)
         ("<S-XF86AudioStop>" . youtube-music-stop))
  :config
  ;; The apt-packaged yt-dlp goes stale quickly; once YouTube switches a video
  ;; to SABR streaming the old extractor returns "Requested format is not
  ;; available" and mpv fails to play with no visible error. Point mpv's
  ;; ytdl_hook at a current user-local yt-dlp when one is present.
  (let ((ytdlp (expand-file-name "~/.local/bin/yt-dlp")))
    (when (file-executable-p ytdlp)
      (add-to-list 'youtube-music-mpv-extra-args
                   (format "--script-opts=ytdl_hook-ytdl_path=%s" ytdlp) t)))
  (youtube-music-modeline-mode 1))