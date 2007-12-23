;;; ==================================================================
;;; Author: Jim Weirich
;;; File:   ini-4sh.el
;;; Purpose: Provide 4 parallel shell windows
;;; ==================================================================

(setq four-shell-list '(1 2 3 4))
(setq four-shell-last (nth (- (length four-shell-list) 1) four-shell-list))

(defun four-shells ()
  "Split the window into four shells for debugging."
  (interactive)
  (delete-other-windows)
  (let ((win-size (/ (nth 3 (window-edges)) (length four-shell-list))))
    (mapcar '(lambda (n) 
	       (let ((buf-name (concat "*shell-" n "*")))
		 (if (not (get-buffer buf-name)) (multi-shell n))
		 (set-window-buffer (selected-window) buf-name) 
		 (goto-char (point-max))
		 (if (equal n four-shell-last)
		     (other-window -3)
		   (split-window-vertically win-size)
		   (other-window 1) )))
	    four-shell-list)
    ))

(defun clobber-shells ()
  "Delete contents of the four shell windows."
  (interactive)
  (mapcar '(lambda (n)
	     (let ((buf-name (concat "*shell-" n "*")))
	       (switch-to-buffer buf-name)
	       (delete-region (point-min) (point-max)) ))
	    four-shell-list)
  (four-shells) )

(global-set-key "\C-c4" 'four-shells)
(global-set-key "\C-c5" 'clobber-shells)
