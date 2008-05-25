;;; ==================================================================
;;; Author:  gary iams
;;; File:    ini-ffap
;;; Purpose: Setups for Finding Files At Point (FFAP)
;;; ==================================================================

;;; Setups for ffap ==================================================

(ffap-bindings) ; autoload

;;; Customize FFAP Mode Variables ------------------------------------

(setq ffap-require-prefix t)

;;; Goto line number if available ------------------------------------

;; (defadvice find-file-at-point (around goto-line compile activate)
;;   (let ((line (and (looking-at ".*:\\([0-9]+\\)")
;;                    (string-to-number (match-string 1)))))
;;     ad-do-it
;;     (and line (goto-line line))))

;;; Find Ruby Files in requires --------------------------------------

(defun ruby-module-path(module)
  (shell-command-to-string 
   (concat 
    "ruby -e " 
    "\"ret='()';$LOAD_PATH.each{|p| " 
    "x=p+'/'+ARGV[0].gsub('.rb', '')+'.rb';" 
    "ret=File.expand_path(x)" 
    "if(File.exist?(x))};printf ret\" " 
    module)))

(push '(ruby-mode . ruby-module-path) ffap-alist)
