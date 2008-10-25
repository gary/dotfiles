;;; Minimal logging to ~/log/channel
(add-hook 'rcirc-print-hooks 'rcirc-write-log)
(defcustom rcirc-log-directory "~/.emacs.d/irc-logs"
  "Where logs should be kept.  If nil, logs aren't kept.")
(defun rcirc-write-log (process sender response target text)
  (when rcirc-log-directory
    (with-temp-buffer
      ;; Sometimes TARGET is a buffer :-(
      (when (bufferp target)
        (setq target (with-current-buffer buffer rcirc-target)))

      ;; Sometimes buffer is not anything at all!
      (unless (or (null target) (string= target ""))
        ;; Print the line into the temp buffer.
        (insert (format-time-string "%Y-%m-%d %H:%M "))
        (insert (format "%-16s " (rcirc-user-nick sender)))
        (unless (string= response "PRIVMSG")
          (insert "/" (downcase response) " "))
        (insert text "\n")

        ;; Append the line to the appropriate logfile.
        (let ((coding-system-for-write 'no-conversion))
          (write-region (point-min) (point-max)
                        (concat rcirc-log-directory "/" (downcase target))
                        t 'quietly))))))
