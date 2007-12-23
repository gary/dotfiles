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

;;; Now load all the ini-xxx files in the initialization directory

(let ((files (directory-files ini-directory nil "^ini-.*\\.el$")))
  (while (not (null files))
    (ini-load (substring (car files) 0 -3))
    (setq files (cdr files)) ))

(message "Initialization Files Loaded")

;; (custom-set-variables
;;  '(init-face-from-resources nil)
;;  '(mm-inline-media-tests (quote (("image/jpeg" mm-inline-image (lambda (handle) (mm-valid-and-fit-image-p (quote jpeg) handle))) ("image/png" mm-inline-image (lambda (handle) (mm-valid-and-fit-image-p (quote png) handle))) ("image/gif" mm-inline-image (lambda (handle) (mm-valid-and-fit-image-p (quote gif) handle))) ("image/tiff" mm-inline-image (lambda (handle) (mm-valid-and-fit-image-p (quote tiff) handle))) ("image/xbm" mm-inline-image (lambda (handle) (mm-valid-and-fit-image-p (quote xbm) handle))) ("image/x-xbitmap" mm-inline-image (lambda (handle) (mm-valid-and-fit-image-p (quote xbm) handle))) ("image/xpm" mm-inline-image (lambda (handle) (mm-valid-and-fit-image-p (quote xpm) handle))) ("image/x-pixmap" mm-inline-image (lambda (handle) (mm-valid-and-fit-image-p (quote xpm) handle))) ("image/bmp" mm-inline-image (lambda (handle) (mm-valid-and-fit-image-p (quote bmp) handle))) ("text/plain" mm-inline-text identity) ("text/enriched" mm-inline-text identity) ("text/richtext" mm-inline-text identity) ("text/x-patch" mm-display-patch-inline (lambda (handle) (locate-library "diff-mode"))) ("application/emacs-lisp" mm-display-elisp-inline identity) ("text/x-vcard" mm-inline-text (lambda (handle) (or (featurep (quote vcard)) (locate-library "vcard")))) ("message/delivery-status" mm-inline-text identity) ("message/rfc822" mm-inline-message identity) ("message/partial" mm-inline-partial identity) ("text/.*" mm-inline-text identity) ("audio/wav" mm-inline-audio (lambda (handle) (and (or (featurep (quote nas-sound)) (featurep (quote native-sound))) (device-sound-enabled-p)))) ("audio/au" mm-inline-audio (lambda (handle) (and (or (featurep (quote nas-sound)) (featurep (quote native-sound))) (device-sound-enabled-p)))) ("application/pgp-signature" ignore identity) ("multipart/alternative" ignore identity) ("multipart/mixed" ignore identity) ("multipart/related" ignore identity))))
;;  '(load-home-init-file t t)
;;  '(gnuserv-program (concat exec-directory "/gnuserv"))
;;  '(toolbar-news-reader (quote gnus))
;;  '(toolbar-mail-reader (quote gnus))
;;  '(ecb-source-path (quote (("/home/jim/working/rubyforge/rubygems" "RubyGems") ("/home/jim/working/rubyforge/rake" "Rake")))))

(setq minibuffer-max-depth nil)
