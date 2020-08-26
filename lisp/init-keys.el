(add-hook 'org-agenda-mode-hook
          (lambda () 
            (local-set-key (kbd "j") 'org-agenda-next-item)
            (local-set-key (kbd "k") 'org-agenda-previous-item)
            ))

(define-key org-mode-map (kbd "M-h") 'org-metaleft)
(define-key org-mode-map (kbd "M-j") 'org-metadown)
(define-key org-mode-map (kbd "M-k") 'org-metaup)
(define-key org-mode-map (kbd "M-l") 'org-metaright)
(define-key org-mode-map (kbd "M-H") 'org-shiftmetaleft)
(define-key org-mode-map (kbd "M-J") 'org-shiftmetadown)
(define-key org-mode-map (kbd "M-K") 'org-shiftmetaup)
(define-key org-mode-map (kbd "M-L") 'org-shiftmetaright)

(provide 'init-keys)
