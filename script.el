#!/usr/bin/emacs --script

;; The subdirectory ~/.emacs.d is to be added to the top-level elisp
;; file search.
;(progn (cd "~/.emacs.d") (normal-top-level-add-subdirs-to-load-path))

;; Org-Mode, Org-Babel, and the tangle library are required, if we are
;; to proceed further.
(require 'org-install)
(require 'org)
(require 'ob-tangle)

;; Load the main configuration and setup file.
(require 'ob-ruby)
(require 'ob-python)
(require 'ob-emacs-lisp)
(require 'ob-lisp)

;; Tangle all files given.
(dolist (file command-line-args-left)
   (princ file)
    (org-babel-tangle-file file))
