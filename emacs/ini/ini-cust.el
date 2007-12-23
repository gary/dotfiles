;;; ==================================================================
;;; Author:  Jim Weirich
;;; File:    ini-cust
;;; Purpose: Custom Setups (Shouldn't this go somewhere else)
;;; ==================================================================

;;; Common aliases ---------------------------------------------------

(defalias 'qrr 'query-replace-regexp)

;;; Quick Access Functions to remote locations -----------------------

(setq quick-access-map (make-sparse-keymap))
(global-set-key "\C-cg" quick-access-map)

;;; Tabbing Helpers --------------------------------------------------

(defun jwt2 ()
  "Set the physical tab width to 4."
  (interactive)
  (setq tab-width 2))

(defun jwt4 ()
  "Set the physical tab width to 4."
  (interactive)
  (setq tab-width 4))

(defun jwt8 ()
  "Set the physical tab width to 8."
  (interactive)
  (setq tab-width 8))

(defun jw-untab ()
  "Remove all tabs from the current buffer."
  (interactive)
  (untabify (point-min) (point-max)) )

(defun jw-retab ()
  "Retab the current file from 8 to 4 tabs."
  (interactive)
  (jwt4)
  (jw-untab)
  (jwt8) )

;;; Select the highlighting colors -----------------------------------

(if (and window-system (not (is-xemacs)))
    (set-face-foreground 'highlight "white"))

(if window-system
    (cond (t
           (set-face-foreground 'highlight "white")
           (set-face-background 'highlight "black")) ))

(defun fa ()
  "Enable filladapt mode"
  (interactive)
  (load-library "filladapt")
  (filladapt-mode))

;;;emacs*cursorColor:   Yellow
;;;emacs*pointerColor:  Cyan
;;;emacs*foreground:    Beige
;;;emacs*background:    DarkSlateBlue
;;;emacs*geometry:      80x50

;;; ... Or use the following code to do much the same thing
;;;     (emacs 18 users should prefix the following commands with "x-"
;;;      e.g. (x-set-mouse-color "cyan"))

;;;(if window-system
;;;    (progn
;;;      (set-mouse-color "cyan")
;;;      (set-cursor-color "yellow")
;;;      (set-background-color "DarkSlateBlue")
;;;      (set-foreground-color "Beige")))

;;; the holy war rages on --------------------------------------------

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
