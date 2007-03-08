;; look and feel
(setq initial-frame-alist '(
			    (mouse-color      . "gold")
			    (foreground-color . "cornsilk2")
			    (background-color . "grey7")
			    (active-alpha         . 0.875)
			    (inactive-alpha       . 0.75)
			    (top . 25) (left . 10) (width . 125) (height . 50))
      )

(setq default-frame-alist '(
		      (background-color     . "grey7")
		      (foreground-color     . "cornsilk2")
		      (cursor-color         . "gold2")
		      (cursor-type          . box)
		      (active-alpha         . 0.875)
		      (inactive-alpha       . 0.75)
		      (top . 25) (left . 10) (width . 125) (height . 50))
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
;; functionality customizations
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