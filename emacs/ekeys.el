;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; preferences

;; invoke M-x with the Alt key
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; and until i start? handling email in emacs...
(global-unset-key "\C-xm")

(if (boundp 'carbon-emacs-package-version)
    (global-set-key "\C-ch" 'mark-paragraph))

;; prefer backward-kill-word over backspace
(global-set-key "\C-w" 'backward-kill-word) ;; default M-DEL
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; steroids
(global-set-key (kbd "<M-f1>") 'recentf-open-files)
(if (eq emacs-major-version 22)
    (global-set-key "\C-cr" 'xsteve-ido-choose-from-recentf))

(global-set-key "\M-y" 'yank-pop-forward)
(global-set-key "\C-\M-y" 'yank-pop-backward)

(global-set-key "\M-z" 'zap-up-to-char)

;; bookmarking
(global-set-key (kbd "<M-f2>") 'bm-toggle)
(global-set-key (kbd "<f2>") 'bm-next)
(global-set-key (kbd "<S-f2>") 'bm-previous)

;; killing and copying
(global-set-key "\C-cl" 'xsteve-copy-line)
(global-set-key "\C-xc" 'copy-region-as-kill)
(global-set-key "\C-cx" 'kill-paragraph)
;; frame navigation
(global-set-key "\C-cw" 'swap-windows)
(global-set-key "\C-xo" 'windmove-down) ;; other-buffer
(global-set-key "\C-cp" 'windmove-up)
(global-set-key "\C-cn" 'windmove-down)
(global-set-key "\C-cf" 'windmove-right)
(global-set-key "\C-cb" 'windmove-left)