;;; ==================================================================
;;; Author:  gary iams
;;; File:    ini-ffap
;;; Purpose: Setups for Finding Files At Point (FFAP)
;;; ==================================================================

;;; Setups for ffap ==================================================

(ffap-bindings) ; autoload

;;; Customize FFAP Mode Variables ------------------------------------

(setq ffap-require-prefix t)

;;; Goto line number if available ------------------------------------

;; (defadvice find-file-at-point (around goto-line compile activate)
;;   (let ((line (and (looking-at ".*:\\([0-9]+\\)")
;;                    (string-to-number (match-string 1)))))
;;     ad-do-it
;;     (and line (goto-line line))))
