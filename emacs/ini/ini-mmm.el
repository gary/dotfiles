;;; ==================================================================
;;; Author:  gary iams
;;; File:    ini-mmm
;;; Purpose: Setups for Multiple Major Modes
;;; ==================================================================

(attach-package "mmm-mode-0.4.8")
(require 'mmm-auto)

;;; Setups for MMM mode ==============================================

(setq mmm-global-mode 'maybe)
(setq mmm-submode-decoration-level 2)

;;; New mode combinations --------------------------------------------

(mmm-add-mode-ext-class nil "\\.jsp$" 'embedded-css)
(mmm-add-mode-ext-class nil "\\.jsp$" 'html-js)
(mmm-add-mode-ext-class nil "\\.jsp$" 'jsp) ;;

;;; Color adjustments ------------------------------------------------

(custom-set-faces
 '(mmm-cleanup-submode-face ((t (:background "Wheat" :foreground "black"))))
 '(mmm-code-submode-face ((t (:background "LightGray" :foreground "black"))))
 '(mmm-comment-submode-face ((t (:background "SkyBlue" :foreground "black"))))
 '(mmm-declaration-submode-face ((t (:background "Aquamarine" :foreground "black"))))
 '(mmm-default-submode-face ((t (:background "gray85" :foreground "black"))))
 '(mmm-init-submode-face ((t (:background "Pink" :foreground "black"))))
 '(mmm-output-submode-face ((t (:background "Plum" :foreground "black"))))
 '(mmm-special-submode-face ((t (:background "MediumSpringGreen" :foreground "black")))))
