;;; invoke M-x with the Alt key
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

(if (boundp 'carbon-emacs-package-version)
    (global-set-key "\C-ch" 'mark-paragraph))

;; prefer backward-kill-word over backspace
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

(define-key (current-global-map) [remap isearch-forward] 'isearch-forward-regexp)
(define-key (current-global-map) [remap isearch-backward] 'isearch-backward-regexp)

;; yeah the hippies
(global-set-key (kbd "C-SPC") 'hippie-expand)
(global-set-key (kbd "<C-return>") 'set-mark-command)

(if (and (boundp 'skeleton-pair)
         (eq skeleton-pair t))
    (progn
      (global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
      (global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
      (global-set-key (kbd "{") 'skeleton-pair-insert-maybe)))

;; search result summary
(define-key isearch-mode-map (kbd "C-o")
  (lambda ()
    (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string
               (regexp-quote isearch-string))))))

(global-unset-key "\C-xm")
(if (eq system-type 'darwin)
    (global-unset-key [f9]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; External steroids

(global-set-key "\C-w" 'backward-kill-word) ; default M-DEL
(global-set-key "\C-o" 'vi-open-next-line) ; old habits die hard

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
(global-set-key "\C-cp" 'windmove-up)
(global-set-key "\C-cn" 'windmove-down)
(global-set-key "\C-cf" 'windmove-right)
(global-set-key "\C-cb" 'windmove-left)

;; redo
(global-set-key "\M-/" 'redo)

;; timeclock
(global-set-key (kbd "C-c t i") 'timeclock-in)
(global-set-key (kbd "C-c t o") 'timeclock-out)
(global-set-key (kbd "C-c t c") 'timeclock-change)
(global-set-key (kbd "C-c t v") 'timeclock-visit-timelog)

;; cheat
(global-set-key (kbd "C-c h") 'cheat)
(global-set-key (kbd "C-c C-h s") 'cheat-sheets)