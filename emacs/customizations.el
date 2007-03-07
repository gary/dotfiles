;; look and feel
(setq initial-frame-alist '(
			    (mouse-color      . "gold")
			    (foreground-color . "cornsilk2")
			    (background-color . "grey7")
			    (top . 10) (left . 650) (width . 123) (height . 60))
      )

(setq default-frame-alist '(
		      (background-color     . "grey7")
		      (foreground-color     . "cornsilk2")
		      (cursor-color         . "gold2")
		      (cursor-type          . box)
		      (active-alpha         . 0.875)
		      (inactive-alpha       . 0.75)
		      (top . 20) (left . 150) (width . 89) (height . 56))
      )

;; aquamacs pretty
(if (boundp 'aquamacs-version)
    (progn
      (one-buffer-one-frame-mode 0)
      (cua-mode 0)
      ;; TODO: test color them with non-darwin systems
      (load-library "color-theme")
      (my-color-theme)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; functionality customizations
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(fset 'yes-or-no-p 'y-or-n-p)
(put 'dired-find-alternate-file 'disabled nil)

;; \M-y calls browse-kill-ring
(browse-kill-ring-default-keybindings)

;; completion mode for shell-command
(shell-command-completion-mode)

;; search result summary
(define-key isearch-mode-map (kbd "C-o")
  (lambda ()
    (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string
               (regexp-quote isearch-string))))))

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(setq default-major-mode 'text-mode)
(global-font-lock-mode 1)
(icomplete-mode 1)
(transient-mark-mode 1)
(iswitchb-mode 1)
(winner-mode 1)

;; lose the UI
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
  
;; ;; jdee
;; (setq jde-global-classpath (quote ("/System/Library/Frameworks/JavaVM.framework/Versions/1.5.0/"
;; 				   "/opt/blackboard/b2/shared/bbjars/6.3/"
;; 				   "/opt/blackboard/b2/shared/bbjars/hibernatedeps/"
;; 				   "/opt/blackboard/b2/shared/bbjars/jstl/"
;; 				   "/opt/blackboard/b2/shared/bbjars/logging/"
;; 				   "/opt/blackboard/b2/shared/bbjars/muohio/")))
;; (setq jde-jdk-registry (quote (("1.5.0" . "/System/Library/Frameworks/JavaVM.framework/Versions/1.5.0")
;; 			       ("1.4.2" . "/System/Library/Frameworks/JavaVM.framework/Versions/1.4.2")
;; 			       ("1.3.1" . "/System/Library/Frameworks/JavaVM.framework/Versions/1.3.1"))))
;; (setq jde-jdk nil)
;; (setq jde-compiler (quote ("javac" "")))
;; (setq jde-jdk-doc-url "http://java.sun.com/j2se/1.5.0/docs/api")
;; (setq jde-complete-function (quote jde-complete-minibuf))
;; (setq jde-enable-abbrev-mode t)
;; (setq jde-ant-home "/Developer/Java/bin")
;; (setq jde-ant-program "ant")
