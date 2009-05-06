;;; ==================================================================
;;; Author:  Jim Weirich
;;; File:    ini-ruby
;;; Purpose: Setups for Ruby Mode
;;; ==================================================================

;;; Ruby Mode Setups ===============================================

;;; We might need this function --------------------------------------

(or (fboundp 'char-before)
    (defun char-before (pos)
      (char-after (1- (point)))))

;;; Customize Ruby Mode Variables ------------------------------------

(setq ruby-deep-arglist nil)            ; shallow arglist indentation

;;; XMP setup --------------------------------------------------------

(defun ruby-xmp-region (reg-start reg-end)
 (interactive "r")
 (shell-command-on-region reg-start reg-end
   "ruby -r xmp -n -e 'xmp($_, \"%l\t\t# %r\n\")'"
   t))

;;; TestUnit Compilation Patterns ------------------------------------
;;; Add the compilation patterns used by Test::Unit to the list of
;;; those recognized by emacs.

;(setq compilation-error-regexp-alist
;      (cons
;       '("^    \\([^:]+\\):\\([0-9]+\\):in" 1 2)
;       compilation-error-regexp-alist))

(setq compilation-error-regexp-alist
      (cons
       '("^\\(Failure\\|Error\\) occurred in .*\\[\\([^:]+\\):\\([0-9]+\\)\\]" 2 3)
       compilation-error-regexp-alist))


;;; Better Comment Paragraph Filling ---------------------------------

(defvar jw-rb-para-begin-re "\\(^\\s-*#*\\s-*$\\)\\|\\(^\\s-*[^# ]\\)")

(defun jw-rb-goto-para-begin ()
  (search-backward-regexp jw-rb-para-begin-re)
  (beginning-of-line)
  (next-line 1) )

(defun jw-rb-goto-para-end ()
  (search-forward-regexp jw-rb-para-begin-re)
  (beginning-of-line) )

(defun jw-rb-fill-comment-region ()
  (interactive)
  (save-excursion
    (jw-rb-goto-para-begin)
    (let ((start (point)))
      (jw-rb-goto-para-end)
      (narrow-to-region start (point))
      (fill-region start (point))
      (widen)
      )
    ))
(defun jw-rb-fill-comment-region ()
  (interactive)
  (save-excursion
    (jw-rb-goto-para-begin)
    (let ((start (point)))
      (jw-rb-goto-para-end)
      (narrow-to-region start (point))
      (fill-region start (point))
      (widen)
      )
    ))

(defun rb () (interactive) (ruby-mode))

;;; Setup for RDebug -------------------------------------------------

(defun jw-starts-with (prefix string)
  "Does STRING begin with PREFIX?"
  (cond ((< (length string) (length prefix)) nil)
        ((string-equal prefix (substring string 0 (length prefix))) t)
        (t nil) ))

(defun jw-find-gud-buffer1 (bufs)
  (cond ((null bufs)())
        ((jw-starts-with "*gud-"(buffer-name (car bufs)))
         (car bufs))
        (t (jw-find-gud-buffer1 (cdr bufs))) ))

(defun jw-find-gud-buffer ()
  "Find the GUD interaction buffer, nil if not found."
  (jw-find-gud-buffer1 (buffer-list)) )

(defun jw-select-gud-buffer ()
  "Select the GUD interaction buffer."
  (interactive)
  (let ((gud-buffer (jw-find-gud-buffer)))
    (if (null gud-buffer)
        (message "No gud buffer found.")
      (pop-to-buffer gud-buffer)
      (goto-char (point-max)) )))

(defun jw-mark-for-rdebug (n)
  (interactive "P")
  (cond ((null n) (bookmark-set "rdebug"))
        (t (bookmark-jump "rdebug")) ))

(defun rdebug-rails ()
  (interactive)
  (rdebug "rdebug script/server")
  (insert "e Dir.chdir('..')") )

(defun rd () (interactive) (rdebug))
(defun rdr () (interactive) (rdebug-rails))

;;; YASnippets -------------------------------------------------------

(load-library (concat snippet-contrib-directory "/yasnippets-rspec/setup.el"))

;;; Syntax Checking --------------------------------------------------

(eval-after-load 'ruby-mode
  '(progn
     (require 'flymake)

     ;; Invoke ruby with '-c' to get syntax checking
     (defun flymake-ruby-init ()
       (let* ((temp-file (flymake-init-create-temp-buffer-copy
                          'flymake-create-temp-inplace))
              (local-file (file-relative-name
                           temp-file
                           (file-name-directory buffer-file-name))))
         (list "ruby" (list "-c" local-file))))

     (push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
     (push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)

     (push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3)
           flymake-err-line-patterns)

     (add-hook 'ruby-mode-hook
               (lambda ()
                 (when (and buffer-file-name
                            (file-writable-p
                             (file-name-directory buffer-file-name))
                            (file-writable-p buffer-file-name))
                   (local-set-key (kbd "C-c e")
                                  'flymake-display-err-menu-for-current-line)
                   (flymake-mode t))))))

;;; Auto loads -------------------------------------------------------

(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")

(add-hook 'ruby-mode-hook 'jw-ruby-init-keys)
(add-hook 'ruby-mode-hook '(lambda () (jwfd) (font-lock-mode)))
(add-hook 'ruby-mode-hook 'font-lock-fontify-buffer)
(add-hook 'ruby-mode-hook '(lambda () (inf-ruby-keys) ))
(add-hook 'ruby-mode-hook '(lambda () (setq zoom-step 2) ))
(add-hook 'ruby-mode-hook '(lambda () (load-library "rubydb3x")))

;;; Key bindings -----------------------------------------------------

(defun jw-ruby-init-keys ()
  (define-key ruby-mode-map "\M-q"   'jw-rb-fill-comment-region)
  (define-key ruby-mode-map "\C-C\C-t" 'jw-toggle-buffer)
  (define-key ruby-mode-map "\C-cm" 'jw-mark-for-rdebug)
  (define-key ruby-mode-map [(meta f10)] 'ruby-xmp-region)
  (define-key ruby-mode-map [f1] 'ri))
