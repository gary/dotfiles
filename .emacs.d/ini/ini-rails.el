;;; ==================================================================
;;; Author:  Jim Weirich
;;; File:    ini-rails
;;; Purpose: Setups for Ruby on Rails
;;; ==================================================================

;;; Setups for Rails Specific Functionality ==========================

(add-to-load-path (concat package-directory "/rinari"))
(add-to-load-path (concat package-directory "/rinari/rhtml"))

(require 'rinari)

;;; Setup for dark fonts in rinari/rhtml mode ------------------------

(defface erb-face
  `((t (:background "grey10")))
  "Default inherited face for ERB tag body"
  :group 'rhtml-faces)

(defface erb-delim-face
  `((t (:background "grey15")))
  "Default inherited face for ERB tag delimeters"
  :group 'rhtml-faces)

;;; YASnippets -------------------------------------------------------

(load-library (concat snippet-contrib-directory "/yasnippets-rails/setup.el"))
