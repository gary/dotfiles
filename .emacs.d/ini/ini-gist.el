;;; ==================================================================
;;; Author:  gary iams
;;; File:    ini-pastie
;;; Purpose: Setups for Gist
;;; ==================================================================

(attach-package "/gist.el")

;;; Key Bindings -----------------------------------------------------

(global-set-key "\C-c\C-kb" 'gist-buffer)
(global-set-key "\C-c\C-kr" 'gist-region)
(global-set-key "\C-c\C-kg" 'gist-fetch)
