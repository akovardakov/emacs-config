(use-package dired
  :config
  (require 'dired-x)
  (setq dired-omit-files "^\\.?#\\|^\\.[^.].*")
  (add-hook 'dired-mode-hook(lambda () (dired-omit-mode t)))
  (put 'dired-find-alternate-file 'disabled nil)
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
  (define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))
  (define-key dired-mode-map (kbd "C-.") 'dired-omit-mode)
  (define-key dired-mode-map (kbd "c") 'find-file)
  (define-key dired-mode-map (kbd "?") 'evil-search-backward)
  (define-key dired-mode-map (kbd "C-c C-c") 'dired-toggle-read-only))

(eval-after-load 'wdired
  (add-hook 'wdired-mode-hook 'evil-normal-state))

(provide 'init-dired)
