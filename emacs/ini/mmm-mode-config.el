(setq mmm-global-mode 'maybe)
(setq mmm-submode-decoration-level 2)

;; TODO:
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(mmm-cleanup-submode-face ((t (:background "Wheat" :foreground "black"))))
 '(mmm-code-submode-face ((t (:background "LightGray" :foreground "black"))))
 '(mmm-comment-submode-face ((t (:background "SkyBlue" :foreground "black"))))
 '(mmm-declaration-submode-face ((t (:background "Aquamarine" :foreground "black"))))
 '(mmm-default-submode-face ((t (:background "gray85" :foreground "black"))))
 '(mmm-init-submode-face ((t (:background "Pink" :foreground "black"))))
 '(mmm-output-submode-face ((t (:background "Plum" :foreground "black"))))
 '(mmm-special-submode-face ((t (:background "MediumSpringGreen" :foreground "black")))))

(mmm-add-mode-ext-class nil "\\.jsp$" 'embedded-css)
(mmm-add-mode-ext-class nil "\\.jsp$" 'html-js)
(mmm-add-mode-ext-class nil "\\.jsp$" 'jsp) ;;

;; (mmm-add-classes
;;  '((embedded-ruby
;;     :submode ruby-mode
;;     :front "<%[=#]?"
;;     :back "%>"
;;     :insert ((?r eruby-directive nil @ "<%" @ " " _ " " @ "%>" @)
;;              (?= eruby-directive nil @ "<%=" @ " " _ " " @ "%>" @)))))

;; (mmm-add-mode-ext-class nil "\\.rb$" 'embedded-ruby)
;; (mmm-add-mode-ext-class nil "\\.rhtml$" 'embedded-ruby)