(one-buffer-one-frame-mode 0)

;; transparent frame
(modify-frame-parameters (selected-frame) '((active-alpha . 0.8)))
(modify-frame-parameters (selected-frame) '((inactive-alpha . 0.4)))

(cua-mode 0)

;; load shared customizations
(load-library "~/.emacs")