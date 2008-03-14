;;; ==================================================================
;;; Author:  gary iams
;;; File:    ini-cedet
;;; Purpose: Setups for Collection of Emacs Development Environment Tools
;;; ==================================================================

;;; Setups for CEDET =================================================

(attach-package "/cedet/common")
(require 'cedet)

;;; Setups for EIEIO -------------------------------------------------

(enable-visual-studio-bookmarks)

;;; Setups for Semantic ----------------------------------------------

(setq semanticdb-default-save-directory (concat tmp-directory "/cache"))

;;; Setups for Speedbar ----------------------------------------------
(global-set-key [(f5)] 'speedbar-get-focus)
(global-set-key (kbd "<C-f11>") 'viss-bookmark-toggle)

(add-hook 'speedbar-load-hook (speedbar-add-supported-extension "\\.tld$"))
(add-hook 'speedbar-load-hook (speedbar-add-supported-extension "\\.r\\(b\\|html\\)$"))
