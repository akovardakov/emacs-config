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

(provide 'init-evil)
