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
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
  "Set `ansi-color-for-comint-mode' to t." t)
(setq ansi-color-names-vector
      ["black" "red1" "green3" "yellow3" "DodgerBlue1" "magenta1" "cyan3" "white"])
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on) ;; ?
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)

(snippet-with-abbrev-table 'shell-mode-abbrev-table
       ("findf" . "find $${dir} $${depth} -type f -name $${name} $.")
       ("findd" . "find $${dir} $${depth} -type d -name $${name} $.")
       ("findg" . "find $${dir} $${depth} -type f -name $${name} -exec grep -Hn$${opts} -E -e $${regex} {} \;$.")
       ("finde" . "find $${dir} $${depth} $${type} -name $${name} -exec $${cmd} {} \;$.")
       ("findx" . "find $${dir} $${depth} -type d -name $${name} -print0 | xargs -0 $.")
       ("tarc" . "tar $${cd}-cvfp$${opts} $${name}.tar $${files} $.")
       ("tarx" . "tar $${cd}-xvfp$${opts} $${name}.tar $${files} $.")
       ("tart" . "tar $${cd}-tvf$${opts} $${name}.tar $${files} $.")
       ("grep" . "grep -Hn$${opts} -G -e $${regex} $.") ;; bre
       ("grepe" . "grep -Hn$${opts} -E -e $${regex} $.") ;; ere
       ;; ("grepp" . "grep -Hn$${opts} -P -e $${regex} $.") ;; pcre
       ("grepr" . "grep -Hn$${opts} -E -e $${regex} -r --$${in}clude='$${ext}' $.")
       ;; ruby
       ("gsr" . "gem search $${gemname} --remote $.")
       ("giv" . "gem install $${gemname} --version $${version} $.")
       ("glr" . "gem list $${gemname} --remote $.")
       ;; one-liners
       ("rename" . "find -name '$${re}' | perl -ne'chomp; next unless -e; $oldname = $_; s/$${old}/$${new}/; next if -e; rename $oldname, $_'"))

;; java, jsp and friends
;; highlight .properties files
(add-hook 'conf-javaprop-mode-hook
          '(lambda () (conf-quote-normal nil)))

(add-hook 'java-mode-hook
          '(lambda ()
             (c-subword-mode)
             (c-toggle-hungry-state)))

;; dired
(put 'dired-find-alternate-file 'disabled nil)
(setq dired-listing-switches "-alR")   ;; recursive listings

(autoload 'svn-status "psvn"
  "Examine the status of a Subversion working copy in a directory." t)

(autoload 'ssh "ssh"
          "Open a network login connection via ssh with args input-args." t)

(autoload 'wget "wget" "wget interface for Emacs." t)
(autoload 'wget-web-page "wget" "wget interface to download whole web page." t)