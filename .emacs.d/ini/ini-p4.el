;;; ==================================================================
;;; Author:  Jim Weirich
;;; File:    ini-p4
;;; Purpose: Setups for Perforce Integration
;;; ==================================================================

;;; Eiffel Mode Setups ===============================================


(defun p4-edit () 
  "Open the file associated with the current buffer for perforce edit."
  (interactive)
  (call-process "p4" nil "*p4*" t "edit" (buffer-file-name (current-buffer)))
  (revert-buffer t t) )

(defun p4-revert ()
  "Revert the file associated with the current buffer."
  (interactive)
  (call-process "p4" nil "*p4*" t "revert" (buffer-file-name (current-buffer)))
  (revert-buffer t t) )

(global-set-key "\C-cpe" 'p4-edit)
(global-set-key "\C-cpr" 'p4-revert)
