(defun my-color-theme ()
  "Color theme by gary, created 2007-03-07."
  (interactive)
  (color-theme-install
   '(my-color-theme
     ((background-color . "gray7")
      (background-mode . dark)
      (border-color . "gray7")
      (cursor-color . "khaki")
      (foreground-color . "cornsilk2")
      (mouse-color . "gold"))
     ((Man-overstrike-face . bold)
      (Man-reverse-face . highlight)
      (Man-underline-face . underline)
      (apropos-keybinding-face . underline)
      (apropos-label-face . italic)
      (apropos-match-face . match)
      (apropos-property-face . bold-italic)
      (apropos-symbol-face . bold)
      (browse-kill-ring-separator-face . bold)
      (cua-global-mark-cursor-color . "cyan")
      (cua-normal-cursor-color . "red")
      (cua-overwrite-cursor-color . "yellow")
      (cua-read-only-cursor-color . "darkgreen")
      (dabbrev-highlight-face . highlight)
      (ebnf-except-border-color . "Black")
      (ebnf-line-color . "Black")
      (ebnf-non-terminal-border-color . "Black")
      (ebnf-repeat-border-color . "Black")
      (ebnf-special-border-color . "Black")
      (ebnf-terminal-border-color . "Black")
      (gnus-mouse-face . highlight)
      (list-matching-lines-buffer-name-face . underline)
      (list-matching-lines-face . match)
      (notify-user-of-mode-face . blue-foreground-face)
      (ps-line-number-color . "black")
      (ps-zebra-color . 0.95)
      (rmail-highlight-face . rmail-highlight)
      (setnu-line-number-face . bold)
      (vc-annotate-very-old-color . "#3F3FFF")
      (view-highlight-face . highlight)
      (whitespace-display-spaces-in-color . t)
      (widget-mouse-face . highlight))
     (default ((t (:stipple nil :background "gray7" :foreground "cornsilk2" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :family "apple-monaco"))))
     (blue-foreground-face ((t (:foreground "Blue"))))
     (bold ((t (:bold t :weight bold))))
     (bold-italic ((t (:italic t :bold t :slant italic :weight bold))))
     (border ((t (:background "black"))))
     (buffer-menu-buffer ((t (:bold t :weight bold))))
     (button ((t (:underline t))))
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;; comint
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     (comint-highlight-input ((t (:bold t :weight bold))))
     (comint-highlight-prompt ((t (:foreground "red1"))))
     (completions-common-part ((t (:family "apple-monaco" :width normal :weight normal :slant normal :underline nil :overline nil :strike-through nil :box nil :inverse-video nil :foreground "chartreuse1" :background "gray7" :stipple nil :height 120))))
     (completions-first-difference ((t (:bold t :weight bold :foreground "firebrick3"))))
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;; cua
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     (cua-global-mark ((t (:background "yellow1" :foreground "black"))))
     (cua-rectangle ((t (:background "maroon" :foreground "white"))))
     (cua-rectangle-noselect ((t (:background "dimgray" :foreground "white"))))
     (cursor ((t (:background "khaki"))))
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;; custom
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     (custom-button ((t (:background "lightgrey" :foreground "black" :box (:line-width 2 :style released-button)))))
     (custom-button-mouse ((t (:background "grey90" :foreground "black" :box (:line-width 2 :style released-button)))))
     (custom-button-pressed ((t (:background "lightgrey" :foreground "black" :box (:line-width 2 :style pressed-button)))))
     (custom-button-pressed-unraised ((t (:underline t :foreground "magenta4"))))
     (custom-button-unraised ((t (:underline t))))
     (custom-changed ((t (:background "blue1" :foreground "white"))))
     (custom-comment ((t (:background "gray85"))))
     (custom-comment-tag ((t (:foreground "blue4"))))
     (custom-documentation ((t (nil))))
     (custom-face-tag ((t (:bold t :family "apple-monaco" :weight bold :height 1.2))))
     (custom-group-tag ((t (:bold t :foreground "blue1" :weight bold :height 1.2))))
     (custom-group-tag-1 ((t (:bold t :family "apple-monaco" :foreground "red1" :weight bold :height 1.2))))
     (custom-invalid ((t (:background "red1" :foreground "yellow1"))))
     (custom-link ((t (:underline t :foreground "blue1"))))
     (custom-modified ((t (:background "blue1" :foreground "white"))))
     (custom-rogue ((t (:background "black" :foreground "pink"))))
     (custom-saved ((t (:underline t))))
     (custom-set ((t (:background "white" :foreground "blue1"))))
     (custom-state ((t (:foreground "dark green"))))
     (custom-themed ((t (:background "blue1" :foreground "white"))))
     (custom-variable-button ((t (:bold t :underline t :weight bold))))
     (custom-variable-tag ((t (:bold t :family "apple-monaco" :foreground "blue1" :weight bold :height 1.2))))
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;; dired
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     (dired-directory ((t (:foreground "Blue1"))))
     (dired-flagged ((t (:bold t :weight bold :foreground "Red1"))))
     (dired-header ((t (:foreground "ForestGreen"))))
     (dired-ignored ((t (:foreground "grey50"))))
     (dired-mark ((t (:foreground "CadetBlue"))))
     (dired-marked ((t (:bold t :weight bold :foreground "Red1"))))
     (dired-symlink ((t (:foreground "Purple"))))
     (dired-warning ((t (:foreground "Firebrick"))))
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;; ediff
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     (ediff-current-diff-A ((t (:background "pale green" :foreground "firebrick"))))
     (ediff-current-diff-Ancestor ((t (:background "VioletRed" :foreground "Black"))))
     (ediff-current-diff-B ((t (:background "Yellow" :foreground "DarkOrchid"))))
     (ediff-current-diff-C ((t (:background "Pink" :foreground "SkyBlue"))))
     (ediff-even-diff-A ((t (:background "light grey" :foreground "Black"))))
     (ediff-even-diff-Ancestor ((t (:background "Grey" :foreground "White"))))
     (ediff-even-diff-B ((t (:background "Grey" :foreground "White"))))
     (ediff-even-diff-C ((t (:background "light grey" :foreground "Black"))))
     (ediff-fine-diff-A ((t (:background "white" :foreground "SkyBlue"))))
     (ediff-fine-diff-Ancestor ((t (:background "Green" :foreground "Black"))))
     (ediff-fine-diff-B ((t (:background "cyan" :foreground "Black"))))
     (ediff-fine-diff-C ((t (:background "Turquoise" :foreground "Black"))))
     (ediff-odd-diff-A ((t (:background "Grey" :foreground "White"))))
     (ediff-odd-diff-Ancestor ((t (:background "gray40" :foreground "cyan3"))))
     (ediff-odd-diff-B ((t (:background "light grey" :foreground "Black"))))
     (ediff-odd-diff-C ((t (:background "Grey" :foreground "White"))))
     (eieio-custom-slot-tag-face ((t (:foreground "blue"))))
     (escape-glyph ((t (:foreground "brown"))))
     (file-name-shadow ((t (:foreground "grey50"))))
     (fixed-pitch ((t (:family "courier"))))
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;; font-lock-mode
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     (font-lock-builtin-face ((t (:foreground "DarkSeaGreen"))))
     (font-lock-comment-delimiter-face ((t (:foreground "OrangeRed"))))
     (font-lock-comment-face ((t (:foreground "OrangeRed"))))
     (font-lock-constant-face ((t (:foreground "CadetBlue"))))
     (font-lock-doc-face ((t (:foreground "RosyBrown"))))
     (font-lock-function-name-face ((t (:foreground "DeepSkyBlue3"))))
     (font-lock-keyword-face ((t (:foreground "cyan2"))))
     (font-lock-negation-char-face ((t (nil))))
     (font-lock-preprocessor-face ((t (:foreground "turquoise1"))))
     (font-lock-regexp-grouping-backslash ((t (:bold t :weight bold))))
     (font-lock-regexp-grouping-construct ((t (:bold t :weight bold))))
     (font-lock-string-face ((t (:foreground "RosyBrown"))))
     (font-lock-type-face ((t (:foreground "ForestGreen"))))
     (font-lock-variable-name-face ((t (:foreground "DarkGoldenrod"))))
     (font-lock-warning-face ((t (:bold t :foreground "red3" :weight bold))))
     (fringe ((t (:background "grey95"))))
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;; gnus
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
     (gnus-group-mail-1 ((t (:bold t :foreground "DeepPink3" :weight bold))))
     (gnus-group-mail-1-empty ((t (:foreground "DeepPink3"))))
     (gnus-group-mail-2 ((t (:bold t :foreground "HotPink3" :weight bold))))
     (gnus-group-mail-2-empty ((t (:foreground "HotPink3"))))
     (gnus-group-mail-3 ((t (:bold t :foreground "magenta4" :weight bold))))
     (gnus-group-mail-3-empty ((t (:foreground "magenta4"))))
     (gnus-group-mail-low ((t (:bold t :foreground "DeepPink4" :weight bold))))
     (gnus-group-mail-low-empty ((t (:foreground "DeepPink4"))))
     (gnus-group-news-1 ((t (:bold t :foreground "ForestGreen" :weight bold))))
     (gnus-group-news-1-empty ((t (:foreground "ForestGreen"))))
     (gnus-group-news-2 ((t (:bold t :foreground "CadetBlue4" :weight bold))))
     (gnus-group-news-2-empty ((t (:foreground "CadetBlue4"))))
     (gnus-group-news-3 ((t (:bold t :weight bold))))
     (gnus-group-news-3-empty ((t (nil))))
     (gnus-group-news-4 ((t (:bold t :weight bold))))
     (gnus-group-news-4-empty ((t (nil))))
     (gnus-group-news-5 ((t (:bold t :weight bold))))
     (gnus-group-news-5-empty ((t (nil))))
     (gnus-group-news-6 ((t (:bold t :weight bold))))
     (gnus-group-news-6-empty ((t (nil))))
     (gnus-group-news-low ((t (:bold t :foreground "DarkGreen" :weight bold))))
     (gnus-group-news-low-empty ((t (:foreground "DarkGreen"))))
     (gnus-splash ((t (:foreground "#888888"))))
     (gnus-summary-cancelled ((t (:background "black" :foreground "yellow"))))
     (gnus-summary-high-ancient ((t (:bold t :foreground "RoyalBlue" :weight bold))))
     (gnus-summary-high-read ((t (:bold t :foreground "DarkGreen" :weight bold))))
     (gnus-summary-high-ticked ((t (:bold t :foreground "firebrick" :weight bold))))
     (gnus-summary-high-undownloaded ((t (:bold t :foreground "cyan4" :weight bold))))
     (gnus-summary-high-unread ((t (:bold t :weight bold))))
     (gnus-summary-low-ancient ((t (:italic t :foreground "RoyalBlue" :slant italic))))
     (gnus-summary-low-read ((t (:italic t :foreground "DarkGreen" :slant italic))))
     (gnus-summary-low-ticked ((t (:italic t :foreground "firebrick" :slant italic))))
     (gnus-summary-low-undownloaded ((t (:italic t :foreground "cyan4" :slant italic :weight normal))))
     (gnus-summary-low-unread ((t (:italic t :slant italic))))
     (gnus-summary-normal-ancient ((t (:foreground "RoyalBlue"))))
     (gnus-summary-normal-read ((t (:foreground "DarkGreen"))))
     (gnus-summary-normal-ticked ((t (:foreground "firebrick"))))
     (gnus-summary-normal-undownloaded ((t (:foreground "cyan4" :weight normal))))
     (gnus-summary-normal-unread ((t (nil))))
     (gnus-summary-selected ((t (:underline t))))
     (header-line ((t (:box (:line-width -1 :style released-button) :background "grey90" :foreground "grey20" :box nil))))
     (help-argument-name ((t (:italic t :slant italic))))
     (hi-black-b ((t (:bold t :weight bold))))
     (hi-black-hb ((t (:bold t :family "apple-monaco" :weight bold :height 1.67))))
     (hi-blue ((t (:background "grey7"))))
     (hi-blue-b ((t (:bold t :foreground "blue1" :weight bold))))
     (hi-green ((t (:background "green1"))))
     (hi-green-b ((t (:bold t :foreground "green1" :weight bold))))
     (hi-pink ((t (:background "pink"))))
     (hi-red-b ((t (:bold t :foreground "red1" :weight bold))))
     (hi-yellow ((t (:background "yellow1"))))
     (highlight ((t (:background "firebrick1"))))
     (highlight-changes ((t (:foreground "red1"))))
     (highlight-changes-delete ((t (:foreground "red1" :underline t))))
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;; i modes
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     (isearch ((t (:background "magenta3" :foreground "black"))))
     (iswitchb-current-match ((t (:foreground "OliveDrab4"))))
     (iswitchb-invalid-regexp ((t (:bold t :weight bold :foreground "Red1"))))
     (iswitchb-single-match ((t (:foreground "Firebrick"))))
     (iswitchb-virtual-matches ((t (:foreground "turquoise1"))))
     (italic ((t (:italic t :slant italic))))
     (lazy-highlight ((t (:background "gray7"))))
     (link ((t (:foreground "blue1" :underline t))))
     (link-visited ((t (:underline t :foreground "magenta4"))))
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;; mac-specific
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     (mac-ts-block-fill-text ((t (:underline t))))
     (mac-ts-caret-position ((t (nil))))
     (mac-ts-converted-text ((t (:underline "gray80"))))
     (mac-ts-no-hilite ((t (:family "apple-monaco" :width normal :weight normal :slant normal :underline nil :overline nil :strike-through nil :box nil :inverse-video nil :foreground "cornsilk2" :background "gray7" :stipple nil :height 120)))) (mac-ts-outline-text ((t (:underline t))))
     (mac-ts-raw-text ((t (:underline t))))
     (mac-ts-selected-converted-text ((t (:underline t))))
     (mac-ts-selected-raw-text ((t (:underline t))))
     (mac-ts-selected-text ((t (:underline t))))
     (match ((t (:background "Tan"))))
     (menu ((t (nil))))
     (message-cited-text ((t (:eground "red"))))
     (message-header-cc ((t (:foreground "MidnightBlue"))))
     (message-header-name ((t (:foreground "cornflower blue"))))
     (message-header-newsgroups ((t (:italic t :bold t :foreground "blue4" :slant italic :weight bold))))
     (message-header-other ((t (:foreground "steel blue"))))
     (message-header-subject ((t (:bold t :foreground "SkyBlue" :weight bold))))
     (message-header-to ((t (:bold t :foreground "MidnightBlue" :weight bold))))
     (message-header-xheader ((t (:foreground "blue"))))
     (message-mml ((t (:foreground "ForestGreen"))))
     (message-separator ((t (:foreground "brown"))))
     (minibuffer-prompt ((t (:foreground "NavajoWhite2"))))
     (mode-line ((t (:background "grey75" :foreground "black" :box (:line-width -1 :style released-button)))))
     (mode-line-buffer-id ((t (:bold t :weight bold))))
     (mode-line-highlight ((t (:box (:line-width 2 :color "grey40" :style released-button)))))
     (mode-line-inactive ((t (:background "grey90" :foreground "grey20" :box (:line-width -1 :color "grey75" :style nil) :weight light))))
     (mouse ((t (:background "midnightblue"))))
     (next-error ((t (:background "lightgoldenrod2"))))
     (nobreak-space ((t (:foreground "brown" :underline t))))
     (query-replace ((t (:foreground "black" :background "magenta3"))))
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;; rcirc
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     (rcirc-bright-nick ((t (:foreground "CadetBlue"))))
     (rcirc-dim-nick ((t (:family "apple-monaco" :width normal :weight normal :slant normal :underline nil :overline nil :strike-through nil :box nil :inverse-video nil :foreground "grey10" :background "gray7" :stipple nil :height 120))))
     (rcirc-mode-line-nick ((t (:bold t :weight bold))))
     (rcirc-my-nick ((t (:foreground "Blue1"))))
     (rcirc-nick-in-message ((t (:foreground "Purple"))))
     (rcirc-other-nick ((t (:foreground "DarkGoldenrod"))))
     (rcirc-prompt ((t (:foreground "dark blue"))))
     (rcirc-server ((t (:foreground "Firebrick"))))
     (rcirc-server-prefix ((t (:foreground "Firebrick"))))
     (rcirc-timestamp ((t (:family "apple-monaco" :width normal :weight normal :slant normal :underline nil :overline nil :strike-through nil :box nil :inverse-video nil :foreground "cornsilk2" :background "gray7" :stipple nil :height 120))))
     (region ((t (:background "DodgerBlue1"))))
     (scroll-bar ((t (nil))))
     (secondary-selection ((t (:background "yellow1"))))
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;; semantic
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     (semantic-highlight-edits-face ((t (:background "gray90"))))
     (semantic-unmatched-syntax-face ((t (:underline "red"))))
     (shadow ((t (:foreground "grey50"))))
     (show-paren-match ((t (:background "yellow" :foreground "black"))))
     (show-paren-mismatch ((t (:background "orange red" :foreground "white"))))
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;; speedbar
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     (speedbar-button-face ((t (:foreground "green4"))))
     (speedbar-directory-face ((t (:foreground "blue4"))))
     (speedbar-file-face ((t (:foreground "cyan4"))))
     (speedbar-highlight-face ((t (:background "green"))))
     (speedbar-selected-face ((t (:foreground "red" :underline t))))
     (speedbar-separator-face ((t (:background "blue" :foreground "white" :overline "gray"))))
     (u6speedbar-tag-face ((t (:foreground "brown"))))
     (tool-bar ((t (:background "#e2e2e2" :foreground "black" :box (:line-width 1 :style released-button)))))
     (tooltip ((t (:family "apple-monaco" :background "lightyellow" :foreground "black"))))
     (trailing-whitespace ((t (:background "red1"))))
     (underline ((t (:underline t))))
     (variable-pitch ((t (:family "apple-monaco"))))
     (vertical-border ((t (nil))))
     (whitespace-highlight ((t (:background "green1"))))
     (widget-button ((t (:bold t :weight bold))))
     (widget-button-pressed ((t (:foreground "red1"))))
     (widget-documentation ((t (:foreground "dark green"))))
     (widget-field ((t (:background "gray85"))))
     (widget-inactive ((t (:foreground "grey50"))))
     (widget-single-line-field ((t (:background "gray85"))))
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;; woman
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     (woman-addition ((t (:foreground "orange"))))
     (woman-bold ((t (:bold t :foreground "blue1" :weight bold))))
     (woman-italic ((t (:italic t :foreground "red1" :underline t :slant italic))))
     (woman-italic-no-ul ((t (:italic t :foreground "red1" :underline nil :slant italic))))
     (woman-unknown ((t (:foreground "brown")))))))