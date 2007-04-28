;; ruby and friends
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process" t)
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")

(if (not (boundp 'carbon-emacs-package-version))
    (add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode)))
(add-to-list 'auto-mode-alist '("\\.rhtml\\'" . html-mode))

(defun ruby-eval-buffer ()
  (interactive)
  "Evaluate the buffer with ruby."
  (shell-command-on-region (point-min) (point-max) "ruby"))

(require 'ruby-electric)
(add-hook 'ruby-mode-hook
          '(lambda ()
             (inf-ruby-keys)
             (define-key ruby-mode-map "\C-c\C-a" 'ruby-eval-buffer)
             ;; (pabbrev-mode t) doh
             (ruby-electric-mode t))
             (if (eq emacs-major-version 22)
                 (progn
                   (make-local-variable 'write-contents-functions)
                   (add-hook 'write-contents-functions '(lambda ()
                                                          (untabify-buffer)
                                                          (delete-trailing-whitespace))))
               (make-local-variable 'write-contents-hooks)
               (add-hook'write-contents-hooks 'untabify-buffer)))

(add-hook 'ruby-inferior-mode-hook
          '(lambda ()
             (ruby-electric-mode t)))

(setq ri-ruby-script (concat emacs-root "/modes/ri-emacs.rb"))
(autoload 'ri "ri-ruby" "Ruby api reference" t)