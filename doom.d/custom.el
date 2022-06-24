(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(conda-anaconda-home "/home/hx/anaconda3")
 '(package-selected-packages '(conda lsp-pyright jedi company-jedi)))
 
(custom-set-faces)
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.

(use-package lsp
  :hook
  ((python-mode . lsp))
  :init
  (setq lsp-modeline-diagnostics-scope :workspace)
  (setq lsp-enable-file-watchers nil)
  (setq lsp-file-watch-threshold 10))
  


(use-package lsp-pyright
  :ensure t
  :config
  (setq lsp-pyright-python-path "/home/hx/anaconda3/bin/python3")
  (setq lsp-pyright-auto-search-paths t)
  (setq lsp-pyright-use-library-code-for-types t)
  ;;(setq lsp-pyright-stub-path (concat (getenv "HOME") "/src/mypy/stubs"))
  (setq lsp-pyright-stub-path (concat (getenv "HOME") "/anaconda3/lib/python3.9/site-packages/mypy/typeshed/stubs"))
  (setq lsp-pyright-open-files-only t)
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred

