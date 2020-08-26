(use-package projectile
  :ensure t
  :config
  (projectile-mode)
  (setq projectile-project-search-path '("~/Development"))
  (add-to-list 'projectile-globally-ignored-directories "node_modules"))

(provide 'init-projectile)
