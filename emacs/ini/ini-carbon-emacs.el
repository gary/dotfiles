;;; ==================================================================
;;; Author:  gary iams
;;; File:    ini-carbon-emacs
;;; Purpose: Setups for Carbon Emacs, my Emacsen of choice for osx
;;; ==================================================================

;;; Setups for Carbon Emacs ==========================================

(defun gi-frame-transparency ()
  (add-to-list 'initial-frame-alist '(alpha . 80))
  (add-to-list 'default-frame-alist '(alpha . 80)))

;; (if (boundp 'carbon-emacs-package-version)
;;     (progn
(set-face-attribute 'default nil :family "Inconsolata" :height 130)
(add-to-list 'initial-frame-alist '(alpha . 80))
(add-to-list 'default-frame-alist '(alpha . 80));))
(msg "should have added transparency to frame alists!")
(setq mac-option-modifier 'alt)
