(use-package org
  :ensure t
  :defer t
  :bind (("C-c c" . org-capture)
         ("C-c a" . org-agenda))
  :config
  (setq org-todo-keywords '(
          (sequence "TODO" "|" "DONE(!)")
          ))

  (setq org-capture-templates
        `(("t" "Todo" entry (file "inbox.org")
           ,(concat "* TODO %?\n"
                    ":PROPERTIES:\n"
                    ":ORDERED: t\n"
                    ":CREATED: %u\n"
                    ":END:\n")
           :empty-lines 1)
          ("n" "Note" entry (file "notes.org")
           "* %?\nEntered on %U\n  %i\n  %a")
          )
        )

  (setq org-default-notes-file (expand-file-name "inbox.org" org-directory))
  (setq org-log-done 'time)
  (setq org-log-redeadline (quote time))
  (setq org-log-reschedule (quote time))
  (setq org-log-into-drawer (quote time))
  (setq org-agenda-files (list org-directory))
  (setq org-enforce-todo-dependencies t)
  (require 'ox-md)
)


(provide 'init-org)
