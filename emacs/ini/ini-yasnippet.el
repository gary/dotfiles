;;; ==================================================================
;;; Author:  gary iams
;;; File:    ini-yasnippet
;;; Purpose: Setups for Yet another snippet extension for Emacs (YAsnippet)
;;; ==================================================================

(require 'yasnippet)

;; Setups for yasnippet ==============================================

(yas/initialize)
(yas/load-directory snippet-directory)
