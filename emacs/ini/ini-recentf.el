;;; ==================================================================
;;; Author:  gary iams
;;; File:    ini-recentf
;;; Purpose: Setups for Recently Opened Files Mode
;;; ==================================================================

;;; Setups for recentf mode ==========================================

(require 'recentf)

(recentf-mode 1)

(setq recentf-exclude (quote (".ftp:.*" ".sudo:.*")))
;; (recentf-keep (file-remote-p file-readable-p)) TODO

(setq recentf-max-saved-items 500)
(setq recentf-max-mente-items 100)

(defun xsteve-ido-choose-from-recentf ()
  "Use ido to select a recently opened file from the `recentf-list'"
  (interactive)
  (let ((home (expand-file-name (getenv "HOME"))))
    (find-file
     (ido-completing-read "Recentf open: "
                          (mapcar (lambda (path)
                                    (replace-regexp-in-string home "~" path))
                                  recentf-list)
                          nil t))))

(global-set-key (kbd "<S-f1>") 'recentf-open-files)
(global-set-key "\C-c\C-gf" 'xsteve-ido-choose-from-recentf)
