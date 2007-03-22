;; look and feel
(setq initial-frame-alist '(
			    (mouse-color      . "gold")
			    (foreground-color . "cornsilk2")
			    (background-color . "grey7")
			    (top . 25) (left . 10) (width . 125) (height . 50))
      )

(setq default-frame-alist '(
		      (background-color     . "grey7")
		      (foreground-color     . "cornsilk2")
		      (cursor-color         . "gold2")
		      (cursor-type          . box)
		      (top . 25) (left . 10) (width . 125) (height . 50))
      )

(if (boundp 'carbon-emacs-package-version)
    (progn
      (add-to-list 'initial-frame-alist '(alpha . 65))
      (add-to-list 'default-frame-alist '(alpha . 65))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; functionality
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(fset 'yes-or-no-p 'y-or-n-p)
(put 'dired-find-alternate-file 'disabled nil)

;; \M-y calls browse-kill-ring
;; (browse-kill-ring-default-keybindings)
(autoload 'yank-pop-forward "yank-pop-summary" nil t)
(autoload 'yank-pop-backward "yank-pop-summary" nil t)

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
;;(if (eq invocation-name 'Emacs)
    ;; XEmacs has blink-paren builtin
    (flash-paren-mode 1);)
(global-font-lock-mode 1)
(icomplete-mode 1)
(transient-mark-mode 1)
(iswitchb-mode 1)
(winner-mode 1)

;; lose the UI
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; TODO: setup modes for highlight-beyond-fill-column