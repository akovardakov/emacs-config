(use-package auto-complete
  :ensure t
  :config
  (ac-config-default)
  (setq ac_modes (delete 'python-mode ac-modes))
  (define-key ac-mode-map (kbd "C-n") 'ac-next)
  (define-key ac-mode-map (kbd "C-p") 'ac-previous))

(provide 'init-ac)
