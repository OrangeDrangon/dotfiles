;; .emacs.d/init.el

;; ===================================
;; Basic Customization
;; ===================================

;; Disable Startup Message
(setq inhibit-startup-message t)

;; Disable the bars
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Line highlight and numbers
(global-display-line-numbers-mode)
(line-number-mode t)

;; Set default font
(set-face-attribute 'default nil
                    :family "Fira Code"
                    :height 120
                    :weight 'normal
                    :width 'normal)

;; Increase GC Threshold
(setq gc-cons-threshold (* 100 1000 1000)) ;; 100mb

;; Increase data emacs reads from processes
;; (setq read-process-output-max (* 1024 1024)) ;; 1mb
;; It claims this setting is not a thing :(

;; Enable Spell Check

(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))

;; ===================================
;; MELPA Package Support
;; ===================================

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(use-package flycheck
  :ensure t
  :hook (prog-mode . flycheck-mode))

(use-package company
  :ensure t
  :hook (prog-mode . company-mode)
  :hook (tex-mode . company-mode)
  :config
  (setq company-idle-delay 0.0 company-minimum-prefix-length 1))

(use-package company-math
  :ensure t
  :after company
  :config
  (setq-local company-backends
              (append '((company-math-symbols-latex company-latex-commands))
                      company-backends)))
(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

(use-package treemacs
  :ensure t
  :defer t
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-magit
  :after treemacs magit
  :ensure t)

(use-package smartparens
  :ensure t
  :hook (prog-mode . smartparens-mode)
  :config (use-package smartparens-config))

(use-package fira-code-mode
  :ensure t
  :custom (fira-code-mode-disabled-ligatures '("[]" "#{" "#(" "#_" "#_(" "x"))
  :hook prog-mode)

(use-package toml-mode
  :ensure t)

(use-package rust-mode
  :ensure t)

(use-package cmake-mode
  :ensure t)

(use-package lsp-python-ms
  :ensure t
  :init (setq lsp-python-ms-auto-install-server t)
  :hook (python-mode . (lambda ()
                         (require 'lsp-python-ms)
                         (lsp-deferred))))  ; or lsp-deferred

(use-package lsp-mode
  :ensure t
  :hook ((prog-mode . lsp-deferred)
         (tex-mode . lsp-deferred)
	 (toml-mode . lsp-deferred))
  :commands (lsp lsp-deferred))

(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :commands lsp-ui-mode)

(use-package lsp-treemacs
  :after treemacs lsp-mode
  :ensure t
  :commands lsp-treemacs-errors-list)

(use-package wc-mode
  :ensure t)

(use-package yasnippet
  :ensure t
  :config (yas-global-mode 1))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doc-view-continuous t)
 '(package-selected-packages
   '(lsp-python-ms cmake-mode yasnippet wc-mode use-package treemacs-magit toml-mode smartparens lsp-ui lsp-treemacs flycheck fira-code-mode company-math cargo)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
