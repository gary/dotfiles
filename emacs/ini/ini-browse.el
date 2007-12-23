;;; ==================================================================
;;; Author:  Jim Weirich
;;; File:    ini-browse
;;; Purpose: Setups for browse-url
;;; ==================================================================

(setq browse-url-browser-function 'browse-url-netscape)
;;;      (if (at-home) 'browse-url-netscape 'browse-url-mosaic))


(autoload browse-url-browser-function "new-browse-url.el"
  "Ask a WWW browser to show a URL." t)

(global-set-key "\C-xw" browse-url-browser-function)
(if (not (is-xemacs))
    (global-set-key [S-mouse-1] 'browse-url-at-mouse))

(autoload 'browse-url-at-mouse "new-browse-url.el"
  "Ask a WWW browser to show a URL." t)

;; For viewing current buffer:

(autoload 'browse-url-of-file "new-browse-url.el"
  "Ask a WWW browser to display the current file." t)
(setq browse-url-save-file t)	; Always save
