;;; ==================================================================
;;; Author:  gary iams
;;; File:    ini-isearch
;;; Purpose: Setups for isearch functionality
;;; ==================================================================

(define-key isearch-mode-map (kbd "C-o") ; search result summary
  (lambda ()
    (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string
               (regexp-quote isearch-string))))))

(define-key (current-global-map)        ; /Everybody stand back/
  [remap isearch-forward] 'isearch-forward-regexp)
(define-key (current-global-map)
  [remap isearch-backward] 'isearch-backward-regexp)
