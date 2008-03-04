;;; ==================================================================
;;; Author:  Jim Weirich (modifications by gary iams)
;;; File:    ini-essential.el
;;; Purpose: Essential Emacs Functions and bindings
;;; Version: $Revision: 1.4 $
;;; ==================================================================

;;; Debug Messages ---------------------------------------------------

(defun msg (msg-text)
  "Write a message to the scratch buffer"
  (interactive "sMessage: ")
  (save-excursion
    (set-buffer (get-buffer-create "*msg*"))
    (goto-char (point-max))
    (insert-string msg-text)
    (insert-string "\n") ))

;;; Detect emacs version ---------------------------------------------

(defun is-emacs-19 ()
  (string-equal (substring emacs-version 0 2) "19"))

(defun is-emacs-19-25 ()
  (string-equal (substring emacs-version 0 5) "19.25"))

(defun is-emacs-20 ()
  (string-equal (substring emacs-version 0 2) "20"))

(defun is-emacs-21 ()
  (string-equal (substring emacs-version 0 2) "21"))

(defun is-emacs-22 ()
  (string-equal (substring emacs-version 0 2) "22"))

(defun is-xemacs ()
  (string-match "XEmacs" emacs-version))

;;; Location Detection -----------------------------------------------
;;; This code is used to detect where emacs is running.  The location
;;; test functions allow customization of the setup file.

(defun jw-check-file (fn)
  (file-readable-p fn))

