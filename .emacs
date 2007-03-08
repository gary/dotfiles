(require 'cl)

(defvar emacs-root (if (or (eq system-type 'gnu/linux)
			   (eq system-type 'linux))
		       (concat "/home/" user-login-name "/") (concat "/Users/" user-login-name "/"))
  "My home directory - the root of my personal emacs load-path.")

;; add all the elisp directories under ~/emacs to my load path
(labels ((add-path (p)
		   (add-to-list 'load-path
				(concat emacs-root p))))
  (add-path "emacs")
  (add-path "emacs/modes")		;; additional modes
  (add-path "emacs/site-lisp")		;; elisp from the intarnet
  (add-path "emacs/site-lisp/jde-2.3.5.1/lisp") ;; java ide support
  (add-path "emacs/site-lisp/elib-1.0/")
  (add-path "emacs/site-lisp/cedet-1.0pre3/common")
  (add-path "emacs/site-lisp/emacs-wget-0.5.0")
)

(load-library "modes")
(load-library "ekeys")

;; replacements, extensions
(require 'setnu)
(require 'dabbrev-highlight)
(require 'browse-kill-ring)
(require 'shell-command)

(load-library "customizations")
 
(shell)