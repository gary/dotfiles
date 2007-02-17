(setq load-path (cons "~/.emacs.d/" load-path))

(fset 'yes-or-no-p 'y-or-n-p)

(defun iwb()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

;; ruby
(load-library "ruby-mode")
(load-library "inf-ruby")
(setq ri-ruby-script "/Users/sm41Eg01/.emacs.d/ri-emacs.rb")
(load-library "ri-ruby")

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(transient-mark-mode 1)
(iswitchb-mode 1)
(winner-mode 1)

;; invoke M-x with the Alt key
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; prefer backward-kill-word over backspace
(global-set-key "\C-w" 'backward-kill-word) ;; default M-DEL
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;; lose the UI
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1)) ;; aquamacs issues
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(shell)