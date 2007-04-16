;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; functions stolen from others, with references and credit where possible.
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Xsteve's Emacs page
;; Stefan Reichör, stefan@xsteve.at
;; http://www.xsteve.at/prg/index.html
;; part of xsteve-functions.el
(defun xsteve-copy-line (&optional append)
  "Copies the actual line to the kill ring.
if the optional argument append eq t then append the line to the kill ring."
  (interactive)
  (save-excursion
    (let (start end)
      (beginning-of-line)
      (setq start (point))
      (forward-line 1)
      (setq end (point))
      (if append
          (progn
            (append-next-kill)
            (message "appended line: %s" (buffer-substring start end)))
        (message "%s" (concat "copied: " (buffer-substring start end))))
      (copy-region-as-kill start end)))
  (next-line 1))

;10.10.2000
(defun zap-up-to-char (arg char)
  "Kill up to and excluding ARG'th occurrence of CHAR.
Goes backward if ARG is negative; error if CHAR not found."
  (interactive "*p\ncZap to char: ")
  (kill-region (point)
               (progn
                 (search-forward
                  (char-to-string char) nil nil arg)
                 (progn (goto-char
                         (if (> arg 0) (1- (point)) (1+ (point))))
                        (point)))))

;;; Copyright (C) 1997, 1998 Thien-Thi Nguyen
(defun another-line ()
  "Copy line, preserving cursor column, and increment any numbers found.
This should probably be generalized in the future."
  (interactive)
  (let* ((col (current-column))
         (bol (progn (beginning-of-line) (point)))
         (eol (progn (end-of-line) (point)))
         (line (buffer-substring bol eol)))
    (beginning-of-line)
    (while (re-search-forward "[0-9]+" eol 1)
      (let ((num (string-to-int (buffer-substring
                                  (match-beginning 0) (match-end 0)))))
        (replace-match (int-to-string (1+ num)))))
    (beginning-of-line)
    (insert line "\n")
    (move-to-column col)))

;; emacs lisp stuff
(defun balance-defuns (buffname)
  "Check that every defun in BUFF is balanced (current-buffer if interactive)."
  (interactive "bBuffer to balance: ")
  (let ((buff (get-buffer buffname)))
    (set-buffer buff)
    (let ((next-end (point-min)))
      (condition-case ddd
          (progn
            (while (setq next-end (scan-lists next-end 1 0)))
            (if (interactive-p)
                (message "All defuns balanced.")
              t))
        (error
         (push-mark nil t)
         (goto-char next-end)
         (re-search-forward "\\s(\\|\\s)")
         (backward-char 1)
         (cond ((interactive-p)
                (ding)
                (message "Unbalanced defun."))
               (t nil)))))))

;; TODO: only works with emacs 22... regex check
(defun xsteve-ido-choose-from-recentf ()
  "Use ido to select a recently opened file from the `recentf-list'"
  (interactive)
  (let ((home (expand-file-name (getenv "HOME"))))
    (find-file
     (ido-completing-read "Recentf open: "
                          (mapcar (lambda (path)
                                    (replace-regexp-in-string home "~" path))
                                  recentf-list)
                          nil t))))
;; end XSteve's Emacs Page

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Stevey's Home Page - my .emacs file
;; Steven Yegge, steve.yegge@gmail.com
;; steve.yegge.googlepages.com/my-dot-emacs-file
;; someday might want to rotate windows if more than 2 of them
(defun swap-windows ()
 "If you have 2 windows, it swaps them."
 (interactive)
 (cond ((not (= (count-windows) 2)) (message "You need exactly 2 windows to do this."))
       (t
        (let* ((w1 (first (window-list)))
               (w2 (second (window-list)))
               (b1 (window-buffer w1))
               (b2 (window-buffer w2))
               (s1 (window-start w1))
               (s2 (window-start w2)))
          (set-window-buffer w1 b2)
          (set-window-buffer w2 b1)
          (set-window-start w1 s2)
          (set-window-start w2 s1)))))

;;
;; Never understood why Emacs doesn't have this function.
;;
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

;;
;; Never understood why Emacs doesn't have this function, either.
;;
(defun move-buffer-file (dir)
  "Moves both current buffer and file it's visiting to DIR." (interactive "DNew directory: ")
  (let* ((name (buffer-name))
         (filename (buffer-file-name))
         (dir
          (if (string-match dir "\\(?:/\\|\\\\)$")
              (substring dir 0 -1) dir))
         (newname (concat dir "/" name)))

    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (progn
        (copy-file filename newname 1)
        (delete-file filename)
        (set-visited-file-name newname)
        (set-buffer-modified-p nil) t))))

;; end Stevey's Home Page

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; jwz.org
;; Jamie Zawinski, jwz@jwz.org
;; http://www.jwz.org/doc/tabs-vs-spaces.html
;; renamed from java-mode-untabity
(defun untabify-buffer ()
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward "[ \t]+$" nil t)
        (delete-region (match-beginning 0) (match-end 0)))
      (goto-char (point-min))
      (if (search-forward "\t" nil t)
          (untabify (1- (point)) (point-max))))
    nil)

(defun tabify-buffer ()
  "Tabifies entire buffer."
  (interactive)
  (point-to-register 1)
  (goto-char (point-min))
  (tabify (point-min) (point-max))
  (register-to-point 1))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ola-bini.blogspot.com
;; ola bini
;; http://ola-bini.blogspot.com/2006/06/few-hours-with-emacs.html
(defun indent-or-complete-jde ()
  "Complete if point is at end of a line, otherwise indent line."
  (interactive)
  (if (looking-at "$")
      (jde-complete)
    (indent-for-tab-command)))