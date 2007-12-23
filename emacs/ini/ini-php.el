;;; ==================================================================
;;; Author:  gary iams
;;; File:    ini-php
;;; Purpose: Setups for PHP mode
;;; ==================================================================

;;; PHP mode setups ==================================================

;;; auto loads -------------------------------------------------------

(defun gi-php-whitespace ()
  (setq indent-tabs-mode t)
  (setq c-basic-offset 4))

(add-hook 'php-mode-hook 'gi-php-whitespace)
