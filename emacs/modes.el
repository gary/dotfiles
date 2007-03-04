;; java, jsp and friends
;; highlight .prooerties files
;; (add-hook 'conf-javaprop-mode-hook 
;;           '(lambda () (conf-quote-normal nil)))

;; ;; jde setup--temporary for now
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp/jde-2.3.5.1/lisp"))
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp/cedet/common"))
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp/elib"))
;; ;; TODO: speedbar info (require 'sb-info)? breaking info startup
;; (load-file (expand-file-name "~/.emacs.d/site-lisp/cedet/common/cedet.el"))

;; ;; overkill, plan on always autoloading
;; (setq defer-loading-jde t)
;; (if defer-loading-jde
;;     (progn
;;       (autoload 'jde-mode "jde" "JDE mode." t)
;;       (setq auto-mode-alist
;; 	    (append
;; 	     '(("\\.java\\'" . jde-mode))
;; 	     auto-mode-alist)))
;;   (require 'jde))

;; ;; bash as default shell, beware the zsh
;; (setq shell-file-name "bash")
;; (setq shell-command-switch "-c")
;; (setq explicit-shell-file-name shell-file-name)
;; (setenv "SHELL" shell-file-name)
;; (setq explicit-sh-args '("-login" "-i"))
;; ;; end jde setup

;; TODO: mmm-mode replacement
;; (defun jsp-mode () (interactive)
;;       (multi-mode 1
;;                   'html-mode
;;                   '("<%--" indented-text-mode)
;;                   '("<%@" indented-text-mode)
;;                   '("<%=" html-mode)
;;                   '("<%" java-mode)
;;                   '("%>" html-mode)
;;                   '("<script" java-mode)
;;                   '("</script" html-mode)
;;                   ))

;; (setq auto-mode-alist
;;       (append '(("\\.jsp$" . jsp-mode)) auto-mode-alist))
;; (setq interpreter-mode-alist (append '(("jsp" . jsp-mode)
;; 				       interpreter-mode-alist)))
;; end java crap

;; ruby and friends
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode)
				       interpreter-mode-alist)))
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process" t)
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
	  '(lambda ()
	     (inf-ruby-keys)
))
(setq ri-ruby-script (concat emacs-root "/modes/ri-emacs.rb"))
(autoload 'ri "ri-ruby"
  "Ruby api reference" t)

;; psvn
(autoload 'svn-status "psvn"
  "Examine the status of a Subversion working copy in a diretory." t)
