;;; ==================================================================
;;; Author:  gary iams
;;; File:    ini-el4r
;;; Purpose: Setups for Emacs Lisp 4 Ruby
;;; ==================================================================

;;; Setups for el4r ==================================================

(if (lib-is-available "el4r")
    (progn
      (require 'el4r)
      (el4r-boot)))

;; User-setting area is below this line.
