;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-molokai)

;; Set Fonts
(setq doom-font (font-spec :family "Mononoki" :size 18 :weight 'Regular)
      doom-variable-pitch-font (font-spec :family "Ubuntu" :size 16 :weight 'Regular))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; LSP Configuration
(use-package lsp
  :init
  (setq lsp-modeline-diagnostics-scope :workspace)
  (setq lsp-enable-file-watchers nil)
  (setq lsp-file-watch-threshold 10))

;; Python (pyright and anaconda)
(use-package lsp-pyright
  :ensure t
  :config
  (setq lsp-pyright-python-path (concat (getenv "HOME") "/anaconda3/bin/python3"))
  (setq lsp-pyright-auto-search-paths t)
  (setq lsp-pyright-use-library-code-for-types t)
  (setq lsp-pyright-stub-path (concat (getenv "HOME") "/anaconda3/lib/python3.9/site-packages/mypy/typeshed/stubs"))
  (setq lsp-pyright-open-files-only t)
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))

;; Auto Tangle Mode (For org files)
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

;; typescript and javascript
(use-package typescript-mode
  :mode "//.ts//'"
  :hook (typescript-mode . lsp)
  :config
  (setq typescript-indent-level 2))

;; Rust
(use-package rustic
  :ensure t
  :mode "//.rs//'"
  :config
  (setq lsp-rust-server 'rust-analyzer)
  :hook (rustic . lsp))

;; Haskell
(use-package haskell-mode
 :ensure t
 :mode "//.hs//'"
 :hook (haskell-mode . (lambda ()
                    (require 'lsp-haskell)
                    (lsp))))

;; Custom PATH
(setenv "PATH" (concat (getenv "PATH") ":~/.ghcup/bin"))
(setq exec-path (append exec-path '("~/.ghcup/bin")))

(setenv "PATH" (concat (getenv "PATH") ":~/.cargo/bin"))
(setq exec-path (append exec-path '("~/.cargo/bin")))
