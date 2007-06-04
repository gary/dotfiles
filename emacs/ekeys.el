;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; TODO: change key abbreviations to XEmacs style

;; invoke M-x with the Alt key
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; and until i start? handling email in emacs...
(global-unset-key "\C-xm")

(if (boundp 'carbon-emacs-package-version)
    (global-set-key "\C-ch" 'mark-paragraph))

;; prefer backward-kill-word over backspace
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

(global-set-key "\C-s" 'isearch-forward-regexp)
(global-set-key "\C-r" 'isearch-backward-regexp)
(global-unset-key "\C-\M-s")
(global-unset-key "\C-\M-r")

;; yeah the hippies
(global-set-key (kbd "C-SPC") 'hippie-expand)
(global-set-key (kbd "<C-return>") 'set-mark-command)
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-expand-file-name-partially
        try-expand-file-name
        try-expand-lisp-symbol-partially
        try-expand-lisp-symbol
        try-expand-whole-kill))

(if (and (boundp 'skeleton-pair)
         (eq skeleton-pair t))
    (progn
      (global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
      (global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
      (global-set-key (kbd "{") 'skeleton-pair-insert-maybe)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; external steroids

(global-set-key "\C-w" 'kill-syntax-backward)
(global-set-key "\C-d" 'kill-syntax-forward)

;; old habits die hard
(global-set-key "\C-o" 'vi-open-next-line)

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
(global-set-key "\C-cx" 'kill-paragraph)

;; frame navigation
(global-set-key "\C-cw" 'swap-windows)
(global-set-key "\C-xo" 'windmove-down) ;; other-buffer
(global-set-key "\C-cp" 'windmove-up)
(global-set-key "\C-cn" 'windmove-down)
(global-set-key "\C-cf" 'windmove-right)
(global-set-key "\C-cb" 'windmove-left)