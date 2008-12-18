;;; ==================================================================
;;; Author:  gary iams
;;; File:    ini-display
;;; Purpose: Setups for the display components of Emacs
;;; ==================================================================

;;; Setups for Emacs' Display ========================================

;;; Discourage use of the mouse --------------------------------------

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;;; Fonts ------------------------------------------------------------

(if (is-carbon-emacs)
    (set-face-attribute 'default nil :family "Inconsolata" :height 130))

;;; Frame ------------------------------------------------------------

(setq initial-frame-alist '((mouse-color . "gold")
                            (top . 25) (left . 10) (width . 161) (height . 50)))
(setq default-frame-alist '((cursor-color . "gold2")
                            (cursor-type . box)
                            (top . 25) (left . 10) (width . 161) (height . 50)))

(if (is-carbon-emacs)
    (progn
      (add-to-list 'initial-frame-alist '(alpha . 80))
      (add-to-list 'default-frame-alist '(alpha . 80))))

(setq-default show-trailing-whitespace t)

;;; Fringe -----------------------------------------------------------

(if (is-emacs-22)
    (progn
      (set-fringe-mode (quote (nil . (nil . nil))))
      (setq-default indicate-buffer-boundaries 'left)))

;;; Mode Line --------------------------------------------------------

(setq display-time-24hr-format t)

(require 'timeclock)
(timeclock-modeline-display)

(global-set-key "\C-c\C-ki" 'timeclock-in)
(global-set-key "\C-c\C-ko" 'timeclock-out)
(global-set-key "\C-c\C-kc" 'timeclock-change)
(global-set-key "\C-c\C-kv" 'timeclock-visit-timelog)
