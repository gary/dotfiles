;;; ==================================================================
;;; Author: gary iams
;;; File:   ini-elscreen.el
;;; Purpose: Setups for ElScreen and its Add-Ons
;;; ==================================================================

;;; Setups for ElScreen ==============================================

(load-library "elscreen")
;; (load-library "elscreen-dired") ; find-file-in-other-window (o)
(load-library "elscreen-dnd")           ; drag-n-drop with osx and x11
;; (load-library "elscreen-speedbar")

;;; Create a screen at startup ---------------------------------------

(defmacro elscreen-create-automatically (ad-do-it)
  `(if (not (elscreen-one-screen-p))
       ,ad-do-it
     (elscreen-create)
     (elscreen-notify-screen-modification 'force-immediately)
     (elscreen-message "New screen is automatically created")))

(defadvice elscreen-next (around elscreen-create-automatically activate)
  (elscreen-create-automatically ad-do-it))

(defadvice elscreen-previous (around elscreen-create-automatically activate)
  (elscreen-create-automatically ad-do-it))

(defadvice elscreen-toggle (around elscreen-create-automatically activate)
  (elscreen-create-automatically ad-do-it))
