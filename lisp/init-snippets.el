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

(provide 'init-snippets)
