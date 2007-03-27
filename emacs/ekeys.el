;; invoke M-x with the Alt key
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; and until i start? handling email in emacs...
(global-unset-key "\C-xm")

;; prefer backward-kill-word over backspace
(global-set-key "\C-w" 'backward-kill-word) ;; default M-DEL
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;; yank-pop on steroids
(global-set-key "\M-y" 'yank-pop-forward)
(global-set-key "\C-\M-y" 'yank-pop-backward)

;; zap-to-char likes them too
(global-set-key "\M-z" 'zap-up-to-char)

;; enhanced bookmarks
(global-set-key (kbd "<M-f2>") 'bm-toggle)
(global-set-key (kbd "<f2>") 'bm-next)
(global-set-key (kbd "<S-f2>") 'bm-previous)

;; custom defuns
(global-set-key "\C-cl" 'xsteve-copy-line)
(global-set-key "\C-cw" 'swap-windows)