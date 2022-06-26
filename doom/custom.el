(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(conda-anaconda-home "/home/hx/anaconda3")
 '(package-selected-packages
   '(evil-tutor python-mode lsp-jedi conda lsp-pyright jedi company-jedi)))
 
(custom-set-faces)
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 
;; lsp config
(use-package lsp
  :init
  (setq lsp-modeline-diagnostics-scope :workspace)
  (setq lsp-enable-file-watchers nil)
  (setq lsp-file-watch-threshold 10))

;; typescript and javascript config
(use-package typescript-mode
  :mode "//.ts//'" 
  :hook (typescript-mode . lsp)
  :config
  (setq typescript-indent-level 2))

;; lsp-pyright config
(use-package lsp-pyright
  :ensure t
  :config
  (setq lsp-pyright-python-path "/home/hx/anaconda3/bin/python3")
  (setq lsp-pyright-auto-search-paths t)
  (setq lsp-pyright-use-library-code-for-types t)
  (setq lsp-pyright-stub-path (concat (getenv "HOME") "/anaconda3/lib/python3.9/site-packages/mypy/typeshed/stubs"))
  (setq lsp-pyright-open-files-only t)
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred

;; Rust Setup
(use-package rustic
  :ensure t
  :mode "//.rs//'"
  :config
  (setq lsp-rust-server 'rust-analyzer)
  :hook (rustic . lsp))

;; Auto Tangle Mode
(use-package org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))


;; HTML
(use-package web-mode
  :ensure t
  :config
  (setq lsp-html-auto-closing-tags t)
  (setq lsp-html-format-enable t)
  (setq web-mode-enable-css-colorization t)
  :hook (web-mode . (lambda ()
                      (require 'lsp-css)
                      (require 'lsp-html)
                      (lsp))))

;; CSS Mode
(use-package css-mode
 :ensure t
 :mode "//.css//'"
 :hook (css-mode . (lambda ()
                    (require 'lsp-css)
                    (lsp))))

;; SHELL
(use-package sh-mode
  :ensure t
  :mode "//.sh//'"
  :hook (sh-mode . (lambda()
                     (require 'lsp-bash)
                     (lsp))))
