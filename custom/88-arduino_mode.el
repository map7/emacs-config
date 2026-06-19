;; arduino-mode with arduino-cli
;;
;; C-c a c  = compile
;; C-c a u  = upload (USB serial)
;; C-c a t  = upload over TCP (OTA)
;; C-c a s  = set TCP host (manual)
;; C-c a d  = discover and pick TCP host via mDNS
;; C-c a m  = open serial monitor

(defvar arduino-board "esp32:esp32:esp32c3"
  "FQBN for arduino-cli (e.g. \"arduino:avr:uno\", \"esp32:esp32:esp32c3\").")

(defvar arduino-tcp-host "10.1.1.92"
  "TCP host for OTA uploads (e.g. \"192.168.1.100\").")

(defvar arduino-tcp-port "3232"
  "TCP port for OTA uploads.")

(defvar arduino-espota-script
  "~/.arduino15/packages/esp32/hardware/esp32/3.3.5/tools/espota.py"
  "Path to espota.py for ESP32 OTA uploads.")

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

  (defun arduino--discover-ota ()
    "Return alist of (\"name (ip)\" . ip) for ArduinoOTA devices on the LAN."
    (unless (executable-find "avahi-browse")
      (user-error "avahi-browse not found — install avahi-utils"))
    (let ((output (shell-command-to-string
                   "avahi-browse -rtp _arduino._tcp 2>/dev/null"))
          results)
      (dolist (line (split-string output "\n" t))
        ;; Resolved records start with "=" and are ';'-separated:
        ;; =;iface;proto;name;type;domain;hostname;address;port;txt
        (when (string-prefix-p "=" line)
          (let* ((fields (split-string line ";"))
                 (proto  (nth 2 fields))
                 (name   (nth 3 fields))
                 (addr   (nth 7 fields)))
            (when (and (string= proto "IPv4") name addr
                       (not (string-empty-p addr)))
              (push (cons (format "%s (%s)" name addr) addr) results)))))
      (nreverse results)))

  (defun arduino-pick-tcp-host ()
    "Discover ArduinoOTA devices via mDNS and set `arduino-tcp-host'."
    (interactive)
    (let ((devs (arduino--discover-ota)))
      (unless devs
        (user-error "No ArduinoOTA devices found via mDNS"))
      (let ((choice (completing-read "ESP device: " devs nil t)))
        (setq arduino-tcp-host (cdr (assoc choice devs)))
        (message "Arduino TCP host set to %s" arduino-tcp-host))))

  (defun arduino-compile ()
    "Compile the current Arduino sketch."
    (interactive)
    (let ((default-directory (arduino--sketch-dir)))
      (compile (format "arduino-cli compile -b %s ." arduino-board))))

  (defun arduino-upload ()
    "Compile and upload to Arduino over USB serial."
    (interactive)
    (let ((default-directory (arduino--sketch-dir)))
      (compile (format "arduino-cli compile -b %s . && arduino-cli upload -b %s -p %s ."
                       arduino-board arduino-board arduino-serial-port))))

  (defun arduino-upload-tcp ()
    "Upload to Arduino over TCP (OTA) using espota.py."
    (interactive)
    (unless arduino-tcp-host
      (call-interactively #'arduino-set-tcp-host))
    (let* ((default-directory (arduino--sketch-dir))
           (sketch-name (file-name-nondirectory
                         (directory-file-name default-directory)))
           (build-dir "build"))
      (compile (format "arduino-cli compile -b %s --output-dir %s . && python3 %s -d -r -i %s -p %s -f %s/%s.ino.bin"
                       arduino-board
                       build-dir
                       (expand-file-name arduino-espota-script)
                       arduino-tcp-host
                       arduino-tcp-port
                       build-dir
                       sketch-name))))

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
              ("C-c a d" . arduino-pick-tcp-host)
              ("C-c a m" . arduino-serial-monitor)))