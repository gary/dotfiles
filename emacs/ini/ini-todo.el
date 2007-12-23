;;; ==================================================================
;;; Author:  Jim Weirich
;;; File:    ini-todo
;;; Purpose: Todo Mode Autoloads and setups
;;; ==================================================================

(defvar todo-log-file-name "~/.todo" "\
*Name of a todo log file for \\[add-todo-log-entry].")

(autoload (quote todo-file-name) "todo" "\
Find a todo log file for \\[add-todo-log-entry] and return the name." nil nil)

(autoload (quote todo-log-entry) "todo" "\
Find todo log file in other window and add an entry for today.
Optional arg (interactive prefix) non-nil means add a new entry." t nil)

(autoload (quote todo-find-log-entry) "todo" "\
Find a log entry for today" t nil)

(autoload (quote todo-find-todo-entry) "todo" "\
Find a log entry for today" t nil)

(autoload (quote todo-new-log-entry) "todo" nil t nil)

(autoload (quote todo-new-todo-entry) "todo" nil t nil)
(define-key ctl-x-4-map "t" 'todo-find-todo-entry)
(define-key ctl-x-4-map "l" 'todo-find-log-entry)

(autoload (quote todo-mode) "todo" "\
Major mode for editing todo logs; like Indented Text Mode.
Prevents numeric backups and sets `left-margin' to 4 and `fill-column' to 70.
New log entries are usually made with \\[add-todo-log-entry] or \\[add-todo-log-entry-other-window].
Each entry behaves as a paragraph, and the entries for one day as a page.
Runs `todo-mode-hook'." t nil)
