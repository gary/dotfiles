;;; ==================================================================
;;; Author:  Jim Weirich (modifications by gary iams)
;;; File:    ini-comint
;;; Purpose: Setups for common shell interpreters
;;; ==================================================================

;;; Setups for Comint ================================================

(require 'comint)
(require 'shell)
(require 'shell-command)

;;; ANSI colors ------------------------------------------------------

(autoload 'ansi-color-for-comint-mode-on "ansi-color"
  "Set `ansi-color-for-comint-mode' to t." t)
(setq ansi-color-names-vector
      ["black" "red1" "green3" "yellow3" "DodgerBlue1" "magenta1" "cyan3" "white"])

;;; Tab Completion for shell-command ---------------------------------

(shell-command-completion-mode)

;;; Customized Comint Mode Variables ---------------------------------

(setq comint-input-ring-size 100)
(setq comint-password-prompt-regexp
  "\\(^[Pp]assword\\|^enter password\\|pass phrase\\|[Pp]assword for '[a-zA-Z0-9]+'\\):\\s *\\'")
(setq comint-process-echoes nil)

;; Fix Telnet to honor the output-filter filter stuff ----------------

(defun jnw-fix-telnet-output-filter ()
  (defun telnet-filter (proc string) (jnw-telnet-filter proc string)))

;; jnw-telnet-filter is just like the standard version except that
;; the output filter functions are run at the end.

(defun jnw-telnet-filter (proc string)
  (save-excursion
    (set-buffer (process-buffer proc))
    (let* ((last-insertion (marker-position (process-mark proc)))
           (delta (- (point) last-insertion))
           (ie (and comint-last-input-end
                    (marker-position comint-last-input-end)))
           (w (get-buffer-window (current-buffer)))
           (ws (and w (window-start w))))
      (goto-char last-insertion)
      (insert-before-markers string)
      (set-marker (process-mark proc) (point))
      (if ws (set-window-start w ws t))
      (if ie (set-marker comint-last-input-end ie))
      (while (progn (skip-chars-backward "^\C-m" last-insertion)
                    (> (point) last-insertion))
        (delete-region (1- (point)) (point)))
      (goto-char (process-mark proc))
      (and telnet-replace-c-g
           (subst-char-in-region last-insertion (point) ?\C-g
                                 telnet-replace-c-g t))
      ;; If point is after the insertion place, move it
      ;; along with the text.
      (if (> delta 0)
          (goto-char (+ (process-mark proc) delta)))
      (let ((functions comint-output-filter-functions))
        (while functions
          (funcall (car functions) string)
          (setq functions (cdr functions)))) )))

(defun jnw-add-invisible-telnethookcode ()
  (define-key telnet-mode-map "\C-c\C-i" 'send-invisible) )
(add-hook 'telnet-mode-hook 'jnw-add-invisible-telnethookcode)
(add-hook 'telnet-mode-hook 'jnw-fix-telnet-output-filter)

(defun jnw-set-shell-prompt-hookcode ()
  (setq comint-prompt-regexp "^[^#$%>- \n]*[#$%>-] *")
  (setq telnet-prompt-pattern comint-prompt-regexp))

;;; Autoloads --------------------------------------------------------

(add-hook 'telnet-mode-hook 'jnw-set-shell-prompt-hookcode)
(add-hook 'shell-mode-hook '(lambda () (setq tab-width 8)))
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on) ; ?

;;; Key bindings -----------------------------------------------------
(define-key shell-mode-map "\C-c\C-i" 'send-invisible)
(define-key shell-mode-map "\C-cs" ; Key sequence to toggle the process echo flag.
                (lambda ()
                  (interactive)
                  (cond
                   (comint-process-echoes
                    (setq comint-process-echoes nil)
                    (message "shell not processing echoes"))
                   (t
                    (setq comint-process-echoes t)
                    (message "shell processing echoes")) )))
