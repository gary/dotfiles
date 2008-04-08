;;; ==================================================================
;;; Author:  Jim Weirich
;;; File:    ini-browse
;;; Purpose: Setups for passing a URL to a WWW browser
;;; ==================================================================

;;; Setups for browse-url

(if (on-osx)
    (setq browse-url-browser-function 'browse-url-default-macosx-browser)
  (setq browse-url-browser-function 'browse-url-firefox))

;;; Customized Variables ---------------------------------------------

(setq browse-url-save-file t)	; Always save

;;; Autoloads --------------------------------------------------------

(autoload browse-url-browser-function "new-browse-url.el"
  "Ask a WWW browser to show a URL." t)

(autoload 'browse-url-at-mouse "new-browse-url.el"
  "Ask a WWW browser to show a URL." t)

;; For viewing current buffer:
(autoload 'browse-url-of-file "new-browse-url.el"
  "Ask a WWW browser to display the current file." t)

;;; Key Bindings -----------------------------------------------------

(if (not (is-xemacs))
    (global-set-key [S-mouse-1] 'browse-url-at-mouse))

(global-set-key "\C-c\C-ku" 'browse-url-at-point)
