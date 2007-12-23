;;; ==================================================================
;;; Author:  Jim Weirich
;;; File:    ini-abbrev
;;; Purpose: Setup for Abbreviation Mode
;;; ==================================================================

;;; Setup for Abbreviation Mode ======================================

(defun ab ()
  "Toggle abbreviation mode."
  (interactive)
  (abbrev-mode))

;(setq-default abbrev-mode nil)
;;(read-abbrev-file)

;;(define-abbrev-table 'ruby-mode-abbrev-table '(
;;    ("bt" "belongs_to" nil 1)
;;    ("hm" "has_many" nil 1)
;;     ("ho" "has_one" nil 1)
;;     ))

