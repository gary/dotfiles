;;; ==================================================================
;;; Author:  Gary Iams
;;; File:    ini-clojure
;;; Purpose: Setups for Clojure Mode
;;; ==================================================================

;;; Clojure Setup ====================================================

(attach-package "/clojure-mode")

(setq inferior-lisp-program
      (let* ((java-path "java")         ; Path to java implementation
             (java-options "")          ; Extra command-line options to java
             (clojure-path "~/src/clojure/") ; Base directory to Clojure.
             (class-path-delimiter ";") ; The character between
                                        ; elements of your classpath.
             (class-path (mapconcat (lambda (s) s)
                                        ; Add other paths to this list
                                        ; if you want to have other
                                        ; things in your classpath.
                                    (list (concat clojure-path "clojure.jar"))
                                    class-path-delimiter)))
        (concat java-path
                " " java-options
                " -cp " class-path
                " clojure.lang.Repl")))
