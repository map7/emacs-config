(use-package whisper
  :straight (whisper :type git :host github :repo "natrys/whisper.el")
  :bind (("C-c w" . whisper-run)
         ("<f12>" . whisper-run))
  :config
  (setq whisper-install-directory "~/src/whisper.cpp"
        whisper-model "base.en"
        whisper-language "en"
        whisper-translate nil
        whisper-use-threads 8))
