;;; ==================================================================
;;; Author:  Jim Weirich (modifications by gary iams)
;;; File:    ini-auto
;;; Purpose: Define the Autoload functions and the auto-mode list
;;; ==================================================================

(setq default-major-mode 'indented-text-mode)

;;; Mode-specific autoloads ------------------------------------------

(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
(autoload 'html-mode        "html-mode"        "HTML major mode." t)
(autoload 'tcl-mode         "tcl-mode"         "Major Mode for TCL" t)
(autoload 'eiffel-mode      "eiffel-mode"      "Mode for Eiffel programs" t)
(autoload 'python-mode      "python-mode"      "Automatic Mode for Python Code" t)
(autoload 'ruby-mode        "ruby-mode"        "Automatic Mode for Ruby Code" t)
(autoload 'lua-mode         "lua-mode"         "Automatic Mode for Lua Code" t)
(autoload 'filladapt-mode   "filladapt"        "Adaptive Filling Minor mode" t)
(autoload 'applescript-mode "applescript-mode" "Major Mode for editing AppleScript source." t)
(autoload 'markdown-mode    "markdown-mode"    "Major mode for editing Markdown files" t)
(autoload 'haml-mode        "haml-mode"        "Major mode for editing HAML files" t)
(autoload 'jde-mode         "jde"              "A Java Development Environment for Emacs." t)
(autoload 'js2-mode         "js2"              "an improved JavaScript editing mode" t)

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
(make-auto "\\.js$"      'js2-mode)
(make-auto "\\.jav$"     'jde-mode)
(make-auto "\\.jsp$"     'html-mode)
(make-auto "\\.rb$"      'ruby-mode)
(make-auto "\\.rbw$"     'ruby-mode)
(make-auto "\\.rake$"    'ruby-mode)
(make-auto "^Rakefile$"  'ruby-mode)
(make-auto "\\.rjs$"     'ruby-mode)
(make-auto "\\.thor$"    'ruby-mode)
(make-auto "\\.lua$"     'lua-mode)
(make-auto "\\.applescript$" 'applescript-mode)
(make-auto "\\.scpt$"    'applescript-mode)
(make-auto "\\.mdml$"    'markdown-mode)
(make-auto "\\.erb$"     'rhtml-mode)
(make-auto "\\.clj$"     'clojure-mode)
;;;(make-auto "\\.h$"   'c++-c-mode)
;;;(make-auto "\\.c$"   'c++-c-mode)

;;; NOTE: .h files to be editted in C++ mode should include a
;;;            // -*-Mode: c++; -*-
;;;        as the first line

;;; Dependency autoloads ---------------------------------------------

(autoload 'ack                          "ack"               "Use ack where you might usually use grep." t)
(autoload 'autotest                     "autotest"          "ZenTest's autotest integration with emacs." t)
(autoload 'cheat                        "cheat"             "A handy interface go cheat.errtheblog.com" t)
(autoload 'clojure-mode                 "clojure-mode"      "A mode for clojure lisp" t)
(autoload 'ecb-activate                 "ecb-autoloads"      "Emacs Code Browser" t)
(autoload 'ffap-bindings                "ffap"              "Find file (or url) at point" t)
(autoload 'install-elisp                "install-elisp"     "Simple Emacs Lisp Installer" t)
(autoload 'install-elisp-from-emacswiki "install-elisp"     "Simple Emacs Lisp Installer" t)
(autoload 'magit-status                 "magit"             "It's magit!  A Emacs mode for Git." t)
(autoload 'gist-get                     "gist"              "Emacs integration for gist.github.com" t)
(autoload 'gist-region                  "gist"              "Emacs integration for gist.caboo.se." t)
(autoload 'rcirc-color                  "rcirc-color"       "Color nickname for rcirc" t)
(autoload 'rcirc-completion             "rcirc-completion"  "Completion for rcirc" t)
(autoload 'redo                         "redo"              "Redo" t)
(autoload 'ri                           "ri-ruby.el"        nil t)
(autoload 'shell-command                "shell-command"     "Tab completion for shell-comamnd" t)
(autoload 'svn-status                   "psvn"              "Subversion interface for Emacs" t)
(autoload 'toggle-style                 "toggle"            "quickly open corresponding file (eg test vs impl)." t)
(autoload 'twit-mode                    "twit"              "interface with twitter.com" t)
(autoload 'yank-pop-forward             "yank-pop-summary"  nil t)
(autoload 'yank-pop-backward            "yank-pop-summary"  nil t)
