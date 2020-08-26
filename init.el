;-*-Emacs-Lisp-*-

(set-language-environment 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)

(package-initialize)

(require 'package)
(setq package-enable-at-startup nil)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(add-to-list 'custom-theme-load-path (expand-file-name "emacs-color-theme-solarized" (expand-file-name "themes" user-emacs-directory)))
(add-to-list 'exec-path "/usr/local/bin")

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(require 'init-config)
(require 'init-evil)
(require 'init-org)
(require 'init-dired)
(require 'init-projectile)
(require 'init-magit)
(require 'init-ac)
(require 'init-snippets)
(require 'init-flycheck)
(require 'init-helm)
(require 'init-w3m)
(require 'init-modes)
(require 'init-keys)

(load-theme 'solarized t)
