(require 'cl)

(defvar emacs-root (if (or (eq system-type 'gnu/linux)
                           (eq system-type 'linux))
                       (concat "/home/" user-login-name "/emacs")
                     (concat "/Users/" user-login-name "/emacs"))
  "My home directory - the root of my personal emacs load-path.")

;; add all the elisp directories under ~/emacs to my load path
(labels ((add-path (p)
                   (add-to-list 'load-path
                                (concat emacs-root p))))
  (add-path "/")
  (add-path "/modes")           ;; additional modes
  (add-path "/modes/mmm-mode-0.4.8")
  (add-path "/modes/rails-0.5.99.2")
  (add-path "/mode-config")
  (add-path "/site-lisp")               ;; elisp from the intarnet
  (add-path "/site-lisp/jde-2.3.5.1/lisp") ;; java ide support
  (add-path "/site-lisp/elib-1.0/")
  (add-path "/site-lisp/cedet-1.0pre3/common")
  (add-path "/site-lisp/wget-0.5.0"))

;; replacements, extensions
(require 'hippie-exp)
(require 'ffap)
(require 'recentf)
(require 'cedet)
(require 'windmove)
(require 'linum)
(require 'highlight-beyond-fill-column)
(require 'dabbrev-highlight)
(require 'mmm-auto)
;; (require 'browse-kill-ring)
(require 'shell-command)
;; (require 'power-macros) TODO: broken, erroring on ?g L354
(require 'bm)

(read-abbrev-file)
(load-library "efuncs")
(load-library "customizations")
(load-library "ekeys")

(load-library "mode-config")
;; TODO: (load-library "mmm-mode-config")
(load-library "jde-mode-config")
(load-library "ruby-mode-config")

(shell)
;; TODO:
;; (custom-set-variables
;;   ;; custom-set-variables was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(mmm-cleanup-submode-face ((t (:background "grey7" :foreground "cornsilk2"))))
;;  '(mmm-code-submode-face ((t (:background "grey7" :foreground "LightGray"))))
;;  '(mmm-comment-submode-face ((t (:background "grey7" :foreground "SkyBlue"))))
;;  '(mmm-declaration-submode-face ((t (:background "grey7" :foreground "Aquamarine"))))
;;  '(mmm-default-submode-face ((t (:background "grey7" :foreground "cornsilk2"))))
;;  '(mmm-init-submode-face ((t (:background "grey7" :foreground "Pink"))))
;;  '(mmm-output-submode-face ((t (:background "grey7" :foreground "Plum"))))
;;  '(mmm-special-submode-face ((t (:background "grey7" :foreground "MediumSpringGreen"))))))