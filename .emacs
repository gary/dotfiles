(require 'cl)

(defvar emacs-root (if (or (eq system-type 'gnu/linux)
			   (eq system-type 'linux))
		       (concat "/home/" user-login-name "/emacs") (concat "/Users/" user-login-name "/emacs"))
  "My home directory - the root of my personal emacs load-path.")

;; add all the elisp directories under ~/emacs to my load path
(labels ((add-path (p)
		   (add-to-list 'load-path
				(concat emacs-root p))))
  (add-path "/")
  (add-path "/modes")		;; additional modes
  (add-path "/site-lisp")		;; elisp from the intarnet
  (add-path "/site-lisp/jde-2.3.5.1/lisp") ;; java ide support
  (add-path "/site-lisp/elib-1.0/")
  (add-path "/site-lisp/cedet-1.0pre3/common")
  (add-path "/site-lisp/wget-0.5.0"))

(load-library "modes")
(load-library "efuncs")
(load-library "ekeys")

;; replacements, extensions
(require 'setnu)
(require 'highlight-beyond-fill-column)
(require 'dabbrev-highlight)
(require 'flash-paren)
;; (require 'browse-kill-ring)
(require 'shell-command)
;; (require 'power-macros) TODO: broken, erroring on ?g L354
(require 'bm)

(load-library "customizations")
 
(shell)