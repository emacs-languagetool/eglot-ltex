;;; eglot-ltex.el --- Eglot Clients for LTEX  -*- lexical-binding: t; -*-

;; Copyright (C) 2021-2025  Shen, Jen-Chieh
;; Created date 2021-04-03 00:40:51

;; Author: Shen, Jen-Chieh <jcs090218@gmail.com>
;; URL: https://github.com/emacs-languagetool/eglot-ltex
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1") (eglot "1.4") (f "0.20.0"))
;; Keywords: convenience eglot languagetool checker

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Eglot Clients for LTEX.
;;

;;; Code:

(require 'cl-lib)

(require 'eglot)
(require 'f)

(defgroup eglot-ltex nil
  "Settings for the LTEX Language Server.

https://github.com/valentjn/ltex-ls"
  :prefix "eglot-ltex-"
  :group 'eglot
  :link '(url-link :tag "Github" "https://github.com/emacs-languagetool/eglot-ltex"))

(defcustom eglot-ltex-active-modes
  ;; Language ids can be found here:
  ;; https://github.com/valentjn/ltex-ls/blob/7c031d792110a824951aa003acd3ada158a515b4/src/main/kotlin/org/bsplines/ltexls/parsing/CodeFragmentizer.kt#L46
  '((org-mode :language-id "org")
    ;; Hack for version >=16 of ltex-ls with git commit support. For
    ;; earlier versions it should just fall back to plaintext. This
    ;; requires setting git-commit-major-mode to
    ;; 'git-commit-elisp-text-mode. This is a hack because
    ;; git-commit-elisp-text-mode isn't a general purpose git commit
    ;; major mode, but it does the job
    (git-commit-elisp-text-mode :language-id "gitcommit")
    (bibtex-mode :language-id "bibtex")
    (context-mode :language-id "context")
    (latex-mode :language-id "latex")
    (LaTeX-mode :language-id "latex") ;; AUCTeX
    (markdown-mode :language-id "markdown")
    (rst-mode :language-id "restructuredtext")
    (mu4e-compose-mode :language-id "plaintext")
    (text-mode :language-id "plaintext"))
  "List of major mode that work with LanguageTool."
  :type '(list symbol)
  :group 'eglot-ltex)

(defcustom eglot-ltex-server-path ""
  "The root path of the LTEX language server's folder, or path to the executable."
  :type 'string
  :group 'eglot-ltex)

(defcustom eglot-ltex-communication-channel 'stdio
  "Type of the communication channel."
  :type '(choice (const :tag "Standard IO" stdio)
                 (const :tag "TCP/socket" tcp))
  :group 'eglot-ltex)

(defun eglot-ltex--server-entry ()
  "Return the server entry file.

This file is use to activate the language server."
  (let ((program-basename (if (eq system-type 'windows-nt)
                              "ltex-ls.bat"
                            "ltex-ls")))
    (pcase eglot-ltex-server-path
      ((pred f-file?) eglot-ltex-server-path)
      ((pred f-dir?) (f-join eglot-ltex-server-path "bin" program-basename))
      ("" (executable-find program-basename))
      (_ (user-error "eglot-ltex-server-path is invalid or points to a nonexistant file: %s" eglot-ltex-server-path)))))

(defun eglot-ltex--server-program (_interactive _project)
  (pcase eglot-ltex-communication-channel
    ('stdio `(,(eglot-ltex--server-entry)))
    ('tcp `(,(eglot-ltex--server-entry) "--server-type" "TcpSocket" "--port" :autoport))
    (_ (user-error "Invalid communication channel type: %s" eglot-ltex-communication-channel))))

(add-to-list 'eglot-server-programs
             `(,eglot-ltex-active-modes . eglot-ltex--server-program))

(provide 'eglot-ltex)
;;; eglot-ltex.el ends here
