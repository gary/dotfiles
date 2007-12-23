;;; ==================================================================
;;; Author:  Jim Weirich (modifications by gary iams)
;;; File:    ini-gnuserv
;;; Purpose: Setups for GnuServ program
;;; ==================================================================

;;; Setups for the GnuServe program ==================================

(defun server ()
  (interactive)
  (setq gnuserv-program "/usr/bin/gnuserv")
  (setq gnuserv-frame (selected-frame))
  (gnuserv-start) )
