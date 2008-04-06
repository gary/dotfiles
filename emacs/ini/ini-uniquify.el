;;; ==================================================================
;;; Author: gary iams
;;; File:   ini-uniquify.el
;;; Purpose: Setups for Making Buffer Names Unique
;;; ==================================================================

;;; Setups for Uniquify ==============================================

;;; Customizations ---------------------------------------------------

(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; ignore special buffers
