;;; ==================================================================
;;; Author:  Jim Weirich
;;; File:    ini-browse
;;; Purpose: Setups for browse-url
;;; ==================================================================

(if (on-osx)
    (setq browse-url-browser-function 'browse-url-default-macosx-browser)
  (setq browse-url-browser-function 'browse-url-firefox))

(autoload browse-url-browser-function "new-browse-url.el"
  "Ask a WWW browser to show a URL." t)

(if (not (is-xemacs))
    (global-set-key [S-mouse-1] 'browse-url-at-mouse))

(autoload 'browse-url-at-mouse "new-browse-url.el"
  "Ask a WWW browser to show a URL." t)

;; For viewing current buffer:

(autoload 'browse-url-of-file "new-browse-url.el"
  "Ask a WWW browser to display the current file." t)
(setq browse-url-save-file t)	; Always save
