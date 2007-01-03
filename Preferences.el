(one-buffer-one-frame-mode 0)

;; transparent frame
(modify-frame-parameters (selected-frame) '((active-alpha . 0.8)))
(modify-frame-parameters (selected-frame) '((inactive-alpha . 0.4)))

(cua-mode 0)
(transient-mark-mode 1)

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(transient-mark-mode 1)
(iswitchb-mode 1)

;; TODO: reference ~/.emacs for shared functionality
;; invoke M-x with the Alt key
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; prefer backward-kill-word over backspace
(global-set-key "\C-w" 'backward-kill-word) ;; default M-DEL
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;; lose the UI - percent issues with Aquamacs, for now
;; (if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(global-set-key "\C-x\C-z" 'zap-to-char)

(shell)
