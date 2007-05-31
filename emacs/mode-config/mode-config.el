(add-hook 'text-mode-hook '(lambda ()
                             (turn-on-auto-fill)))

(add-hook 'emacs-lisp-mode-hook '(lambda ()
                                   (make-local-variable 'write-contents-functions)
                                   (add-hook 'write-contents-functions '(lambda ()
                                                                          (balance-defuns (buffer-name))
                                                                          (untabify-buffer)))))
;; ido
(if (eq emacs-major-version 22)
    (progn
      (setq ido-confirm-unique-completion t)
      (setq ido-default-buffer-method 'samewindow)
      (setq ido-use-filename-at-point t)
      (set-face-background 'ido-first-match "blue3")
      (set-face-foreground 'ido-subdir "SteelBlue1")
      (set-face-foreground 'ido-only-match "blue3")
      (set-face-background 'ido-only-match "white")
      (set-face-foreground 'ido-incomplete-regexp "cornsilk1")
      (set-face-background 'ido-incomplete-regexp "green")))

;; speedbar-mode
(add-hook 'speedbar-load-hook '(lambda ()
                                 (speedbar-add-supported-extension "\\(\\.xml\\|\\.tld\\)") ;; xml files
                                 (speedbar-add-supported-extension ".jsp")
                                 (speedbar-add-supported-extension ".r\\(b\\|html\\)")))

;; shell-mode
;; TODO: tim's crazy .bbprofileshared still not cooperating
;; TODO: parse .bash_aliases and dynamically add new abbrevs!
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
  "Set `ansi-color-for-comint-mode' to t." t)
(setq ansi-color-names-vector
      ["black" "red1" "green3" "yellow3" "DodgerBlue1" "magenta1" "cyan3" "white"])
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on) ;; ?
(add-hook 'shell-mode-hook '(lambda ()
                              (abbrev-mode 1)))

(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)

;; java, jsp and friends
;; highlight .properties files
(add-hook 'conf-javaprop-mode-hook
          '(lambda () (conf-quote-normal nil)))

(add-hook 'java-mode-hook
          '(lambda ()
             (c-subword-mode)
             (c-toggle-hungry-state)))

;; TODO: mmm-mode replacement
;; (defun jsp-mode () (interactive)
;;       (multi-mode 1
;;                   'html-mode
;;                   '("<%--" indented-text-mode)
;;                   '("<%@" indented-text-mode)
;;                   '("<%=" html-mode)
;;                   '("<%" java-mode)
;;                   '("%>" html-mode)
;;                   '("<script" java-mode)
;;                   '("</script" html-mode)
;;                   ))

;; (setq auto-mode-alist
;;       (append '(("\\.jsp$" . jsp-mode)) auto-mode-alist))
;; (setq interpreter-mode-alist (append '(("jsp" . jsp-mode)
;;                                     interpreter-mode-alist)))

;; dired
(put 'dired-find-alternate-file 'disabled nil)
(setq dired-listing-switches "-alR")   ;; recursive listings

(autoload 'svn-status "psvn"
  "Examine the status of a Subversion working copy in a directory." t)

(autoload 'ssh "ssh"
          "Open a network login connection via ssh with args input-args." t)

(autoload 'wget "wget" "wget interface for Emacs." t)
(autoload 'wget-web-page "wget" "wget interface to download whole web page." t)