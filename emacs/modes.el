(add-hook 'text-mode-hook '(lambda ()
			(turn-on-auto-fill)))
			;; (turn-on-setnu-mode))) ;; yes, i prefer vi-style line numbering

(if (boundp 'aquamacs-version)
    (add-hook 'help-mode-hook '(lambda ()
			    (my-color-theme))))
;; shell-mode
;; TODO: tim's crazy .bbprofileshared still not cooperating
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
  "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)

;; java, jsp and friends
;; highlight .properties files
(add-hook 'conf-javaprop-mode-hook 
          '(lambda () (conf-quote-normal nil)))

;; TODO: speedbar info (require 'sb-info)? breaking info startup
;; initialize CEDET
(load-library "cedet")

;; jde-mode
;; TODO: classpath scanning issue; unable to complete/view any non-core classes (Bb, Log4J, Muohio)
;; overkill, plan on always autoloading
(setq defer-loading-jde t)
(if defer-loading-jde
    (progn
      (autoload 'jde-mode "jde" "JDE mode." t)
      (setq auto-mode-alist
	    (append
	     '(("\\.java\\'" . jde-mode))
	     auto-mode-alist)))
  (require 'jde))

(add-hook 'jde-mode-hook
	  '(lambda ()
	     (c-subword-mode)
	     (c-toggle-auto-hungry-state)))

;; bash as default shell, beware the zsh
(setq shell-file-name "bash")
(setq shell-command-switch "-c")
(setq explicit-shell-file-name shell-file-name)
(setenv "SHELL" shell-file-name)
(setq explicit-sh-args '("-login" "-i"))
;; end jdee

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
	     (inf-ruby-keys)))
(setq ri-ruby-script (concat emacs-root "/modes/ri-emacs.rb"))
(autoload 'ri "ri-ruby" "Ruby api reference" t)

(autoload 'svn-status "psvn"
  "Examine the status of a Subversion working copy in a directory." t)

(autoload 'ssh "ssh"
	  "Open a network login connection via ssh with args input-args." t)

(autoload 'wget "wget" "wget interface for Emacs." t)
(autoload 'wget-web-page "wget" "wget interface to download whole web page." t)
(if (eq system-type "darwin")
    (add-hook 'wget-load-hook
	      (setq wget-download-directory "~/dls")))