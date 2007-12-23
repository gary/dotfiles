;;; ==================================================================
;;; Author:  Jim Weirich
;;; File:    ini-ri
;;; Purpose: Setups for the RI command
;;; ==================================================================

;;; Ruby Mode Setups ===============================================

(setq ri-ruby-script
      (expand-file-name (concat "~" user-login-name "/.elisp/packages/ri-emacs.rb")))
(autoload 'ri "ri-ruby.el" nil t)

