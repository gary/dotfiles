(setq mmm-global-mode 'maybe)
(setq mmm-submode-decoration-level 2)

(mmm-add-group 'jsp
	       `((jsp-code
		  :submode java
		  :match-face (("<%!" . mmm-declaration-submode-face)
			       ("<%=" . mmm-output-submode-face)
			       ("<%"  . mmm-code-submode-face))
		  :front "<%[!=]?"
		  :back "%>"
		  :insert ((?% jsp-code nil @ "<%" @ " " _ " " @ "%>" @)
			   (?! jsp-declaration nil @ "<%!" @ " " _ " " @ "%>" @)
			   (?= jsp-expression nil @ "<%=" @ " " _ " " @ "%>" @))
		  )
		 (jsp-directive
		  :submode text-mode
		  :face mmm-special-submode-face
		  :front "<%@"
		  :back "%>"
		  :insert ((?@ jsp-directive nil @ "<%@" @ " " _ " " @ "%>" @)))))

(mmm-add-classes
 '((embedded-ruby
    :submode ruby-mode
    :front "<%[=#]?"
    :back "%>"
    :insert ((?r eruby-directive nil @ "<%" @ " " _ " " @ "%>" @)
             (?= eruby-directive nil @ "<%=" @ " " _ " " @ "%>" @)))))
(mmm-add-classes
 '((embedded-css
    :submode css-mode
    :face mmm-declaration-submode-face
    :front "style=\""
    :back "\"")))
(mmm-add-classes
 '((embedded-javascript
    :submode javascript-mode ;; javascript-generic-mode
    :face mmm-declaration-submode-face
    :front "<script\[^>\]*>"
    :back "</script>")))
(mmm-add-classes
 '((embedded-javascript-attribute
    :submode javascript-mode ;; javascript-generic-mode
    :face mmm-declaration-submode-face
    :front "\\bon\\w+=\\s-*\""
    :back "\"")))
 
;; What features should be turned on in this html-mode?
;; TODO: big mess, better understand how submodes are applied and cleanup accordingly.
;; (add-to-list 'mmm-mode-ext-classes-alist
;; 	     '(html-mode nil jsp))
(add-to-list 'mmm-mode-ext-classes-alist
	     '(html-mode nil embedded-css))
(add-to-list 'mmm-mode-ext-classes-alist
	     '(html-mode nil embedded-ruby))
(add-to-list 'mmm-mode-ext-classes-alist
	     '(html-mode nil embedded-javascript))
(add-to-list 'mmm-mode-ext-classes-alist
	     '(html-mode nil embedded-javascript-attribute))