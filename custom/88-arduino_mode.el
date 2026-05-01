;; arduino-mode with arduino-cli
;;
;; C-c a c  = compile
;; C-c a u  = upload (USB serial)
;; C-c a t  = upload over TCP (OTA)
;; C-c a s  = set TCP host
;; C-c a m  = open serial monitor

(defvar arduino-board "esp32:esp32:esp32c3"
  "FQBN for arduino-cli (e.g. \"arduino:avr:uno\", \"esp32:esp32:esp32c3\").")

(defvar arduino-tcp-host "10.1.1.92"
  "TCP host for OTA uploads (e.g. \"192.168.1.100\").")

(defvar arduino-tcp-port "3232"
  "TCP port for OTA uploads.")

(defvar arduino-serial-port "/dev/ttyACM0"
  "Serial port for USB uploads and monitoring.")

(defun arduino--sketch-dir ()
  "Find the sketch directory (directory containing the .ino file)."
  (or (locate-dominating-file default-directory
        (lambda (dir)
          (directory-files dir nil "\\.ino\\'" t)))
      default-directory))

(use-package arduino-mode
  :mode "\\.ino\\'"
  :config
  (defun arduino-set-tcp-host (host)
    "Set the TCP HOST for OTA uploads."
    (interactive "sArduino TCP host (e.g. 192.168.1.100): ")
    (setq arduino-tcp-host host)
    (message "Arduino TCP host set to %s:%s" host arduino-tcp-port))

  (defun arduino-compile ()
    "Compile the current Arduino sketch."
    (interactive)
    (let ((default-directory (arduino--sketch-dir)))
      (compile (format "arduino-cli compile -b %s ." arduino-board))))

  (defun arduino-upload ()
    "Upload to Arduino over USB serial."
    (interactive)
    (let ((default-directory (arduino--sketch-dir)))
      (compile (format "arduino-cli upload -b %s -p %s ."
                       arduino-board arduino-serial-port))))

  (defun arduino-upload-tcp ()
    "Upload to Arduino over TCP (OTA)."
    (interactive)
    (unless arduino-tcp-host
      (call-interactively #'arduino-set-tcp-host))
    (let ((default-directory (arduino--sketch-dir)))
      (compile (format "arduino-cli compile -b %s . && arduino-cli upload -b %s -p %s --upload-field password= ."
                       arduino-board arduino-board arduino-tcp-host))))

  (defun arduino-serial-monitor ()
    "Open serial monitor for the Arduino."
    (interactive)
    (let ((buf (get-buffer-create "*arduino-monitor*")))
      (with-current-buffer buf (erase-buffer))
      (start-process "arduino-monitor" buf
                     "arduino-cli" "monitor" "-p" arduino-serial-port)
      (display-buffer buf)))
  :bind (:map arduino-mode-map
              ("C-c a c" . arduino-compile)
              ("C-c a u" . arduino-upload)
              ("C-c a t" . arduino-upload-tcp)
              ("C-c a s" . arduino-set-tcp-host)
              ("C-c a m" . arduino-serial-monitor)))