(defvar root-directory (expand-file-name (concat "~" user-login-name "/.emacs.d"))
  "The root directory of my emacs configuration.")

(defvar info-directory (concat root-directory "/info")
  "The directory where all of my packages' Info documentation files live.")

(defvar ini-directory
  (concat root-directory "/ini")
  "The directory for all ini-type elisp files that will be loaded
during initialization.")
(setq load-path (cons ini-directory load-path))

(defvar package-directory (concat root-directory "/packages")
  "The directory for elisp packages contained that are contained in
their own subdirectories")

(defvar snippet-directory (concat root-directory "/snippets")
  "The directory for where all modes' snippets live.")

(defvar tmp-directory (concat root-directory "/tmp")
  "The directory that houses backups, cache files, and other
miscellaneous files.")

(require 'font-lock)

(load "essential")

(if (jw-check-file "/usr/local/share/emacs/site-lisp")
    (add-to-load-path "/usr/local/share/emacs/site-lisp"))

(if (jw-check-file "/usr/share/emacs/site-lisp")
    (add-to-load-path "/usr/share/emacs/site-lisp"))

(add-to-load-path root-directory)

(add-to-list 'load-path "/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/share/emacs/site-lisp") ;TODO

;;; Now load all the ini-xxx files in the initialization directory

(let ((files (directory-files ini-directory nil "^ini-.*\\.el$")))
  (while (not (null files))
    (ini-load (substring (car files) 0 -3))
    (setq files (cdr files)) ))

(if (eq ini-not-loaded nil)
    (message "All Initialization Files Loaded")
  (message (concat "Failed to Load "
          (int-to-string (length ini-not-loaded)) " Initialization Files: "
          (list-to-string
           (mapcar
            (function (lambda (x) (concat x " "))) ini-not-loaded)))))
