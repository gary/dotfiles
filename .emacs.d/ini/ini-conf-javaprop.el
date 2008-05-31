;;; ==================================================================
;;; Author:  gary iams
;;; File:    ini-conf-javaprop
;;; Purpose: Setups for the Conf Mode start for Java properties files
;;; ==================================================================

;;; Setups for Java Properties files =================================

(add-hook 'conf-javaprop-mode-hook '(lambda () (conf-quote-normal nil)))
