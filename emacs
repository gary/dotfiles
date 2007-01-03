(setq load-path (cons "~/.emacs.d/" load-path))

(autoload 'ruby-mode "ruby-mode" "Load ruby-mode")
  (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
  ;; uncomment the next line if you want syntax highlighting
  (add-hook 'ruby-mode-hook 'turn-on-font-lock)

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(transient-mark-mode 1)
(iswitchb-mode 1)

;; invoke M-x with the Alt key
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; prefer backward-kill-word over backspace
(global-set-key "\C-w" 'backward-kill-word) ;; default M-DEL
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;; lose the UI
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(shell)