;;; ==================================================================
;;; Author:  gary iams
;;; File:    ini-keyboard
;;; Purpose: Setups for Yank-Pop with Summary
;;; ==================================================================

;;; Setups for yank-pop with summary =================================
(require 'yank-pop-summary)

(autoload 'yank-pop-forward "yank-pop-summary" nil t)
(autoload 'yank-pop-backward "yank-pop-summary" nil t)

(global-set-key "\M-y" 'yank-pop-forward)
(global-set-key "\C-\M-y" 'yank-pop-backward)
