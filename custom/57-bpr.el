;; Common tasks to do in the background

;; Run tests on a rails project
(defun rspec-tests ()
  "Spawns test process"
  (interactive)
  (let* ((bpr-scroll-direction -1) ;; scroll to the top of the output window (which is being shown in case of error)
         (bpr-close-after-success t)) ;; close error window after process ended successfully (if it's not already closed)
    (bpr-spawn "bundle exec rake spec")))
