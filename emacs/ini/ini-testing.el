;;; ==================================================================
;;; Author:  Jim Weirich
;;; File:    ini-testing
;;; Purpose: Quick and easy functions for running TDD tests.
;;; ==================================================================

(require 'compile)
(require 'toggle)

;;; Name of the asynchronous test process.
(defconst jw-test-process-name "*test-process*")

;;; Name of the test process output buffer.
(defconst jw-test-buffer-name "*testing*")

;;; Name of the ruby command to run the tests.
(defconst jw-ruby-command "ruby")

;;; Name of the ruby debugging command to run the tests in debug mode.
(defconst jw-rdebug-command "rdebug")

;;; Name of the rake command ot run the rake based tests.
(defconst jw-rake-command "rake")

;;; Options to be added to the ruby based test commands.
(defconst jw-test-options "-Ilib:.")

;;; If true, display the testing buffer in a single window (rather
;;; than a split window).
(defvar jw-testing-single-window nil)

;;; If true, keep the mode line in the compilation buffer.
(defvar jw-testing-keep-mode-line nil)

;;; Name of the last buffer running a file or method style test.
(defvar jw-testing-last-test-buffer nil)

(set-face-attribute (make-face 'spec-case-pass) nil
                    ;; :family "arial"
;;                     :height 240
                    :background (if window-system "#00CC00" "#001100")
                    :foreground (if window-system "black" "white"))
                    ;; :weight 'bold)

(set-face-attribute (make-face 'spec-case-fail) nil
                    ;; :family "arial"
;;                     :height 240
                    :background (if window-system "#00CC00" "#001100")
                    :foreground (if window-system "black" "white"))
;;                     :weight 'bold)

(set-face-attribute (make-face 'test-heading1) nil
                    :family "arial"
                    :height 240
                    :background "#000000"
                    :foreground "#9999ff"
                    :weight 'bold)

(set-face-attribute (make-face 'test-heading2) nil
                    :family "arial"
                    :height 180
                    :background "#000000"
                    :foreground "#9999ff"
                    :weight 'bold)

(set-face-attribute (make-face 'test-success) nil
                    :family "arial"
                    :height 240
                    :background (if window-system "#33ff33" "#001100")
                    :foreground (if window-system "black" "white")
                    :weight 'bold)

(set-face-attribute (make-face 'test-failure) nil
                    :family "arial"
                    :height 240
                    :background (if window-system "#ff3333" "#110000")
                    :foreground (if window-system "black" "white")
                    :weight 'bold)

(setq compilation-mode-font-lock-keywords ())

(add-to-list 'compilation-mode-font-lock-keywords
             '(".*FAILED.*"
               (1 'spec-case-fail)))

(add-to-list 'compilation-mode-font-lock-keywords
             '("^expect \\([1-9][0-9]*\\) \\sw+, got [^\\1]"
               (1 'spec-case-fail)))

(add-to-list 'compilation-mode-font-lock-keywords
             '("^\\(.* 0 failures.*\n\\)"
               (1 'test-success)))

(add-to-list 'compilation-mode-font-lock-keywords
             '("^\\(.* 0 failures, 0 errors.*\n\\)"
               (1 'test-success)))

(add-to-list 'compilation-mode-font-lock-keywords
             '("^\\(.* [1-9][0-9]* \\(failure\\|error\\)s?.*\n\\)"
               (1 'test-failure)))

(add-to-list 'compilation-mode-font-lock-keywords
             '("^= \\(.*\n\\)"
               (1 'test-heading1)))

(add-to-list 'compilation-mode-font-lock-keywords
             '("^==+ \\(.*\n\\)"
               (1 'test-heading2)))

(defun jw-test-remove-crs ()
  (save-excursion
    (goto-char (point-min))
    (while (search-forward "" nil t)
      (replace-match "") )))

(defun jw-test-compilation-buffer-hook-function ()
  "Remove carriage returns that occasionally pollute the compile buffer."
  (save-current-buffer
    (set-buffer (get-buffer jw-test-buffer-name))
    (let ((buffer-read-only nil))
      (jw-test-remove-crs) )))

(add-hook 'compilation-filter-hook 'jw-test-compilation-buffer-hook-function)

(defun jw-test-start-process (&rest args)
  "Start the test process using the compilation package."
  (compilation-start
   (mapconcat (lambda (x) x) args " ")
   nil
   (lambda (x) "*testing*"))
  )

(defun jw-test-start-debugging (&rest args)
  (rdebug (mapconcat (lambda (x) x) args " ")) )

(defun jw-dir-contains-p (path file)
  "Does the path contain the given file name?"
  (file-readable-p (concat (file-name-as-directory path) file)))

(defun jw-project-top-p (path)
  "Are we at the top of a project?
Redefine as needed to define the top directory of a project."
  (or
   (jw-dir-contains-p path "Rakefile")
   (jw-dir-contains-p path "config/database.yml") ))

(defun jw-parent-dir (path)
  "Return the parent directory of path.  The parent of / is nil."
  (cond ((string-equal "/" path) nil)
        (t (file-name-directory (directory-file-name path))) ))

(defun jw-find-project-top-aid (path full-path)
  "Find the top level directory of the project containing *path*."
  (cond ((null path) full-path)
        ((jw-project-top-p path)
         (file-name-as-directory (directory-file-name path)))
        (t (jw-find-project-top-aid (jw-parent-dir path) full-path)) ))

(defun jw-find-project-top (path)
  (cond ((file-directory-p path)
         (jw-find-project-top-aid path path))
        (t (let ((parent (jw-parent-dir path)))
             (jw-find-project-top-aid parent parent))) ))

(defun jw-prep-test-buffer ()
  "Prepare the test buffer for inserting output from the test process."
  (let ((buf (get-buffer jw-test-buffer-name)))
    (if buf (kill-buffer buf))
    (setq buf (get-buffer-create jw-test-buffer-name))
    (pop-to-buffer buf) ))

(defun jw-test-file-name-p (file-name)
  "Is the given file name a test file?"
  (string-match "\\b\\(test\\|spec\\)\\b" file-name) )

(defun jw-test-file-name (file-name)
  "Return the test file name associated with the given file name."
  (cond ((jw-test-file-name-p file-name) file-name)
        ((toggle-filename file-name toggle-mappings))
        (t file-name) ))

(defun jw-find-test-method-name ()
  "Return the name of the current test method."
  (save-excursion
    (next-line)
    (re-search-backward "^ *def *\\(test_[a-zA-Z0-9_]+\\)")
    (buffer-substring (match-beginning 1) (match-end 1))))

(defun jw-take-down-test-buffer ()
  "If the test buffer is in the front, take it down.
Make an attempt to get back to the last buffer that was used in a
test."
  (if (string-equal jw-test-buffer-name (buffer-name))
      (progn
        (kill-buffer jw-test-buffer-name)
        (if jw-testing-last-test-buffer (pop-to-buffer jw-testing-last-test-buffer)) )))

(defun jw-test-deal-with-mode-line ()
  "Remove the mode line if so configured.
The compilation buffer by default gets a mode line.  Remove it
unless the jw-testing-keep-mode-line variable is true.  Otherwise
just skip past it and insert an extra line in preparation for the
test headers."
    (if (and (looking-at "-*-") (not jw-testing-keep-mode-line))
        (let
            ((bol (save-excursion (beginning-of-line)(point)))
             (eol (save-excursion (end-of-line)(point))))
          (delete-region bol (+ eol 1)))
      (next-line)
      (insert "\n")) )

(defun jw-test-insert-headers (&rest headers)
  "Insert the given strings into the test buffer."
  (save-current-buffer
    (set-buffer (get-buffer "*testing*"))
    (goto-char (point-min))
    (setq buffer-read-only nil)
    (jw-test-deal-with-mode-line)
    (apply 'insert headers)
    (setq buffer-read-only t)
    (goto-char (point-max))
    (if jw-testing-single-window (delete-other-windows)) ))

;;; -- Test Run Commands ---------------------------------------------

(defun jw-run-test-rake ()
  "Run the default rake command as a test."
  (interactive)
  (jw-prep-test-buffer)
  (jw-test-start-process jw-rake-command)
  (jw-test-insert-headers
   "= Test Rake\n"
   "== Target: default\n\n") )

(defun jw-run-test-units ()
  "Run the test:units rake command as a test."
  (interactive)
  (jw-prep-test-buffer)
  (jw-test-start-process jw-rake-command "test:units")
  (jw-test-insert-headers
   "= Test Rake\n"
   "== Target: test:units\n\n") )

(defun jw-run-test-functionals ()
  "Run the test:functionals rake command as a test."
  (interactive)
  (jw-prep-test-buffer)
  (jw-test-start-process jw-rake-command "test:functionals")
  (jw-test-insert-headers
   "= Test Rake\n"
   "== Target: test:functionals\n\n") )

(defun jw-run-test-integration ()
  "Run the test:integration rake command as a test."
  (interactive)
  (jw-prep-test-buffer)
  (jw-test-start-process jw-rake-command "test:integration")
  (jw-test-insert-headers
   "= Test Rake\n"
   "== Target: test:integration\n\n") )

(defun jw-run-test-cruise ()
  "Run the cruise rake command as a test."
  (interactive)
  (jw-prep-test-buffer)
  (jw-test-start-process jw-rake-command "cruise")
  (jw-test-insert-headers
   "= Test Rake\n"
   "== Target: cruise\n\n") )

(defun gi-run-spec ()
  "Run the spec rake command as a test."
  (interactive)
  (jw-prep-test-buffer)
  (jw-test-start-process jw-rake-command "spec")
  (jw-test-insert-headers
   "= Test Rake\n"
   "== Target: spec\n\n"))

(defun gi-run-spec-controllers ()
  "Run the spec:controllers rake command as a test."
  (interactive)
  (jw-prep-test-buffer)
  (jw-test-start-process jw-rake-command "spec:controllers")
  (jw-test-insert-headers
   "= Test Rake\n"
   "== Target: spec:controllers\n\n"))

(defun gi-run-spec:helpers ()
  "Run the spec:helpers rake command as a test."
  (interactive)
  (jw-prep-test-buffer)
  (jw-test-start-process jw-rake-command "spec:helpers")
  (jw-test-insert-headers
   "= Test Rake\n"
   "== Target: spec:helpers\n\n"))

(defun gi-run-spec:lib ()
  "Run the spec:lib rake command as a test."
  (interactive)
  (jw-prep-test-buffer)
  (jw-test-start-process jw-rake-command "spec:lib")
  (jw-test-insert-headers
   "= Test Rake\n"
   "== Target: spec:lib\n\n"))

(defun gi-run-spec-models ()
  "Run the spec:models rake command as a test."
  (interactive)
  (jw-prep-test-buffer)
  (jw-test-start-process jw-rake-command "spec:models")
  (jw-test-insert-headers
   "= Test Rake\n"
   "== Target: spec:models\n\n"))

(defun jw-run-test-file (arg)
  "Run the current file as a test.
If this file name does not include the string 'test' and there is
a toggle mapping for this file, then run the test on the toggled
test file."
  (interactive "P")
  (jw-take-down-test-buffer)
  (if (string-equal jw-test-buffer-name (buffer-name))
      (kill-buffer jw-test-buffer-name))
  (let* ((file-name (jw-test-file-name (buffer-file-name)))
         (default-directory (jw-find-project-top file-name)) )
    (cond ((null default-directory) (message "Cannot find project top"))
          (t
           (save-buffer)
           (setq jw-testing-last-test-buffer (buffer-name))
           (jw-prep-test-buffer)
           (cond ((null arg)
                  (jw-test-start-process
                   jw-ruby-command jw-test-options file-name)
                  (jw-test-insert-headers
                   "= Test File ...\n"
                   "== In:   " default-directory "\n"
                   "== File: " (file-name-nondirectory file-name) "\n\n") )
                 (t (jw-test-start-debugging
                     jw-rdebug-command jw-test-options file-name)) )))))

(defun jw-run-test-method (arg)
  "Run the current file as a test.
If this file name does not include the string 'test' and there is
a toggle mapping for this file, then run the test on the toggled
test file."
  (interactive "P")
  (jw-take-down-test-buffer)
  (let* ((file-name (buffer-file-name))
         (default-directory (jw-find-project-top file-name)) )
    (if (not (jw-test-file-name-p file-name)) 
        (progn
          (jw-toggle-buffer)
          (setq file-name (buffer-file-name)) ))
    (save-buffer)
    (setq jw-testing-last-test-buffer (buffer-name))
    (let ((method-name (jw-find-test-method-name)))
      (cond ((null default-directory) (message "Cannot find project top"))
            ((null arg)
             (jw-prep-test-buffer)
             (jw-test-start-process
              jw-ruby-command jw-test-options
              file-name (concat "-n" method-name))
             (jw-test-insert-headers
              "= Test Method ...\n"
              "== In:     " default-directory "\n"
              "== File:   " (file-name-nondirectory file-name) "\n"
              "== Method: " method-name "\n\n"))
            (t (jw-prep-test-buffer)
               (jw-test-start-debugging
                jw-rdebug-command jw-test-options
                file-name "--" (concat "-n" method-name))) ))))

;;; -- Toggle Enhancements -------------------------------------------

(defvar jw-testing-toggle-style nil
"Buffer local variable describing the buffer's toggle style.")
(make-variable-buffer-local 'jw-testing-toggle-style)

(defun jw-test-load-project-toggle-style ()
  "Set the buffer's toggle style from the project defaults."
  (let* ((project-dir (jw-find-project-top (buffer-file-name)))
         (togglerc (concat project-dir ".togglerc")))
    (if (file-readable-p togglerc)
        (load-file togglerc))
    (if (null jw-testing-toggle-style)
        (setq jw-testing-toggle-style toggle-mapping-style))  ))

(defun jw-test-select-buffer-toggle-style ()
  "Set the buffer's toggle style.
If no style is currently selected, load the style from the
project .togglerc file."
  (if (null jw-testing-toggle-style)
      (jw-test-load-project-toggle-style) )
  (setq toggle-mappings (toggle-style jw-testing-toggle-style)) )

(defun jw-toggle-buffer ()
  "Enhanced version of the Ryan Davis's toggle-buffer function
Check for a .togglerc file at the top level of the project
directory.  If found, the file will be loaded before toggling,
allowing per-project toggle customizations."
  (interactive)
  (jw-test-select-buffer-toggle-style)
  (toggle-buffer) )

(defun jw-toggle-clear-buffer-styles ()
  "Clear all the buffer toggle style settings."
  (interactive)
  (let ((buffers (buffer-list)))
    (while buffers
      (if (local-variable-p 'jw-testing-toggle-style (car buffers))
          (save-current-buffer
            (set-buffer (car buffers))
            (setq jw-testing-toggle-style nil) ))
      (setq buffers (cdr buffers)) )
    (message "All buffer toggle styles are reset") ))

(defun jw-add-or-replace (name pair)
  (let* ((key (car pair))
         (new-value (cdr pair))
         (alist (eval name))
         (old-pair (assoc key alist)))
    (cond ((null old-pair) (add-to-list name pair))
          ((equal (cdr old-pair) new-value) ())
          (t (set name (cons pair (assq-delete-all key alist)))) ))
  (eval name) )

;;; .togglerc specific functions -------------------------------------

;; The following functions are intended to be used in the project
;; specific .togglerc file.
;;
;; Example -- Set the style only:
;;
;;   (buffer-toggle-style 'jw-rails)
;;
;; Example -- Define a mapping and then select it:
;;
;;   (buffer-toggle-mapping 
;;    '(project-style    . (("test/\\1_test.rb" . "lib/\\1.rb")
;;                           ("\\1_test.rb"      . "\\1.rb") )))
;;   (buffer-toggle-style 'project-style)

(defun buffer-toggle-style (style-name)
  "Set the testing toggle style for this buffer.
Normally called in the .togglerc file at the project level."
  (setq jw-testing-toggle-style style-name) )

(defun buffer-toggle-mapping (mapping)
  "Define a project specific mapping.
Note: Make sure the mapping name is unique and doesn't class with
mappings from other projects."
  (jw-add-or-replace 'toggle-mapping-styles mapping))

;;; -- Key mappings --------------------------------------------------

;;; Test::Unit
(global-set-key "\C-Ctr" 'jw-run-test-rake)
(global-set-key "\C-Ctu" 'jw-run-test-units)
(global-set-key "\C-Cto" 'jw-run-test-functionals)
(global-set-key "\C-Cti" 'jw-run-test-integration)

;;; rSpec
(global-set-key "\C-Ctz" 'gi-run-spec)
(global-set-key "\C-Ctc" 'gi-run-spec-controllers)
(global-set-key "\C-Cth" 'gi-run-spec-helpers)
(global-set-key "\C-Ctl" 'gi-run-spec-lib)
(global-set-key "\C-Ctm" 'gi-run-spec-models)

;;; CruiseControlRB
;; (global-set-key "\C-Ctc" 'jw-run-test-cruise)

;;; Generic
(global-set-key "\C-Ctt" 'jw-run-test-file)
(global-set-key "\C-Ctd" 'jw-run-test-method)

(global-set-key "\C-Ct1" (lambda () (interactive)(setq jw-testing-single-window t)))
(global-set-key "\C-Ct2" (lambda () (interactive)(setq jw-testing-single-window nil)))

;;; Map the toggle-style command for easy access
(global-set-key "\C-Cts" 'toggle-style)

;;; Also map the reset all buffer toggle styles command.
(global-set-key "\C-Ct\C-t" 'jw-toggle-clear-buffer-styles)

;;; Add the toggle command to the compilation mode, just make it
;;; delete the test buffer.

(defun jw-test-kill-test-buffer ()
  (interactive)
  (kill-buffer jw-test-buffer-name)
  (if jw-testing-last-test-buffer
      (pop-to-buffer jw-testing-last-test-buffer) ))

(define-key compilation-mode-map "\C-c\C-t" 'jw-test-kill-test-buffer)
