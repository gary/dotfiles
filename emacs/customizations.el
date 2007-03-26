;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; look and feel
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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


;; lose the UI
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; functionality customizations
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

;; TODO: setup modes for highlight-beyond-fill-column

;; bm
(setq bm-restore-reposistory-on-load t)
(setq-default bm-buffer-persistence t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; always-on modes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq default-major-mode 'text-mode)
(column-number-mode 1)
;;(if (eq invocation-name 'Emacs)
    ;; XEmacs has blink-paren builtin
    (flash-paren-mode 1);)
(global-font-lock-mode 1)
(icomplete-mode 1)
(transient-mark-mode 1)
(iswitchb-mode 1)
(winner-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; extensions to builtin hooks
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
(add-hook 'after-init-hook 'bm-repository-load)
(add-hook 'find-file-hooks 'bm-buffer-restore)
(add-hook 'kill-buffer-hook 'bm-buffer-save)
(add-hook 'kill-emacs-hook '(lambda nil
			      (bm-buffer-save-all)
			      (bm-repository-save)))

(setq interpreter-mode-alist (append '(("ruby" . ruby-mode)
				       interpreter-mode-alist)))

(if (not (boundp 'carbon-emacs-package-version))
    (add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode)))
(add-to-list 'auto-mode-alist '("\\.rhtml\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . html-mode))