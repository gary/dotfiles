;;; ==================================================================
;;; Author:  gary iams
;;; File:    ini-smex
;;; Purpose: Setups for the smex
;;; ==================================================================

(attach-package "/smex")

;;; Initializiation --------------------------------------------------

(eval-after-load "init.el" (smex-initialize))

;;; Customized Variables ---------------------------------------------

(setq smex-save-file (concat tmp-directory "/smex.save"))

;;; Key bindings -----------------------------------------------------

(global-set-key "\C-x\C-m" 'smex)
(global-set-key "\C-c\C-m" 'smex-major-mode-commands)
