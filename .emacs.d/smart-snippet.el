;;; smart-snippet.el --- snippet with conditional expansion

;; Copyright 2007 pluskid
;;
;; Author: pluskid.zju@gmail.com
;; Version: $Id: smart-snippet.el,v 0.0 2007/05/05 23:06:37 kid Exp $
;; Keywords: snippet smart condition
;; X-URL: http://code.google.com/p/smart-snippet/

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

;;; Commentary:

;; Do you feel that the emace abbrev expansion is not smart enough?
;; Expansion to code snippet should not happen in comment. And
;; sometimes the same abbrev have different meaning. e.g. in ruby,
;; <--------------------
;; if
;; -------------------->
;; should expand into
;; <--------------------
;; if cond
;;   
;; end
;; -------------------->
;; but the "if" at the follow statement
;; <--------------------
;; puts "foo" if predicate
;; -------------------->
;; should not expand to anything.
;;
;; So I write this code trying to solve this problem. It require the
;; wonderful snippet.el.

;; Put this file into your load-path and the following into your ~/.emacs:
;;   (require 'smart-snippet)
;; On how to define a conditional snippet, refer to the document of
;; `smart-snippet-abbrev' and `smart-snippet-with-abbrev-table'

;;; Tips:

;; If the indentation is incorrect, e.g: the following snippet for c++
;; will not indent correctly
;;
;; (smart-snippet-with-abbrev-table 'c++-mode-abbrev-table
;;   ("class"
;;    "class $${name}
;; {$>
;; public:$>
;;     $${name}()$>
;;     {$>
;;        $>$.
;;     }$>
;; };$>"
;;    'bol?))
;;
;; when expanded, it will become something like this:
;;
;; class foo
;; {
;; public:
;;     foo()
;;             {
;;                 
;;                     }
;; };
;;
;; This is because indentation is done when there are still
;; "garbage" text like "$" and "{" which can make Emacs confused.
;; The solution is to reassign the identifiers to something
;; else(it is buffer-local, so you can set it to different value
;; in a mode-hook according to different major-mode):
;;  
;;  (add-hook 'c++-mode-hook
;;    (lambda ()
;;      (setq snippet-field-default-beg-char ?\()
;;      (setq snippet-field-default-end-char ?\))
;;      (setq snippet-exit-identifier "$;")))
;;  
;;  (smart-snippet-with-abbrev-table 'c++-mode-abbrev-table
;;    ("class"
;;     "class $$(name)
;;  {$>
;;  public:$>
;;      $$(name)()$>
;;      {$>
;;         $>$;
;;      }$>
;;  };$>"
;;     'bol?))
;;  
;; This will work fine. And you can choose appropriate characters
;; for different major-mode(language).
;; ***NOTE*** I'm modifying `snippet-insert' in snippet.el since
;; there're some bugs in it. The current version already don't need
;; this tricky things any more(but you can still use it).

;;; Implementation Notes:

;; `snippet-insert' from snippet.el is used to insert snippet.  In
;; order to allow multiple meaning of abbrev(i.e. the same abbrev
;; might expand to different thing under different condition), I
;; maintain a list of (condition . template) in a distinct variable
;; for distincting mode(e.g. smart-snippet-ruby-mode-snippets) , those
;; added later will come to the first of the list. When an abbrev is
;; triggered, the list is searched, the first snippet whose condition
;; is satisfied is then expanded. If no snippet is satisfied, expand
;; nothing(just insert a space).

;;; Code:

(provide 'smart-snippet)
(eval-when-compile
  (require 'cl))

(require 'snippet)

(defun smart-snippet-expand
  (abbrev &optional abbrev-table call-directly)
  "Search the snippets related to ABBREV in TABLE(if supplied)
or the major-mode's default smart-snippet table. Expand the first
snippet whose condition is satisfied. Expand to one space if no
snippet's condition can be satisfied."
  (let* ((table (or abbrev-table
		    (smart-snippet-abbrev-table
		     (format "%s-abbrev-table"
			     major-mode))))
	 (snippet-list (gethash abbrev table))
	 ;; since the default abbrev expansion is case
	 ;; sensitive, if I type 'If' in the comment, I
	 ;; should get 'If', not 'if'. Smart-snippet
	 ;; don't know what the user has typed, so just
	 ;; let the default abbrev mechanism to expand
	 ;; and then we get the expansion.
	 (default-expansion
	   (if call-directly
	       abbrev
	     (buffer-substring-no-properties (- (point)
						(length abbrev))
					     (point)))))
    ;; if not from expanding abbrev(i.e. triggered directly
    ;; by binding keys), don't backward delete(since there
    ;; is now default expanded text)
    (unless call-directly
      (backward-delete-char (length abbrev)))
    (if (not snippet-list)		; no abbrev found
	(progn (insert default-expansion)
	       nil)			; permit the self-insert-command
      (while (and snippet-list
		  (not (apply
			'smart-snippet-try-expand
			abbrev
			(car snippet-list))))
	(setq snippet-list (cdr snippet-list)))
      (if (not snippet-list)
	  (progn (insert default-expansion)
		 nil)                   ; let abbrev insert extra space
	t))))

(defun smart-snippet-try-expand (abbrev template condition)
  "Test CONDITION, if it satisfied, expand ABBREV with TEMPLATE
using `snippet-insert'. Returning t to indicate that this expansion
didn't take place, should try the successive one."
  (let ((abbrev-name abbrev)
	(in-comment? (smart-snippet-inside-comment-p))
	(bol? (looking-back "^[[:blank:]]*")))
    (cond ((and (functionp condition) (funcall condition))
	   (snippet-insert template)
	   t)
	  ((and (or (symbolp condition) (listp condition))
		(eval condition))
	   (snippet-insert template)
	   t)
	  (t nil))))

;; code from http://www.mathcs.emory.edu/~mic/ftp/emacs/lisp-mic.el
(defun smart-snippet-inside-comment-p (&optional on)
  "Is the point inside a comment?
Optional ON means to also count being on a comment start."
  ;; Note: this only handles single-character commenting, as in lisp.
  (or (and on (looking-at "\\s<"))
      (save-excursion
	(skip-syntax-backward "^><")
	(and (not (bobp))
	     (eq (char-syntax (preceding-char)) ?\<)))))

(defun smart-snippet-make-snippet-function-symbol
  (abbrev-name abbrev-table)
  (intern
   (concat "smart-snippet-abbrev-"
	   (snippet-strip-abbrev-table-suffix
	    (symbol-name abbrev-table))
	   "-"
	   abbrev-name)))
  
(defun smart-snippet-make-abbrev-expansion-hook
  (abbrev-table abbrev-name)
  "Define a function with the `no-self-insert' property set non-nil.
The function name is composed of \"smart-snippet-abbrev-\", the
abbrev table name, and the name of the abbrev.  If the abbrev
table name ends in \"-abbrev-table\", it is stripped."
  (let ((abbrev-expansion
	 (smart-snippet-make-snippet-function-symbol abbrev-name
						     abbrev-table)))
    (if (functionp abbrev-expansion)
	abbrev-expansion
      (fset abbrev-expansion 
	    `(lambda (&optional call-directly)
	       (interactive)
	       (smart-snippet-expand ,abbrev-name
				     ,table
				     call-directly)))
      (put abbrev-expansion 'no-self-insert t)
      abbrev-expansion)))
  
(defun smart-snippet-abbrev-table (abbrev-table-name)
  (let ((table-symbol (intern
		      (concat (snippet-strip-abbrev-table-suffix
			       abbrev-table-name)
			      "-smart-snippet-abbrev-table"))))
    (unless (and (boundp table-symbol)
		 (hash-table-p (symbol-value table-symbol)))
      (set table-symbol (make-hash-table :test 'equal)))
    (symbol-value table-symbol)))

(defun smart-snippet-abbrev (abbrev-table abbrev-name template condition)
  "Establish an abbrev for a snippet template.
Set up an abbreviation called ABBREV-NAME in the
ABBREV-TABLE(must be quoted) that expands into a snippet using
the specified TEMPLATE string when CONDITION is satisfied.

if CONDITION is a function, it must accept no argument. It is
called to determine whether to expand the current abbrev.

if CONDITION is a list, it is then evaluated to determine
whether to expand the current abbrev.

if CONDITION is a symbol, it is then evaluated to determine
whether to expand the current abbrev.

All evaluation will be done under a circumstance where those
variables are available:

 abbrev-name : the current abbrev-name being expanded
 inside-comment? : t if currently position is inside comment
 bol? : beginning of line(whitespaces are ignored)
"
  ;; first store the snippet template
  (let* ((table (smart-snippet-abbrev-table (symbol-name abbrev-table)))
	 (snippet-list (gethash abbrev-name table))
	 (snippet (assoc template snippet-list)))
    (puthash abbrev-name
	     (cond ((null snippet)
		    (cons (list template condition)
			  snippet-list))
		   ;; overwrite the snippet of the same template
		   (t (setcdr snippet (cons condition nil))
		      snippet-list))
	     table)
  
    ;; then setup the abbrev-table hook
    (define-abbrev (symbol-value abbrev-table) abbrev-name abbrev-name
      (smart-snippet-make-abbrev-expansion-hook
       abbrev-table abbrev-name))))

;; (defmacro smart-snippet-with-abbrev-table
;;   (abbrev-table &rest snippet-list)
;;     "Establish a set of abbrevs for snippet templates.
;; Set up a series of snippet abbreviations in the ABBREV-TABLE (note
;; that ABBREV-TABLE must be quoted.  The abbrevs are specified in
;; SNIPPET-LIST.  On how to write each abbrev item, please refer to
;; `smart-snippet-abbrev-table'."
;;     (let ((table (gensym)))
;;       `(let ((,table ,abbrev-table))
;; 	 (progn
;; 	   ,@(loop for (name template condition) in snippet-list
;; 		   collect (list 'smart-snippet-abbrev
;; 				 table
;; 				 name
;; 				 template
;; 				 condition))))))

(defun smart-snippet-set-snippet-key
  (keymap abbrev-table abbrev-name key)
  "Some snippet can't be triggered by the default abbrev expansion.
E.g. you can't have a snippet '{' to be expand into '{ }' because
the default abbrev expansion ignore punctuations. So we must bind
them to the snippet explicitly.

KEYMAP is the keymap to define key.
ABBREV-NAME is the abbrev you used to define the snippet.
ABBREV-TABLE is the table in which you define this snippet(must be
quoted).
KEY is which key you want to bind to.

There is an example:
  (smart-snippet-set-snippet-key
    c++-mode-map 'c++-mode-abbrev-table \"{\" \"{\")"
  (define-key
    keymap
    key
    `(lambda ()
       (interactive)
       (funcall
	',(smart-snippet-make-snippet-function-symbol abbrev-name
						      abbrev-table)
	t))))

;; (defmacro smart-snippet-with-keymap
;;   (keymap abbrev-table &rest map-list)
;;   (let ((table (gensym))
;; 	(map (gensym)))
;;     `(let ((,table ,abbrev-table)
;; 	   (,map ,keymap))
;;        (progn
;; 	 ,@(loop for (name key) in map-list
;; 		 collect (list 'smart-snippet-set-snippet-key
;; 			       map
;; 			       name
;; 			       table
;; 			       key))))))

(defun smart-snippet-flatten-1 (list)
  (cond ((atom list) list)
	((listp (car list))
	 (append (car list)
		 (smart-snippet-flatten-1 (cdr list))))
	(t (append (list (car list))
		   (smart-snippet-flatten-1 (cdr list))))))
(defun smart-snippet-quote-element (list)
  (loop for item in list
	collect (list 'quote item)))
(defmacro smart-snippet-with-abbrev-tables
  (abbrev-tables &rest snippets)
  (let ((tables (smart-snippet-quote-element abbrev-tables)))
    `(progn
       ,@(smart-snippet-flatten-1
	  (loop for table in tables
		collect (loop for snippet in snippets
			      collect (append
				       (list
					'smart-snippet-abbrev
					table)
				       snippet)))))))
(defmacro smart-snippet-with-keymaps
  (keymap-and-abbrev-tables &rest map-list)
  (let ((kaymap-and-abbrev-tables
	 (smart-snippet-quote-element keymap-and-abbrev-tables)))
    `(progn
       ,@(smart-snippet-flatten-1
	  (loop for map-and-table in keymap-and-abbrev-tables
		collect (loop for key-mapping in map-list
			      collect (list
				       'smart-snippet-set-snippet-key
				       (car map-and-table)
				       (list 'quote
					     (cadr map-and-table))
				       (car key-mapping)
				       (cadr key-mapping))))))))
					


;;; Make some variables in snippet.el buffer local
(make-variable-buffer-local 'snippet-field-default-beg-char)
(make-variable-buffer-local 'snippet-field-default-end-char)
(make-variable-buffer-local 'snippet-indent)
(make-variable-buffer-local 'snippet-exit-identifier)
(make-variable-buffer-local 'snippet-field-identifier)

;;; some snippet.el function rewrite

;; Reason:

;; (setq snippet-exit-identifier "$;")
;; 
;; This is a triky. The default identifier is "$."
;; When you write a snippet(for c/c++) like this:
;;
;;  if ($${condition})
;;  {$>
;;  $.$>
;;  }$>
;;
;; The last "}" won't indent correctly. since there is a "$." at the
;; previous line which is not a complete sentence. So I use "$;" which
;; has a ";" character at the end. This is exactly the character for
;; terminating a sentence in c/c++. Thus the "}" can indent correctly.
;; But this is only a solution for c/c++. If other languages have
;; similar problems, it won't be easy to fix it. So a better way is
;; to rewrite the `snippet-insert' function in snippet.el so that it
;; removes the "$." character before it begins to do indentation (or
;; it just never insert it).

;; Solution:

(defun snippet-split-regexp ()
  "Return a regexp to split the template into component parts."
  (concat (regexp-quote snippet-line-terminator)
          "\\|"
          (regexp-quote snippet-indent)
	  "\\|"
	  (regexp-quote snippet-exit-identifier)))

(defun snippet-insert (template)
  "Insert a snippet into the current buffer at point.  
TEMPLATE is a string that may optionally contain fields which are
specified by `snippet-field-identifier'.  Fields may optionally also
include default values delimited by `snippet-field-default-beg-char'
and `snippet-field-default-end-char'.

For example, the following template specifies two fields which have
the default values of \"element\" and \"sequence\":

  \"for $${element} in $${sequence}:\"

In the next example, only one field is specified and no default has
been provided:

  \"import $$\"

This function may be called interactively, in which case, the TEMPLATE
is prompted for.  However, users do not typically invoke this function
interactively, rather it is most often called as part of an abbrev
expansion.  See `snippet-abbrev' and `snippet-with-abbrev-table' for
more information."
  (interactive "sSnippet template: ")

  ;; Step 1: Ensure only one snippet exists at a time
  (snippet-cleanup)

  ;; Step 2: Create a new snippet and add the overlay to bound the
  ;; template body.  It should be noted that the bounded overlay is
  ;; sized to be one character larger than the template body text.
  ;; This enables our keymap to be active when a field happens to be
  ;; the last item in a template.
  (let ((start (point))
	(field-markers nil))
    (setq snippet (make-snippet :bound (snippet-make-bound-overlay)))
    (insert template)
    (move-overlay (snippet-bound snippet) start (1+ (point)))

    ;; Step 3: Find and record each field's markers
    (goto-char (overlay-start (snippet-bound snippet)))
    (while (re-search-forward (snippet-field-regexp)
                              (overlay-end (snippet-bound snippet)) 
                              t)
      (let ((start (copy-marker (match-beginning 0) t)))
        (replace-match (if (match-beginning 2) "\\2" ""))
	(push (cons start (copy-marker (point) t)) field-markers)))

    ;; Step 4: Find exit marker
    (goto-char (overlay-start (snippet-bound snippet)))
    (while (search-forward snippet-exit-identifier
			   (overlay-end (snippet-bound snippet)) 
			   t)
      (replace-match "")
      (setf (snippet-exit-marker snippet) (copy-marker (point) t)))

    ;; step 5: Do necessary indentation
    (goto-char (overlay-start (snippet-bound snippet)))
    (while (search-forward snippet-indent
			   (overlay-end (snippet-bound snippet)) 
			   t)
      (replace-match "")
      (indent-according-to-mode))
    
    ;; Step 6: Insert the exit marker so we know where to move point
    ;; to when user is done with snippet.  If they did not specify
    ;; where point should land, set the exit marker to the end of the
    ;; snippet. 
    (goto-char (overlay-start (snippet-bound snippet)))
    
    (unless (snippet-exit-marker snippet)
      (let ((end (overlay-end (snippet-bound snippet))))
        (goto-char (if (= end (point-max)) end (1- end))))
      (setf (snippet-exit-marker snippet) (point-marker)))
  
    (set-marker-insertion-type (snippet-exit-marker snippet) t)

    ;; Step 7: Create field overlays for each field and insert any
    ;; default values for the field.
    (dolist (marker-pair field-markers)
      (let ((field (snippet-make-field-overlay
		    (buffer-substring (car marker-pair)
				      (cdr marker-pair)))))
	(push field (snippet-fields snippet))
	(move-overlay field
		      (car marker-pair)
		      (cdr marker-pair)))))
    
  ;; Step 8: Position the point at the first field or the end of the
  ;; template body if no fields are present.  We need to take into
  ;; consideration the special case where the first field is at the
  ;; start of the snippet (otherwise the call to snippet-next-field
  ;; will go past it).
  (let ((bound (snippet-bound snippet))
        (first (car (snippet-fields snippet))))
    (if (and first (= (overlay-start bound) (overlay-start first)))
        (goto-char (overlay-start first))
      (goto-char (overlay-start (snippet-bound snippet)))
      (snippet-next-field))))

;;; smart-snippet.el ends here
