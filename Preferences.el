(one-buffer-one-frame-mode 0)

;; transparent frame
(modify-frame-parameters (selected-frame) '((active-alpha . 0.8)))
(modify-frame-parameters (selected-frame) '((inactive-alpha . 0.4)))

(cua-mode 0)
(transient-mark-mode 1)

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(transient-mark-mode 1)
(iswitchb-mode 1)

;; load shared customizations
(load-library "~/.emacs")