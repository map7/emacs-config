;;; 24-midi.el --- MIDI file playback using fluidsynth

;;; Commentary:
;;; Play MIDI files from Emacs using fluidsynth.
;;; Keybindings: C-c p (play), C-c s (stop)

;;; Code:

(defvar midi-soundfont "/usr/share/sounds/sf2/FluidR3_GM.sf2"
  "Path to the SF2 soundfont used by fluidsynth.")

(defvar midi-process nil
  "Process handle for the currently running fluidsynth instance.")

(defun midi-play (&optional file)
  "Play a MIDI FILE using fluidsynth. Defaults to the current buffer's file."
  (interactive)
  (let ((midi-file (or file (buffer-file-name))))
    (unless midi-file
      (user-error "No MIDI file associated with this buffer"))
    (midi-stop)
    (setq midi-process
          (start-process "midi-player" "*midi-player*"
                         "fluidsynth" "-a" "pulseaudio" "-ni"
                         midi-soundfont midi-file))
    (message "Playing: %s" (file-name-nondirectory midi-file))))

(defun midi-stop ()
  "Stop the currently playing MIDI file."
  (interactive)
  (when (and midi-process (process-live-p midi-process))
    (delete-process midi-process)
    (setq midi-process nil)
    (message "MIDI playback stopped.")))

(define-minor-mode midi-player-mode
  "Minor mode for playing MIDI files."
  :lighter " MIDI"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "C-c p") #'midi-play)
            (define-key map (kbd "C-c s") #'midi-stop)
            map))

(add-to-list 'auto-mode-alist '("\\.midi?\\'" . midi-player-mode))

(add-hook 'midi-player-mode-hook
          (lambda ()
            (when (buffer-file-name)
              (message "MIDI file loaded. C-c p to play, C-c s to stop."))))

;;; 24-midi.el ends here