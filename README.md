[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![JCS-ELPA](https://raw.githubusercontent.com/jcs-emacs/badges/master/elpa/v/eglot-ltex.svg)](https://jcs-emacs.github.io/jcs-elpa/#/eglot-ltex)

<img align="right" src="./etc/logo.png" with="115" height="55">

# eglot-ltex

[![CI](https://github.com/emacs-languagetool/eglot-ltex/actions/workflows/test.yml/badge.svg)](https://github.com/emacs-languagetool/eglot-ltex/actions/workflows/test.yml)

`eglot` client leveraging [LTEX Language Server](https://github.com/valentjn/ltex-ls).

## :floppy_disk: Quickstart

### :mag: Step 1. Install `LTEX` language server through LTEX's homepage
> Link https://github.com/valentjn/ltex-ls

Extract the `.tar.gz` file to any location you want.

### :mag: Step 2. Configure your Emacs configuration

Consider adding this to your configuration.

```el
(use-package eglot-ltex
  :ensure t
  :hook (text-mode . (lambda ()
                       (require 'eglot-ltex)
                       (call-interactively #'eglot)))
  :init
  (setq eglot-languagetool-server-path "path/to/ltex-ls-XX.X.X/"))
```

## :wrench: Configuration

Create `.dir-locals.el` file in the the project root directory.

```el
((nil
  (eglot-workspace-configuration
   . ((ltex-ls . ((language . "en-US")))))))
```

*P.S. See all possible configuration [here](https://valentjn.github.io/vscode-ltex/docs/settings.html).*

## Contribute

[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)
[![Elisp styleguide](https://img.shields.io/badge/elisp-style%20guide-purple)](https://github.com/bbatsov/emacs-lisp-style-guide)

If you would like to contribute to this project, you may either
clone and make pull requests to this repository. Or you can
clone the project and establish your own branch of this tool.
Any methods are welcome!
