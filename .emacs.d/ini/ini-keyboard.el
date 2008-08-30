;;; ==================================================================
;;; Author:  gary iams
;;; File:    ini-keyboard
;;; Purpose: Setups for keyboard behavior
;;; ==================================================================

;;; Setups for Keyboard Behavior =====================================

;;; Special character toggling ---------------------------------------

(defvar *unshifted-special-chars-layout*
  '(("1" "!") ; from -> to
    ("2" "@")
    ("3" "#")
    ("4" "$")
    ("5" "%")
    ("6" "^")
    ("7" "&")
    ("8" "*")
    ("9" "(")
    ("0" ")")
    ("!" "1")
    ("@" "2")
    ("#" "3")
    ("$" "4")
    ("%" "5")
    ("^" "6")
    ("&" "7")
    ("*" "8")
    ("(" "9")
    (")" "0")))

(defun mb-str-to-unibyte-char (s)
  "Translate first multibyte char in s to internal unibyte representation."
  (multibyte-char-to-unibyte (string-to-char s)))

(defun remap-keyboard (mapping)
  "Setup keyboard translate table using a list of pairwise key-mappings."
  (mapcar
   (lambda (mb-string-pair)
     (apply #'keyboard-translate
            (mapcar #'mb-str-to-unibyte-char mb-string-pair)))
   mapping))

;; (remap-keyboard *unshifted-special-chars-layout*)

;;; Backspace Rebinding ----------------------------------------------

;; The following swaps the functions of the delete and backspace keys

(defun fix-backspace ()
  (interactive)
    (let ((the-table (make-string 128 0)))
      (let ((i 0))
        (while (< i 128)
          (aset the-table i i)
          (setq i (1+ i))))
      ;; Swap ^H and DEL
      (aset the-table ?\177 ?\^h)
      (aset the-table ?\^h ?\177)
      (setq keyboard-translate-table the-table)) )

(if (and (not (is-emacs-19))
         (not (is-xemacs))
         (not (is-emacs-21))
         (not (is-emacs-22)))
    (fix-backspace))

(defun toggle-bs-mode ()
  (interactive)
  (if keyboard-translate-table
      (progn (setq keyboard-translate-table nil)
            (message "Normal Key Translation"))
    (fix-backspace)
    (message "C-h / DEL Swapped") ))

(global-set-key "\C-x4h" 'toggle-bs-mode)

;;; Insert braces, commas, et al in pairs ----------------------------

(setq skeleton-pair t)

(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "'") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)

(global-set-key "\C-cd" 'delete-pair)
