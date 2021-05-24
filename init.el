;;; package --- Summary -*- mode: Lisp;-*-
;;; Commentary:
;;; Code:

(set-language-environment 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)

(require 'package)

(setq package-enable-at-startup nil)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(add-to-list 'custom-theme-load-path (expand-file-name "emacs-color-theme-solarized" (expand-file-name "themes" user-emacs-directory)))
(add-to-list 'exec-path "/usr/local/bin")

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;; Initially install use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

;; Open simple scratch buffer on startup
(setq inhibit-splash-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t)

;; Disable menubar and toolbar
(menu-bar-mode -1)
(tool-bar-mode -1)

;; Display matching parenthesis
(show-paren-mode 1)

;; Disable scroll-bars
(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; Settings for text cropping
(setq-default truncate-lines t)
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
(setq-default left-fringe-width nil)
(setq-default indicate-empty-lines t)
(setq-default indent-tabs-mode nil)

(setq vc-follow-symlinks t)
(setq large-file-warning-threshold nil)
(setq split-width-threshold nil)
(column-number-mode t)
(setq tab-width 4)

(global-display-line-numbers-mode)
(add-hook 'display-line-numbers-mode-hook
          (lambda () (setq display-line-numbers 'relative)))

(defvar ak-emacs-cache-dir (expand-file-name "emacs" (getenv "XDG_CACHE_HOME")))

(setq backup-directory-alist (list (cons "." (expand-file-name "backups" ak-emacs-cache-dir))))
(setq make-backup-files t)
(setq backup-by-copying t)

(add-to-list 'default-frame-alist '(height . 50))
(add-to-list 'default-frame-alist '(width . 160))
(add-to-list 'default-frame-alist '(font . "Menlo-14"))

;; Init EVIL
(defun ak--config-evil ()
  "Configure evil mode."

  (dolist (mode '(ag-mode
                  custom-mode
                  custom-new-theme-mode
                  dired-mode
                  git-rebase-mode
                  org-capture-mode))
    (add-to-list 'evil-emacs-state-modes mode))
  (evil-add-hjkl-bindings occur-mode-map 'emacs
    (kbd "/")       'evil-search-forward
    (kbd "n")       'evil-search-next
    (kbd "N")       'evil-search-previous
    (kbd "C-w C-w") 'other-window)

  (evil-define-key 'normal elpy-mode-map (kbd "M-.")   'elpy-goto-definition)
  (evil-define-key 'normal global-map    (kbd "C-x g") 'magit-status)
  (evil-define-key 'normal global-map    (kbd "C-e")   'end-of-line)
  (evil-define-key 'normal global-map    (kbd "C-n")   'evil-scroll-line-down)
  (evil-define-key 'normal global-map    (kbd "C-p")   'evil-scroll-line-up))

(use-package evil
  :ensure t
  :config
  (add-hook 'evil-mode-hook 'ak--config-evil)
  (evil-mode 1)
  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode)))

(use-package org
  :ensure t
  :defer t
  :bind (("C-c c" . org-capture)
         ("C-c a" . org-agenda))
  :config
  (setq org-default-notes-file (expand-file-name "inbox.org" org-directory))
  (setq org-directory-nda (expand-file-name "nda" org-directory))
  (setq org-agenda-files (list org-directory org-directory-nda))
  (setq org-refile-targets '((org-agenda-files :maxlevel . 3)))
  (setq org-refile-use-outline-path 'file)
  (setq org-outline-path-complete-in-steps nil)
  (setq org-enforce-todo-dependencies t)
  (setq org-capture-templates
        `(
          ("c" "Code Note")
          ("cc" "Code Note" entry (file ,(expand-file-name "codenotes.org" org-directory))
           "* %?\n  %a\n")
          ("cn" "Code Note NDA" entry (file ,(expand-file-name "codenotes.org" org-directory-nda))
           "* %?\n  %a"
           :empty-lines 1)
          ("t" "Todo")
          ("tt" "Todo" entry (file ,(expand-file-name "inbox.org" org-directory))
           "* TODO %?\n  %t\n")
          ("tn" "Todo NDA" entry (file ,(expand-file-name "inbox.org" org-directory-nda))
           "* TODO %?\n  %t\n")))
  (add-to-list 'org-latex-packages-alist
               '("AUTO" "babel" t ("pdflatex")))
)

(use-package projectile
  :ensure t
  :config
  (projectile-mode)
  (setq projectile-project-search-path '("~/Work"))
  (setq projectile-enable-caching t)
  (add-to-list 'projectile-globally-ignored-directories "node_modules"))

(use-package magit
  :ensure t
  :defer t
  :config
  (setq magit-branch-arguments nil)
  (setq magit-push-always-verify nil))

(use-package auto-complete
  :ensure t
  :config
  (ac-config-default)
  (setq ac_modes (delete 'python-mode ac-modes))
  (define-key ac-mode-map (kbd "C-n") 'ac-next)
  (define-key ac-mode-map (kbd "C-p") 'ac-previous))

(use-package yasnippet
  :ensure t
  :config
  (yas-reload-all)
  (add-to-list 'yas-snippet-dirs (expand-file-name "snippets" user-emacs-directory))
  (setq tab-always-indent 'complete)
  (setq yas-prompt-funcitons '(yas-completing-prompt
                               yas-ido-prompt
                               yas-dropdown-prompt))
  (define-key yas-minor-mode-map (kbd "<escape>") 'yas-exit-snippet)
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :ensure t)

(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-flycheck-mode)
  (add-hook 'flycheck-mode-hook
            (lambda ()
              (evil-define-key 'normal flycheck-mode-map (kbd "]e") 'flycheck-next-error)
              (evil-define-key 'normal flycheck-mode-map (kbd "[e") 'flycheck-previous-error))))

(use-package helm
  :ensure t
  :diminish helm-mode
  :config
  (helm-mode 1)
  (setq helm-buffers-fuzzy-matching t)
  (setq helm-autoresize-mode t)
  (setq helm-buffer-max-length 40)
  (define-key helm-find-files-map (kbd "C-k") 'helm-find-files-up-one-level)
  (define-key helm-read-file-map (kbd "C-k") 'helm-find-files-up-one-level)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "C-x C-f") 'helm-find-files))

(use-package helm-org
  :ensure t)

(use-package helm-projectile
  :ensure t
  :config
  (helm-projectile-on)
  (global-unset-key (kbd "s-p"))
  (global-set-key (kbd "s-p p") 'helm-projectile-switch-project)
  (global-set-key (kbd "s-p f") 'helm-projectile))

(require 'helm-config)

(use-package undo-tree
  :ensure t
  :diminish t
  :config
  (setq undo-tree-auto-save-history t)
  (global-undo-tree-mode)
  (evil-set-undo-system 'undo-tree)
  (setq undo-tree-history-directory-alist
        (list (cons "." (expand-file-name "undo-tree-history" user-emacs-directory)))))

(use-package elpy
  :ensure t
  :init
  (setq python-shell-interpreter "/usr/local/bin/python3")
  (elpy-enable)
  :config
  (add-hook 'elpy-mode-hook 'hs-minor-mode)
  (setq elpy-rpc-python-command "/usr/local/bin/python3"))

(use-package yaml-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))
  (setq yaml-indent-offset 4))
  
(add-hook 'org-agenda-mode-hook
          (lambda () 
            (local-set-key (kbd "j") 'org-agenda-next-item)
            (local-set-key (kbd "k") 'org-agenda-previous-item)
            ))

(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))

(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
  (add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
  (flycheck-add-mode 'typescript-tslint 'web-mode))

(use-package ledger-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.ledger\\'" . ledger-mode))
  (add-hook 'ledger-mode-hook 'auto-complete-mode))

(define-key org-mode-map (kbd "M-h") 'org-metaleft)
(define-key org-mode-map (kbd "M-j") 'org-metadown)
(define-key org-mode-map (kbd "M-k") 'org-metaup)
(define-key org-mode-map (kbd "M-l") 'org-metaright)
(define-key org-mode-map (kbd "M-H") 'org-shiftmetaleft)
(define-key org-mode-map (kbd "M-J") 'org-shiftmetadown)
(define-key org-mode-map (kbd "M-K") 'org-shiftmetaup)
(define-key org-mode-map (kbd "M-L") 'org-shiftmetaright)

(add-hook 'js-mode-hook 'hs-minor-mode)

(load-theme 'solarized t)

(setq scroll-conservatively 200)
(setq scroll-margin 1)

(setq js-indent-level 2)

(add-to-list 'auto-mode-alist '("\\.psql\\'" . sql-mode))
