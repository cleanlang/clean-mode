;;; clean-mode.el --- Major mode for editing clean language files. -*- coding: utf-8; lexical-binding: t; -*-

;; Copyright © 2017, by Mrinal Purohit

;; Author: Mrinal Purohit (iammrinal0@gmail.com)
;; Version: 0.0.1
;; Created: 27 Apr 2017
;; Keywords: languages, clean
;; Homepage: https://github.com/iammrinal0/clean-mode

;; This file is not part of GNU Emacs.

;;; License:

;; You can redistribute this program and/or modify it under the terms of the GNU General Public License version 3.

;;; Commentary:
;;
;; This mode adds basic support to Emacs for writing software using
;; the Clean programming language, available at:
;;
;;     https://github.com/geekskool/clean
;;
;;

;;; Code:

(defconst clean-mode-version-number "0.0.1"
  "Clean Mode version number.")

;; define several category of keywords
(defvar clean-keywords '("if" "then" "else" "return" "in" "let" "do"))
(defvar clean-constants '("false" "true" "null" "node-core" "browser-core"))
(defvar clean-builtins '("getLine" "putLine"  "defineProp" "delete" "readFile" "writeFile" "maybeTrue" "maybeFalse" "maybeNull" "maybeUndefined" "maybeErr" "require" "include" "IO" "print"))

;; generate regex string for each category of keywords
(defvar clean-keywords-regexp (regexp-opt clean-keywords 'words))
(defvar clean-constants-regexp (regexp-opt clean-constants 'words))
(defvar clean-builtins-regexp (regexp-opt clean-builtins 'words))

;; create the list for font-lock.
;; each category of keyword is given a particular face
(defvar clean-font-lock-keywords
      `(
        (,"^\\(\/\/\\)\\(.*\\)\\(\n\\|\\)$" . font-lock-comment-face) ;; For single line comments of the form // text
        (,"\\('[^\\\n']*\\(?:\\.[^\\\n']*\\)*'\\)" . font-lock-string-face) ;; For strings of the form 'val'
        (,"\\([a-z]+\\)\\(\\(\s\\([a-z]+\\)\\)+\\)\\(\s=\\)" (1 font-lock-function-name-face) (2 font-lock-variable-name-face)) ;; For function names of the form `func a b ='
        (,"\\([a-z]+[a-zA-Z0-9]*\\)\\(\s=\\)" . (1 font-lock-variable-name-face)) ;; For variables of the form `a ='
        (,"\\(\\([a-z]+[a-zA-Z0-9]*\s\\)+\\)\\(<-\\)" . (1 font-lock-variable-name-face)) ;; For variables in reverse bind of the form `req res <-'
        (,clean-keywords-regexp . font-lock-keyword-face)
        (,clean-constants-regexp . font-lock-constant-face)
        (,clean-builtins-regexp . font-lock-builtin-face)
        ;; (,"\\(\\([0-9]+.?[0-9]*\\)\\|\\([0-9]+\\)\\)\\(\\(E\\|e\\)\\(+\\|-\\)?[0-9]+\\)?" . font-lock-warning-face)
        ;; note: order above matters, because once colored, that part won't change.
        ;; in general, longer words first
        ))


(defvar clean-mode-syntax-table nil "Syntax table for `clean-mode'.")

(setq clean-mode-syntax-table
      (let ( (synTable (make-syntax-table)))
        ;; comment style “/* … */”
        (modify-syntax-entry ?\/ ". 14" synTable)
        (modify-syntax-entry ?* ". 23" synTable)
        synTable))

;;;###autoload
(define-derived-mode clean-mode prog-mode "clean"
  "clean-mode is a major mode for editing clean language files."
  (setq font-lock-defaults '((clean-font-lock-keywords)))

  (set-syntax-table clean-mode-syntax-table)
  (setq-local comment-start "/*")
  (setq-local comment-start-skip "/\\*+[ \t]*")
  (setq-local comment-end "*\/")
  (setq-local comment-end-skip "[ \t]*\\*+/"))

;; add the mode to the `features' list
(provide 'clean)

;;; clean-mode.el ends here
