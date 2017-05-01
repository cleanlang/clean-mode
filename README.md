# Clean Mode

This is a major mode for the Clean programming language at [Clean](https://github.com/geekskool/clean)

# Installation

1. Download `clean-mode`
2. Extract contents in your `.emacs.d` directory
3. Add the following to your init file

``` emacs-lisp
(add-to-list 'load-path "~/.emacs.d/clean-mode")
(load "clean-mode")
(add-to-list 'auto-mode-alist '("\\.cl\\'" . clean-mode))
```

## Current Features

 - Syntax Highlighting
 - Completion for keywords using `company`

# LICENSE

Check [LICENSE](LICENSE) file for license rights and limitations (GNU GPL v3)
