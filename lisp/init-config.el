;;; init-config.el --- Initial config setqs for emacs

;; Copyright (C) 2011 Free Software Foundation, Inc.

;; Author: A.V. Kovardakov <alexey.kovardakov@gmail.com>

;;; Commentary:

;; This package provides initial config I use for everyday
;; work in Emacs.

;;; Code:

;; Open simple scratch buffer on startup
(setq inhibit-splash-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t)

;; Disable menubar and toolbar
(menu-bar-mode -1)
(tool-bar-mode -1)


(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(show-paren-mode 1)
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
(setq tramp-default-method "ssh")
(setq tramp-syntax 'simplified)
(global-display-line-numbers-mode)
(add-hook 'display-line-numbers-mode-hook
          (lambda () (setq display-line-numbers 'relative)))

(defvar backup-dir (expand-file-name "backups" user-emacs-directory))
(setq backup-directory-alist (list (cons "." backup-dir)))
(setq make-backup-files nil)
(setq auto-save-list-file-prefix backup-dir)
(setq auto-save-file-name-transforms `((".*" ,backup-dir t)))

(add-to-list 'default-frame-alist '(height . 50))
(add-to-list 'default-frame-alist '(width . 160))
(add-to-list 'default-frame-alist '(font . "Menlo-14"))

(provide 'init-config)
;;; init-config.el ends here
