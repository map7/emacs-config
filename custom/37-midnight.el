;; Automatically run tasks at midnight
;; 
(require 'midnight)

(midnight-delay-set 'midnight-delay "4:00am")
(add-hook 'midnight-hook 'puborg)       ; Publish the knowledge base
