(add-hook 'text-mode-hook '(lambda ()
			(turn-on-auto-fill)))

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
(defun ruby-eval-buffer ()
  (interactive)
  "Evaluate the buffer with ruby."
  (shell-command-on-region (point-min) (point-max) "ruby"))

(require 'ruby-electric)
(add-hook 'ruby-mode-hook
	  '(lambda ()
	     (inf-ruby-keys)
	     (define-key ruby-mode-map "\C-c\C-a" 'ruby-eval-buffer)
	     (font-lock-mode t)
	     ;; (pabbrev-mode t) doh
	     (ruby-electric-mode t)))
(setq ri-ruby-script (concat emacs-root "/modes/ri-emacs.rb"))
(autoload 'ri "ri-ruby" "Ruby api reference" t)

(autoload 'svn-status "psvn"
  "Examine the status of a Subversion working copy in a directory." t)

(autoload 'ssh "ssh"
	  "Open a network login connection via ssh with args input-args." t)

(autoload 'wget "wget" "wget interface for Emacs." t)
(autoload 'wget-web-page "wget" "wget interface to download whole web page." t)
;; TODO not working
(add-hook 'wget-load-hook
	  '(lambda ()
	     (if (eq system-type "darwin")
		 (setq wget-download-directory "~/dls"))))