;; ruby and friends
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process" t)
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(autoload 'rdebug "rdebug" t
  "Run rdebug on program FILE in buffer *gud-FILE*.
The directory containing FILE becomes the initial working directory
and source-file directory for your debugger.")

(defun ruby-eval-buffer ()
  (interactive)
  "Evaluate the buffer with ruby."
  (shell-command-on-region (point-min) (point-max) "ruby"))

(require 'ruby-electric)
(require 'rcodetools)
;; (require 'icicles-rcodetools) TODO: icicles.el (http://www.emacswiki.org/cgi-bin/wiki/Icicles)
(add-hook 'ruby-mode-hook
          '(lambda ()
             (ruby-electric-mode t)
             (inf-ruby-keys)
             (define-key ruby-mode-map (kbd "C-c C-a") 'ruby-eval-buffer)
             (if (eq emacs-major-version 22)
                 (progn
                   (make-local-variable 'write-contents-functions)
                   (add-hook 'write-contents-functions '(lambda ()
                                                          (untabify-buffer)
                                                          (delete-trailing-whitespace))))
               (make-local-variable 'write-contents-hooks)
               (add-hook'write-contents-hooks 'untabify-buffer))))

(add-hook 'ruby-inferior-mode-hook
          '(lambda ()
             (ruby-electric-mode t)))

(setq ri-ruby-script (concat emacs-root "/modes/ri-emacs.rb"))
(autoload 'ri "ri-ruby" "Ruby api reference" t)

;; (smart-snippet-with-abbrev-table 'ruby-mode-abbrev-table
;;   ('if' 'if $${condition} $.' '(not in-comment?))
;;   ('if' 'if $${condition}\n$>$.\nend$>\n' 'bol?))