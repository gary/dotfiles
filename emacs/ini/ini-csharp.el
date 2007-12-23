;; Import C# mode
(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)

;; C/C++/Java/C# Mode
(defun my-c-mode-common-hook ()
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'statement-cont 4)
  (c-set-offset 'topmost-intro-cont 0)
  (c-set-offset 'block-open 0)
  (c-set-offset 'arglist-intro 4)
  (c-set-offset 'arglist-cont-nonempty 4))

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(defun my-csharp-mode-hook ()
  (progn
   (turn-on-font-lock)
   (auto-fill-mode)
   (setq tab-width 4)
   (define-key csharp-mode-map "\t" 'c-tab-indent-or-complete)))
(add-hook 'csharp-mode-hook 'my-csharp-mode-hook)