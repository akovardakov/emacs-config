(use-package ledger-mode
  :ensure t
  )

(use-package undo-tree
  :ensure t
  :diminish t
  :config
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-history-directory-alist
        (list (cons "." (expand-file-name "undo-tree-history" user-emacs-directory)))))

(use-package elpy
  :ensure t
  :init
  (elpy-enable)
  :config
  (setq python-python-command "/usr/local/opt/python@3.8/bin/python3")
  )

(use-package cython-mode
  :ensure t)

(use-package dockerfile-mode
  :ensure t)

(use-package docker-compose-mode
  :ensure t)

(provide 'init-modes)

(use-package typescript-mode
  :ensure t
  :mode (("\\.tsx?$" . typescript-mode))
  :init
  (setq-default tab-width 2)
  (setq-default typescript-indent-level 2)
)
