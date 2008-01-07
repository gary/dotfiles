;;; ==================================================================
;;; Author:  gary iams
;;; File:    ini-jde
;;; Purpose: Setups for the JDEE
;;; ==================================================================

(attach-package "/jde")
(add-to-load-path (concat package-directory "/jde/lisp"))
(require 'jde)

;;; Location Specific ------------------------------------------------

(if (eq jw-site 'miami)
    (load-library "muoh-classpath"))

;;; Customized JDE Mode Variables ------------------------------------

(setq jde-gen-k&r t)
(setq jde-electric-return-p t)
(setq jde-enable-abbrev-mode t)

(setq jde-jdk-registry (quote (("1.5.0" . "/System/Library/Frameworks/JavaVM.framework/Versions/1.5.0")
                               ("1.4.2" . "/System/Library/Frameworks/JavaVM.framework/Versions/1.4.2")
                               ("1.3.1" . "/System/Library/Frameworks/JavaVM.framework/Versions/1.3.1"))))
(setq jde-jdk nil)
(setq jde-jdk-doc-url "http://java.sun.com/j2se/1.5.0/docs/api")

(setq jde-help-docsets (quote (("User (javadoc)" "http://java.sun.com/j2se/1.5.0/docs/api/" nil)
                               ("User (javadoc)" "http://java.sun.com/javaee/5/docs/api/" nil)
                               ("User (javadoc)" "http://library.blackboard.com/docs/r6/6_1/sdk/b2api/" nil)
                               ("User (javadoc)" "file://Users/giams/doc/bbas/bbas_r7_2_building_blocks_api_spec/api-documentation/" nil))))

(setq jde-compiler (quote ("javac" "")))
(setq jde-complete-function (quote jde-complete-minibuf))

(setq bsh-jar (concat package-directory "/jde/java/lib/bsh.jar"))

;;; Better Completion ------------------------------------------------

(defun indent-or-complete-jde ()
  "Complete if point is at end of a line, otherwise indent line."
  (interactive)
  (if (looking-at "$")
      (jde-complete)
    (indent-for-tab-command)))

;;; Setup for ant ----------------------------------------------------

(setq jde-ant-home "/usr/bin")
(setq jde-ant-program "ant")
(setq jde-ant-read-target t)
(setq jde-ant-complete-target t)
(setq jde-ant-enable-find t)          ; recurse up to find buildfile

;;; Auto Loads -------------------------------------------------------

;; ?
;; (setq shell-file-name "bash")
;; (setq shell-command-switch "-c")
;; (setq explicit-shell-file-name shell-file-name)
;; (setenv "SHELL" shell-file-name)
;; (setq explicit-sh-args '("-login" "-i"))

;; TODO: whitespace handling
;; (add-hook 'jde-mode-hook
;;           '(lambda ()
;;              (setq tab-width 4)
;;              (setq indent-tabs-mode t)
;;              (if (eq emacs-major-version 22)
;;                  (progn
;;                    (make-local-variable 'write-contents-functions)
;;                    (add-hook 'write-contents-functions (tabify-buffer)))
;;                (make-local-variable 'write-contents-hooks)
;;                (add-hook'write-contents-hooks 'untabify-buffer))))

(defun gi-jde-init-keys ()
  (define-key jde-mode-map [tab] 'indent-or-complete-jde))

(defun gi-jde-defaults ()
  (c-subword-mode)
  (c-toggle-hungry-state))

(add-hook 'jde-run-mode-hook 'gi-jde-defaults)
