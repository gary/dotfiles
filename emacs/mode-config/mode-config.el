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