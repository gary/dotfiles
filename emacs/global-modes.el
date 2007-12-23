;;; global-modes.el --- enables activating minor modes globally.

;; Copyright February 2000 Hans van Dam.

;; Author: Hans van Dam <hans_van_...@hetnet.nl>

;; This file is not part of GNU Emacs.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published
;; by the Free Software Foundation.
;;
;; INSTRUCTION:
;; using this file you can enable any minor mode globally.
;; for instance to enable hs-minor-mode globally execute:
;;
;; (make-minor-mode-global 'hs-minor-mode t '(c-mode emacs-lisp-mode))
;; (global-set-key [f4] 'global-hs-minor-mode)
;;
;; this means hs-minor-mode can be toggled for all buffers with major mode
;; C-mode or Emacs-lisp-mode at once by pressing f4.
;;
;; executing:
;; (make-minor-mode-global 'hs-minor-mode nil '(c-mode emacs-lisp-mode))
;; (global-set-key [f4] 'global-hs-minor-mode)
;;
;; means hs-minor-mode can be toggled for all buffers except those with major mode
;; C-mode or Emacs-lisp-mode at once by pressing f4.
;;
;; if for instance you want to make hs-minor-mode fully global you can execute:
;; (make-minor-mode-global 'hs-minor-mode)
;; (global-set-key [f4] 'global-hs-minor-mode)

(defvar new-buffer-hook nil
  "list of functions to call when a new buffer is created.")

(defvar new-buffers nil
  "list of newly created buffers.")

(mapcar '(lambda (x)
    (eval `(defadvice ,x (around pop activate compile)
      "activate new-buffer-hook."
      (let ((continue nil)
     (buffer (ad-get-arg 0)))
        (setq continue (not (buffer-live-p buffer)))
        ad-do-it
        (if continue
     (progn
       (setq new-buffers (cons ad-return-value new-buffers))
       (run-hooks 'new-buffer-hook)))))))
 (list (function pop-to-buffer) (function other-buffer) (function
get-buffer-create)))

(defadvice switch-to-buffer (around pop (&rest c) activate compile)
  "activate new-buffer-hook."
  (interactive "BSwitch-to-buffer: ")
  (let ((continue nil)
 (buffer (car c)))
    (setq continue (not (buffer-live-p buffer)))
    (eval `(ad-Orig-switch-to-buffer ,@c))
    (if continue
 (progn
   (setq new-buffers (cons ad-return-value new-buffers))
   (run-hooks 'new-buffer-hook)))))

(defvar global-modes nil
  "Alist of minor modes that are activated for each buffer.
the values of the entries are t or nil
if the value is t then that minor-mode is activated for all buffers who have
their major mode
in the major mode list 'minor-mode'-major-mode-list.
if the value is nil than that minor-mode is activated for all buffers except
those who have
their major mode in the major mode list")

(defun make-minor-mode-global (mode &optional include major-mode-list)
  "makes a minor mode global (activates it for each buffer).
creates a function global-'mode' to toggle the global activity of the minor
mode 'mode'.
if 'include' is t then the minor mode is only activated if a buffer has its
major mode
in major-mode-list.  If 'include' is nil than the minor mode is activated
except when a buffer has its major mode in 'mode'-major-mode-list (a
variable that's also created by this function)"
  (interactive "aminor mode name: ")
  (let* ((mode-name (symbol-name mode))
  (major-mode-list-name (concat mode-name "-major-mode-list"))
  (major-mode-list-symbol (intern major-mode-list-name)))
    (eval `(defvar ,major-mode-list-symbol nil
      ,(concat "major-mode-list for global-" mode-name ".
buffers with their major mode in " major-mode-list-name " are included or
excluded
from global minor mode toggling, depending on how make-minor-mode-global
was called for " mode-name)))
    (eval `(setq ,major-mode-list-symbol ',major-mode-list))
    (fset (intern (concat "global-" mode-name))
   `(lambda (&optional arg)
      ,(concat "toggles global-" mode-name ". if arg has a positive value
global-" mode-name " is enabled, if arg is zero or less global-" mode-name
" is disabled")
      (interactive "P")
      (let ((already-global (assoc-prev-entry ',mode global-modes))
     (activate-global nil))
        (setq activate-global (if (null arg)
      (not already-global)
           (> (prefix-numeric-value arg) 0)))
        (if activate-global
     ;;if the minor mode should be globally active*
     (if (not already-global)
         ;;*and is not activated yet:
         (progn
    ;;Mark all existing buffers as new buffers
    (setq global-modes (cons '(,mode . ,include) global-modes))
    (setq new-buffers (append new-buffers (buffer-list)))
    ;;and process them:
    (process-new-buffers)))
   ;;if the minor mode should NOT be globally active+
   (if already-global
       ;;+but is active now-:
       (progn
         (if (consp already-global)
      ;;-and minor mode is NOT the first element of 'global-modes'
      (setcdr already-global (cdr (cdr already-global)))
    ;;-and minor mode IS the first element of 'global-modes'
    (setq global-modes (cdr global-modes)))
         ;;deactivate all buffers that have 'mode' set to t
         (let ((buffer-list-copy (buffer-list)))
    (while buffer-list-copy
      (save-excursion
        (set-buffer (car buffer-list-copy))
        (if (and (symbolp ',mode) (symbol-value ',mode)) (,mode -1)))
      (setq buffer-list-copy (cdr buffer-list-copy))))))))))
    (byte-compile (intern (concat "global-" mode-name)))
    ))

(defun assoc-prev-entry (key alist)
  "returns an entry to the element proceeding the cons-cell identified by
key.
this entry can be used to remove an element from an association-list.
if the return-value is nil this means alist has no key 'key'.  If the
return-value
is -1 this means 'key' identifies the first element of alist."
  (let (element
 (prev-cdr nil))
    (while (and alist (not element))
      (if (equal key (car (car alist)))
   (setq element (car alist)))
      (setq alist (cdr alist) prev-cdr (cdr alist)))
    (if element
 -1
      prev-cdr)))

(defun process-new-buffers ()
  "apply global minor modes to new buffers"
  (interactive)
  (if new-buffers   ;if any new buffer is created by the last command cycle
      (save-excursion
 (while new-buffers  ;for each newly created buffer do
   (if (and (buffer-live-p (car new-buffers))
     (or (< (length (buffer-name (car new-buffers))) 9)
         (not (string= (substring (buffer-name (car new-buffers)) 0 9) "
*Minibuf"))))
       ;;if the new buffer is still exists, and is not the mini buffer
       (progn
  (set-buffer (car new-buffers)) ;make the new buffer current
  (let ((local-global-modes global-modes))
    (while local-global-modes ;check each global minor mode for the new
buffer
      ;; is the major mode of the new buffer in 'mode'-major-mode-list:
      (let ((is-member
      ;; is-member = is the major mode of the new buffer a member of
      (memq (intern (downcase (symbol-name (cdr (assoc 'major-mode
(buffer-local-variables (car new-buffers)))))))
     ;; 'mode'-major-mode-list
     (symbol-value (intern (downcase (concat (symbol-name (car (car
local-global-modes)))
          "-major-mode-list")))))))
        (setq include (cdr (car local-global-modes)))
        (if (or (and include is-member) (not (or include is-member)));;exor
     (funcall (car (car local-global-modes)) 1)))
      (setq local-global-modes (cdr local-global-modes))))))
   (setq new-buffers (cdr new-buffers)))))
  (remove-hook 'post-command-hook 'process-new-buffers))

(add-hook 'new-buffer-hook '(lambda ()
         (add-hook 'post-command-hook 'process-new-buffers)))
(provide 'global-modes)

;; global-modes.el ends here