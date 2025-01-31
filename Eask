(package "eglot-ltex"
         "0.1.0"
         "Eglot Clients for LTEX")

(website-url "https://github.com/emacs-languagetool/eglot-ltex")
(keywords "convenience" "eglot" "languagetool" "checker")

(package-file "eglot-ltex.el")

(script "test" "echo \"Error: no test specified\" && exit 1")

(source "gnu")
(source "melpa")

(depends-on "emacs" "24.3")
(depends-on "eglot")
(depends-on "f")

(setq network-security-level 'low)  ; see https://github.com/jcs090218/setup-emacs-windows/issues/156#issuecomment-932956432

(add-hook 'eask-before-compile-hook
           (lambda ()
             ;;(setq byte-compile-error-on-warn t)
             (setq byte-compile-docstring-max-column 1000)))
