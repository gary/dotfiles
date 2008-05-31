;;; ==================================================================
;;; Author:  gary iams
;;; File:    ini-ecb
;;; Purpose: Setups for the Emacs Code Browser
;;; ==================================================================

;;; Setups for ECB ===================================================

(attach-package "/ecb")
(add-to-load-path (concat package-directory "/ecb"))

(ecb-activate)

;;; Customized ECB Variables -----------------------------------------

(setq ecb-tip-of-the-day nil)
(setq ecb-wget-setup 'cons)
(setq ecb-auto-compatibility-check nil)

(setq ecb-compile-window-height 6)
(ecb-toggle-compile-window)

(setq ecb-layout-name "left1")
(ecb-toggle-ecb-windows)

;;; Additional Compilation Patterns ----------------------------------

(add-to-list 'ecb-compilation-buffer-names (cons "*msg*"  nil))
(add-to-list 'ecb-compilation-buffer-names (cons "*ruby*"  nil))
(add-to-list 'ecb-compilation-buffer-names (cons "*autotest*"  nil))
(add-to-list 'ecb-compilation-buffer-names (cons "*git-branch*"  nil))
(add-to-list 'ecb-compilation-buffer-names (cons "*svn-info*"  nil))
(add-to-list 'ecb-compilation-buffer-names (cons "*svn-process*"  nil))

;;; Source Path ------------------------------------------------------

(setq ecb-source-path ())
(add-to-list 'ecb-source-path (list "/usr/local/src" "src"))
(add-to-list 'ecb-source-path (list "/Users/gary/src" "~src"))
(add-to-list 'ecb-source-path (list "/Users/gary/work" "work"))

(if (on-osx)
    (progn
      (add-to-list 'ecb-source-path (list "/usr/local/src/ruby" "ruby"))
      (add-to-list 'ecb-source-path (list "/Library/Ruby/Gems/1.8/gems/" "rubygems"))
      (add-to-list 'ecb-source-path (list "/Library/Ruby/Gems/1.8/gems/rails-2.0.2" "rails-2.0.2"))
      (add-to-list 'ecb-source-path (list "/Applications/Emacs.app/Contents/Resources" "carbon-emacs"))
      (add-to-list 'ecb-source-path (list "/Applications" "osx-apps"))))

