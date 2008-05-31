;;; ==================================================================
;;; Author:  gary iams
;;; File:    ini-rcirc
;;; Purpose: Setups for the Internet Relay Chat client of choice
;;; ==================================================================

;;; Setups for Rcirc =================================================

(setq rcirc-buffer-maximum-lines 10240)
(setq rcirc-fill-column 80)

(setq rcirc-default-nick "geiams")
(setq rcirc-default-user-name "gary")
(setq rcirc-default-user-full-name "gary iams")
(setq rcirc-server-alist '(("irc.freenode.net"
                            :channels ("#emacs"))))
(setq rcirc-authinfo '(("freenode" nickserve "geiams" "password")))


;;; auto loads -------------------------------------------------------

(add-hook 'rcirc-mode-hook (lambda () (rcirc-track-minor-mode 1)))
(add-hook 'rcirc-mode-hook (lambda () (flyspell-mode 1)))
(add-hook 'rcirc-mode-hook ; Keep input line at bottom.
          (lambda ()
            (set (make-local-variable 'scroll-conservatively) 8192)))
