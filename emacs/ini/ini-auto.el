;;; ==================================================================
;;; Author:  Jim Weirich
;;; File:    ini-auto
;;; Purpose: Define the Autoload functions and the auto-mode list
;;; ==================================================================

(setq default-major-mode 'indented-text-mode)

(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
(autoload 'html-mode        "html-mode"        "HTML major mode." t)
(autoload 'tcl-mode         "tcl-mode"         "Major Mode for TCL" t)
(autoload 'eiffel-mode      "eiffel-mode"      "Mode for Eiffel programs" t)
(autoload 'python-mode      "python-mode"      "Automatic Mode for Python Code" t)
(autoload 'ruby-mode        "ruby-mode"        "Automatic Mode for Ruby Code" t)
(autoload 'lua-mode         "lua-mode"         "Automatic Mode for Lua Code" t)
(autoload 'filladapt-mode   "filladapt"        "Adaptive Filling Minor mode" t)

(make-auto "\\.awk$"     'awk-mode)
(make-auto "\\.html$"    'html-helper-mode) ; was html-mode
(make-auto "\\.htm$"     'html-helper-mode)
(make-auto "\\.e$"       'eiffel-mode)
(make-auto "\\.tcl$"     'tcl-mode)
(make-auto "\\.4th$"     'forth-mode)
(make-auto "\\.f83$"     'forth-mode)
(make-auto "\\.cpp$"     'c++-mode)
(make-auto "\\.cxx$"     'c++-mode)
(make-auto "\\.h$"       'c++-mode)
(make-auto "\\.hxx$"     'c++-mode)
(make-auto "\\.C$"       'c++-mode)
(make-auto "\\.hxx$"     'c++-mode)
(make-auto "\\.H$"       'c++-mode)
(make-auto "\\.cs$"      'csharp-mode)
(make-auto "\\.py$"      'python-mode)
(make-auto "\\.pl$"      'cperl-mode)      ; was perl-mode
(make-auto "\\.ph$"      'cperl-mode)
(make-auto "\\.pm$"      'cperl-mode)
(make-auto "\\.java$"    'jde-mode)        ; was java-mode
(make-auto "\\.jav$"     'jde-mode)
(make-auto "\\.jsp$"     'html-mode)
(make-auto "\\.rb$"      'ruby-mode)
(make-auto "\\.rbw$"     'ruby-mode)
(make-auto "\\.rake$"    'ruby-mode)
(make-auto "^Rakefile$"  'ruby-mode)
(make-auto "\\.lua$"     'lua-mode)

;;;(make-auto "\\.h$"   'c++-c-mode)
;;;(make-auto "\\.c$"   'c++-c-mode)

;;; NOTE: .h files to be editted in C++ mode should include a
;;;            // -*-Mode: c++; -*-
;;;        as the first line


