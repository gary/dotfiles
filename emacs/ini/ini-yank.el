;;; ==================================================================
;;; Author:  gary iams
;;; File:    ini-keyboard
;;; Purpose: Setups for Yank-Pop with Summary
;;; ==================================================================

;;; Setups for custom yank behavior ==================================

;;; Auto indent yanked code if in programming-modes ------------------

(defvar yank-indent-modes '(emacs-lisp-mode
                            lisp-interaction-mode
                            c-mode c++-mode
                            perl-mode cperl-mode
                            java-mode jde-mode
                            ruby-mode
                            tcl-mode sql-mode
                            LaTeX-mode TeX-mode)
  "Modes in which to indent regions that are yanked (or yank-popped)")

(defvar yank-advised-indent-threshold 1000
  "Threshold (# chars) over which indentation does not automatically
occur.")

(defun yank-advised-indent-function (beg end)
  "Do indentation, as long as the region isn't too large."
  (if (<= (- end beg) yank-advised-indent-threshold)
      (indent-region beg end nil)))

(defadvice yank (after yank-indent activate)
  "If current mode is one of 'yank-indent-modes, indent yanked text (with
prefix arg don't indent)."
  (if (and (not (ad-get-arg 0))
           (member major-mode yank-indent-modes))
      (let ((transient-mark-mode nil))
    (yank-advised-indent-function (region-beginning) (region-end)))))

(defadvice yank-pop (after yank-pop-indent activate)
  "If current mode is one of 'yank-indent-modes, indent yanked text (with
prefix arg don't indent)."
  (if (and (not (ad-get-arg 0))
           (member major-mode yank-indent-modes))
    (let ((transient-mark-mode nil))
    (yank-advised-indent-function (region-beginning) (region-end)))))

;;; Visualize the kill ring ------------------------------------------

(global-set-key "\M-y" 'yank-pop-forward)
(global-set-key "\C-\M-y" 'yank-pop-backward)