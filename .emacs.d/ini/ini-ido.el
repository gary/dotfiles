;;; ==================================================================
;;; Author:  gary iams
;;; File:    ini-ido
;;; Purpose: Setups for the ido package
;;; ==================================================================

(if (is-emacs-22)
    (progn
      (require 'ido)
      (ido-mode 1)
      (ido-everywhere t)
      (setq ido-confirm-unique-completion t)
      (setq ido-default-buffer-method 'samewindow)
      (setq ido-use-filename-at-point t)
      (set-face-background 'ido-first-match "blue3")
      (set-face-foreground 'ido-subdir "SteelBlue1")
      (set-face-foreground 'ido-only-match "blue3")
      (set-face-background 'ido-only-match "white")
      (set-face-foreground 'ido-incomplete-regexp "cornsilk1")
      (set-face-background 'ido-incomplete-regexp "green"))
  (iswitchb-mode 1))



