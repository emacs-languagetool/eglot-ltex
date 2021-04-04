;;; eglot-ltex.el --- Eglot Clients for LanguageTool  -*- lexical-binding: t; -*-

;; Copyright (C) 2021  Shen, Jen-Chieh
;; Created date 2021-04-03 00:40:51

;; Author: Shen, Jen-Chieh <jcs090218@gmail.com>
;; Description: Eglot Clients for LanguageTool.
;; Keyword: eglot languagetool checker
;; Version: 0.1.0
;; Package-Requires: ((emacs "24.3") (eglot "1.4"))
;; URL: https://github.com/emacs-languagetool/eglot-ltex

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
;;
;;

;;; Code:

(require 'eglot)

(defgroup eglot-ltex nil
  "Settings for the LTEX Language Server.

https://github.com/valentjn/ltex-ls"
  :prefix "eglot-ltex-"
  :group 'eglot
  :link '(url-link :tag "Github" "https://github.com/emacs-languagetool/eglot-ltex"))

(defcustom eglot-languagetool-active-modes '(text-mode latex-mode org-mode markdown-mode)
  "List of major mode that work with LanguageTool."
  :type 'list
  :group 'eglot-grammarly)

(defcustom eglot-languagetool-server-path ""
  "The root path of the LTEX language server's folder."
  :type 'string
  :group 'eglot)

(defun eglot-ltex--server-entry ()
  "Return the server entry file.

This file is use to activate the language server."
  (f-join eglot-languagetool-server-path "bin" (if (eq system-type 'windows-nt)
                                                   "ltex-ls.bat"
                                                 "ltex-ls")))

(defun eglot-languagetool--server-command ()
  "Generate startup command for LTEX language server."
  (list (eglot-ltex--server-entry)))

(add-to-list 'eglot-server-programs
             `(,eglot-languagetool-active-modes . ,(eglot-languagetool--server-command)))

(provide 'eglot-ltex)
;;; eglot-ltex.el ends here
