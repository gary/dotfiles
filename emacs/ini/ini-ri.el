;;; ==================================================================
;;; Author:  Jim Weirich (modifications by gary iams)
;;; File:    ini-ri
;;; Purpose: Setups for the RI command
;;; ==================================================================

;;; Ruby Mode Setups ===============================================

(setq ri-ruby-script
      (expand-file-name (concat root-directory "/ri-emacs.rb")))
(autoload 'ri "ri-ruby.el" nil t)

