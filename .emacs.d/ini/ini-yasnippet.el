;;; ==================================================================
;;; Author:  gary iams
;;; File:    ini-yasnippet
;;; Purpose: Setups for Yet another snippet extension for Emacs (YAsnippet)
;;; ==================================================================

(require 'yasnippet)

;;; Setups for yasnippet =============================================

(yas/initialize)
(yas/load-directory snippet-directory)

;;; Integration with Hippie Expand -----------------------------------

(add-to-list 'hippie-expand-try-functions-list 'yas/hippie-try-expand)