(setq jw-site
      (cond ((jw-check-file "/Users/giams") 'miami)
            ((jw-check-file "/Users/gary") 'home)
            (t 'unknown)))

(setq gi-os
      (cond ((jw-check-file "/proc") 'linux)
            ((jw-check-file "/Applications") 'osx)
            (t 'unknown)))

(defun at-home () (eq jw-site 'home))
(defun at-who-knows-where () (eq jw-site 'unknown))
(defun on-osx () (eq gi-os 'osx))

;;; Always-on Minor Modes --------------------------------------------

(if (and (or (is-emacs-19) (is-emacs-20)) (not (is-xemacs)))
    (transient-mark-mode t)
  (transient-mark-mode 1))

(global-font-lock-mode 1)
(display-time-mode 1)
(column-number-mode 1)
(show-paren-mode 1)
(icomplete-mode 1)

;;; Setup the load path ----------------------------------------------

(defun add-to-load-path (fn)
  "Add expanded file name to load path.
Trailing slashes are stripped and duplicate names are not added."
  (msg fn)
  (let ((ffn (expand-file-name fn)))
    (if (eq (substring ffn -1) "/")
        (setq ffn (substring ffn 0 -1)))
    (if (not (member ffn load-path))
        (setq load-path (cons ffn load-path)))))

(defun add-to-info-path (fn)
  "Add expanded file name to load path.
Trailing slashes are stripped and duplicate names are not added."
  (msg fn)
  (require 'info)
  (let ((ffn (expand-file-name fn)))
    (if (eq (substring ffn -1) "/")
        (setq ffn (substring ffn 0 -1)))
    (if (not (member ffn Info-directory-list))
        (setq Info-directory-list (cons ffn Info-directory-list)))))

(defun lib-is-available (lib-name)
  "Return the containing directory if the library name can be found in the load-path."
  (let ((paths load-path)
        (found nil))
    (while (and paths (not found))
      (if (or (jw-check-file (concat (car paths) "/" lib-name))
              (jw-check-file (concat (car paths) "/" lib-name ".el"))
              (jw-check-file (concat (car paths) "/" lib-name ".elc")))
          (setq found (car paths)))
      (setq paths (cdr paths)))
    found))

(defun attach-package (dir-name)
  "Attach the package in dir-name to the currently running emacs.
The lisp and info subdirectories are added to the load-path and info lookup list."
  (let ((fdn (concat package-directory dir-name))
        (lisp-dir (concat dir-name "/lisp"))
        (info-dir (concat dir-name "/info")))
    (if (jw-check-file lisp-dir)
        (add-to-load-path lisp-dir)
      (add-to-load-path fdn))
    (if (jw-check-file info-dir)
        (add-to-info-path info-dir))))

;;; Define autolist --------------------------------------------------

(defun make-auto (pattern mode)
  "Add a pattern to the auto-mode alist."
  (let ((ans (assoc pattern auto-mode-alist)))
    (if (and ans (equal mode (cdr ans)))
        (print "Do Nothing")
      (print "Added")
      (setq auto-mode-alist
            (cons (cons pattern mode) auto-mode-alist)))))

;;; Loading Function -------------------------------------------------

(defvar ini-loaded ()
  "List of files loaded during initialization.")

(defvar ini-not-loaded ()
  "List of files that failed to load during initialization.")

(defun ini-try-load (inifn ext)
  "Attempt to load an ini-type elisp file."
  (let ((fn (concat ini-directory "/" inifn ext)))
    (if (jw-check-file fn)
        (progn
          (message (concat "Loading " inifn))
          (load-file fn)
          (setq ini-loaded (cons inifn ini-loaded)) ))))

(defun ini-load (inifn)
  "Load a ini-type elisp file"
  (cc)
  (cond ((ini-try-load inifn ".elc"))
        ((ini-try-load inifn ".el"))
        (t (setq ini-not-loaded (cons inifn ini-not-loaded))
           (message (concat inifn " not found")))))

;;; Use bindings for finding files at point (FFAP) ---------------------

(require 'ffap)

(ffap-bindings)
(setq ffap-require-prefix t)

;;; Customized Variables -----------------------------------------------

(setq rlogin-initially-track-cwd t)     ; track dirs in rlogin
(setq next-line-add-newlines nil)       ; C-n will not add lines
(setq require-final-newline t)          ; require files end with newline
(setq auto-save-default nil)            ; don't auto-save (it annoys me)

(defvar compile-command "make ")        ; set the default make command
(make-variable-buffer-local 'compile-command)
                                        ; make the compile command buffer local
                                        ; (this allows each buffer to have its
                                        ;  own custom compile command)

(put 'narrow-to-region 'disabled nil)   ; narrow enabled
(put 'upcase-region 'disabled nil)      ; change case enabled
(put 'eval-expression 'disabled nil)    ; allow eval commands

(fset 'yes-or-no-p 'y-or-n-p)

(defconst use-backup-dir t)
(setq backup-directory-alist (quote ((".*" . "~/.emacs.d/tmp"))) ; TODO: tmp-directory
      version-control t                ; Use version numbers for backups
      kept-new-versions 16             ; Number of newest versions to keep
      kept-old-versions 2              ; Number of oldest versions to keep
      delete-old-versions t            ; Ask to delete excess backup versions?
      backup-by-copying-when-linked t) ; Copy linked files, don't rename.

;;; Key Binding ------------------------------------------------------
;;; The following key bindings are more or less generic.  Bindings for
;;; newly defined functions usually occur in the file defining the
;;; binding.

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key (kbd "C-;") 'comment-region)
(global-set-key (kbd "C-SPC") 'hippie-expand)
(global-set-key (kbd "<C-return>") 'set-mark-command)

(global-set-key "\M-x" 'ispell)
(global-set-key "\M-g" 'goto-line)      ; goto a line position

(global-set-key "\C-c " 'shell)         ; select a shell
(global-set-key "\C-c\C-r" 'shell-resync-dirs) ; resync shell with current dir
(global-set-key "\C-cf" 'auto-fill-mode) ; toggle fill mode
(global-set-key "\C-c^" 'top-level)

(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-x\C-k" 'kill-region)
;;(global-set-key "\C-x\C-m" 'compile)    ; do the compile command
(global-set-key "\C-x\C-n" 'next-error) ; goto next compile error
(global-set-key "\C-x " 'big-shell)     ; select a full screen shell
 
(setq shell-dirstack-query "resync_dirs")

;;; The following are only done in emacs-19 --------------------------

(if (is-emacs-19)
    (progn
      (global-set-key (if (is-xemacs) [(shift backspace)] [S-backspace]) "\C-?")
      (global-set-key [f1] "\C-h")
      (global-set-key [f4] 'call-last-kbd-macro)
      (global-set-key (if (is-xemacs) [(shift f4)] [S-f4]) 'name-last-kbd-macrob)
      ))

(require 'compile)
(setq bad-re "\\([^ :]+\\):\\([0-9]+\\):in")
(defun cc ()(interactive)
  (cc1 compilation-error-regexp-alist))
(defun cc1 (alist)
  (cond ((null alist) ())
        ((atom (car alist)) (cc1 (cdr alist)))
        ((string-equal (caar alist) bad-re) (error "Found bad re"))
        (t (cc1 (cdr alist))) ))

(defun xx () (interactive)
  (dbg "Removing: " (format "%S" (car compilation-error-regexp-alist)))
  (setq compilation-error-regexp-alist (cdr compilation-error-regexp-alist))
  (jw-run-test-method)
  (compilation-minor-mode t))
(global-set-key "\C-cc" 'xx)

(defun zz() (interactive)
  (zz1 compilation-error-regexp-alist))

(defun zz1 (alist)
    (while alist
      (princ (car alist))
      (princ "\n")
      (setq alist (cdr alist)) ))

(defun rr() (interactive)
  (setq compilation-error-regexp-alist (rr1 compilation-error-regexp-alist)))

(defun rr1 (alist)
  (cond ((null alist) nil)
        ((eq 'gnu (car alist)) (cdr alist))
        (t (cons (car alist) (cdr alist))) ))

