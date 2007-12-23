;;; ==================================================================
;;; Author:  gary iams
;;; File:    ini-csharp
;;; Purpose: Setups for CSharp mode
;;; ==================================================================

;;; auto loads -------------------------------------------------------

(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)

(defun gi-csharp-defaults ()
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'statement-cont 4)
  (c-set-offset 'topmost-intro-cont 0)
  (c-set-offset 'block-open 0)
  (c-set-offset 'arglist-intro 4)
  (c-set-offset 'arglist-cont-nonempty 4))

(defun gi-csharp-init-keys ()
  (define-key csharp-mode-map [tab] 'c-tab-indent-or-complete))

(add-hook 'csharp-mode-hook 'gi-sharp-defaults)
(add-hook 'csharp-mode-hook 'gi-init-keys)
