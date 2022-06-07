(setq user-full-name "Jean-Baptiste Loutfalla"
      user-mail-address "jb.loutfalla@orange.fr")

(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")
                         ("org"   . "https://orgmode.org/elpa/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (auto-package-update-maybe))

(use-package auto-compile
  :ensure t
  :config
  (setq load-prefer-newer t)
  (auto-compile-on-load-mode))

(use-package color-theme-sanityinc-tomorrow
  :defer t
  :ensure t
  :config
  (color-theme-sanityinc-tomorrow-night))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq visible-bell t)

(setq local-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; (add-hook 'after-make-frame-functions
;;           (lambda (frame)
;;             (select-frame frame)
;;             (when (display-graphic-p frame)
;;               (global-hl-line-mode 1))))

(setq line-number-mode t)
(setq column-number-mode t)

(setq frame-resize-pixelwise t)

(defun colorize-with-ansi-sequences-buffer ()
  (ansi-color-apply-on-region compilation-filter-start (point)))
(add-hook 'compilation-filter-hook 'colorize-with-ansi-sequences-buffer)

(setq make-backup-files nil)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory)))

(setq vc-follow-symlinks t)

(global-auto-revert-mode t)

(defalias 'yes-or-no-p 'y-or-n-p)

(use-package async
  :ensure t
  :init
  (dired-async-mode 1))

(use-package pinentry
  :ensure t
  :config
  (setq epa-pinentry-mode 'loopback)
  (pinentry-start))

(defvar my-terminal-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-terminal-shell)))
(ad-activate 'ansi-term)

(global-set-key (kbd "<C-return>") 'ansi-term)

(use-package which-key
  :ensure t
  :diminish
  :config
  (which-key-mode))

(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode 1)

(setq ibuffer-use-other-window t)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(icomplete-mode 1)

(use-package smex
  :ensure t
  :init (smex-initialize)
  :bind ("M-x" . smex))

(setq flycheck-grammalecte-enabled-modes '(org-mode
                                           text-mode
                                           mail-mode
                                           latex-mode))

(setq flycheck-grammalecte-report-spellcheck nil)
(setq flycheck-grammalecte-report-apos nil)
(setq flycheck-grammalecte-report-nbsp nil)

(use-package flycheck-grammalecte
  :ensure t)

(defun edit-config ()
  "Edit/Open the config org file (`$XDG_CONFIG_HOME/emacs/README.org')"
  (interactive)
  (setq-local config-file
              (expand-file-name (concat (getenv "XDG_CONFIG_HOME")
                                        "/emacs/README.org")))
  (when (file-readable-p config-file)
    (find-file config-file)))

(global-set-key (kbd "C-c e") 'edit-config)

(defun config-reload ()
  "Reloads the emacs-lisp config file (`$XDG_CONFIG_HOME/emacs/config.el')"
  (interactive)
  (setq-local config-file
              (expand-file-name (concat (getenv "XDG_CONFIG_HOME")
                                        "/emacs/config.el")))
  (when (file-readable-p config-file)
    (load config-file)))

(global-set-key (kbd "C-c r") 'config-reload)

(setq electric-pair-pairs '((?\{ . ?\})
                            (?\( . ?\))
                            (?\[ . ?\])
                            (?\" . ?\")))
(electric-pair-mode t)

(use-package rainbow-mode
  :ensure t
  :hook (prog-mode)
  :diminish rainbow-mode)

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(show-paren-mode 1)

(use-package linum-relative
  :ensure t
  :hook (prog-mode . linum-relative-mode)
  :diminish
  :config
  (setq linum-relative-current-symbol "")
  (setq linum-relative-backend 'display-line-numbers-mode))

(global-subword-mode 1)

(use-package multiple-cursors
  :ensure t
  :bind (("C-!" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)))
(setq mc/always-run-for-all t)

(pending-delete-mode t)

(use-package expand-region
  :ensure t
  :bind ("C-q" . er/expand-region))

(setq tab-always-indent t)
(add-to-list 'completion-styles 'initials t)

(use-package popup-kill-ring
  :ensure t
  :bind ("M-y" . popup-kill-ring))

(use-package diminish
  :ensure t
  :config
  (diminish 'linum-relative-mode)
  (diminish 'subword-mode)
  (diminish 'auto-fill-mode)
  (diminish 'abbrev-mode)
  (diminish 'eldoc-mode))

(global-set-key (kbd "C-x ;") 'comment-line)

(use-package projectile
  :ensure t
  :bind-keymap ("C-c p" . projectile-command-map)
  :bind ("<f7>" . 'projectile-compile-project)
  :init
  (setq projectile-completion-system 'ido)
  :config
  ;; Directories to ignore
  (add-to-list 'projectile-globally-ignored-directories "build")

  ;; File suffixes to ignore
  (add-to-list 'projectile-globally-ignored-file-suffixes ".o")
  (add-to-list 'projectile-globally-ignored-file-suffixes ".d")
  (projectile-mode 1))

(defun cmake-dir-locals ()
  "Create a .dir-locals.el file at the root of the project which set cmake-ide-build-dir to `PROJECT_ROOT/build'"
  (interactive)
  (let ((s "((nil .
  ((eval . (setq-local cmake-ide-build-dir
              (concat (projectile-project-root)
                      \"build/\"))))))\n")
        (project-dir (projectile-project-root)))
    (if project-dir
        (with-temp-file (concat project-dir ".dir-locals.el") (insert s))
      (message "Not in a project..."))))

(defun start-dashboard ()
  "Starts dashboard
This definition is to be used with `emacs --daemon'"
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 5)
                          (projects . 5)))
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*"))))

(use-package dashboard
  :ensure t
  :after projectile
  :config
  (setq dashboard-startup-banner
        (concat (getenv "XDG_CONFIG_HOME") "/emacs/img/dashLogo.png")))

(start-dashboard)

(defun insert-gpl (description)
  "Insert the brief of the GNU GPLv3."
  (interactive "sShort description: ")
  (setq-local current-year (format-time-string "%Y"))
  (save-excursion
    (beginning-of-buffer)
    (insert
     (format
"/* %s

   Copyright (C) %s %s <%s>

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program. If not, see <http://www.gnu.org/licenses/>. */

" description current-year user-full-name user-mail-address))))

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

(use-package yasnippet
  :defer t
  :ensure t
  :after (yasnippet-snippets)
  :diminish yas-minor-mode
  :config
  (yas-global-mode))

(use-package yasnippet-snippets
  :ensure t)

(use-package flycheck
  :ensure t
  :after (rust-mode)
  :hook ((c-mode c++-mode shell-mode python-mode) . flycheck-mode)
  :diminish)

(use-package company
  :ensure t
  :hook ((emacs-lisp-mode shell-mode python-mode) . company-mode)
  :bind (("M-<tab>" . 'company-complete)
         :map company-active-map
         ("M-n" . nil)
         ("M-p" . nil)
         ("C-n" . 'company-select-next)
         ("C-p" . 'company-select-previous)
         ("SCP" . 'company-abort))
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  (setq company-backends '(company-cmake
                           company-c-headers
                           company-files
                           (company-clang :with company-yasnippet :separate)
                           (company-gtags company-rtags company-etags
                                          :with company-yasnippet :separate)
                           company-irony
                           (company-racer :with company-yasnippet :separate)
                           (company-shell company-shell-env
                                          :with company-yasnippet :separate)
                           (company-jedi :with company-yasnippet :separate)
                           (company-keywords :with company-dabbrev-code
                                             :with company-yasnippet :separate)
                           company-capf
                           company-dabbrev))
  (global-company-mode 1))

(use-package company-quickhelp
  :ensure t
  :config
  (company-quickhelp-mode))

;; (setq-default c-default-style "gnu"
;;               c-basic-offset 2)
(use-package format-all
  :ensure t
  :hook ((prog-mode . format-all-mode)
         (format-all-mode . format-all-ensure-formatter)))

(use-package dtrt-indent
  :ensure t
  :config
  (dtrt-indent-global-mode 1))

(setq-default display-fill-column-indicator-column 80)
(add-hook 'prog-mode-hook 'display-fill-column-indicator-mode)
(global-visual-line-mode)

(setq gdb-many-windows t)

(use-package cmake-mode
  :ensure t)

(use-package flycheck-clang-analyzer
  :ensure t
  :after (flycheck)
  :config
  (flycheck-clang-analyzer-setup))

(use-package rtags
    :ensure t)

(use-package ggtags
  :ensure t
  :hook ((c-mode c++-mode java-mode asm-mode) . ggtags-mode)
  :bind (:map ggtags-mode-map
              ("C-c g s" . ggtags-find-other-symbol)
              ("C-c g h" . ggtags-view-tag-history)
              ("C-c g r" . ggtags-find-reference)
              ("C-c g d" . ggtags-find-definition)
              ("C-c g f" . ggtags-find-file)
              ("C-c g c" . ggtags-create-tags)
              ("C-c g u" . ggtags-update-tags)
              ("C-c g g" . ggtags-grep)
              ("C-c g C-s" . ggtags-find-tag-regexp)
              ("C-c g M-%" . ggtags-query-replace)
              ("M-," . pop-tag-mark)))

(use-package company-c-headers
  :ensure t
  :config
  (setq company-c-headers-path-system
        (append (file-expand-wildcards "/usr/include/c++/*")
                company-c-headers-path-system))
  (setq company-c-headers-path-system
        (append (file-expand-wildcards "/usr/lib/gcc/x86_64-pc-linux-gnu/*/include")
                company-c-headers-path-system)))

(use-package company-rtags
  :ensure t
  :config
  (setq rtags-completions-enabled t))

(use-package company-irony
  :ensure t)

(use-package irony
  :ensure t
  :hook ((cide--mode . irony-mode)
         (irony-mode . irony-cdb-autosetup-compile-options)))

(use-package cmake-ide
  :ensure t)

;; (cmake-ide-setup)

(use-package glsl-mode
  :ensure t)

(use-package rust-mode
  :ensure t
  :bind (:map rust-mode-map
         ("<tab>" . #'company-indent-or-complete-common))
  :hook ((rust-mode) . (lambda () (setq indent-tabs-mode nil)))
  :config
  (setq rust-format-mode-on-save t)
  ;; (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
  (setq company-tooltip-align-annotations t))
  ;; (add-hook 'rust-mode-hook
  ;;           (lambda () (setq indent-tabs-mode nil))))

(setq rust-format-on-save t)

(use-package flycheck-rust
  :ensure t
  :after (flycheck rust-mode)
  :hook (((flycheck-mode) . flycheck-rust-setup)
         ((rust-mode) . flycheck-mode)))

(use-package cargo
  :ensure t
  :after (rust-mode)
  :hook (rust-mode . cargo-minor-mode))

(use-package racer
  :ensure t
  :hook ((rust-mode . racer-mode)
         (racer-mode . eldoc-mode)
         (racer-mode . company-mode)))

(use-package company-racer
  :ensure t)

(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)

(use-package slime
  :ensure t
  :defer t
  :init
  (setq inferior-lisp-program "sbcl")
  (setq slime-contribs '(slime-fancy slime-company)))

(use-package slime-company
  :ensure t
  :config
  (slime-setup))

(setq scheme-program-name "guile")

(use-package haskell-mode
  :ensure t
  :bind (:map haskell-mode-map
              ("C-c C-c" . haskell-compile)
              ("C-c C-l" . haskell-process-load-or-reload)
              ("C-`" . haskell-interactive-bring)
              ("C-c C-t" . haskell-process-do-type)
              ("C-c C-i" . haskell-process-do-info)
              ("C-c c" . haskell-process-cabal))
  :hook ((haskell-mode . interactive-haskell-mode)))
         ;; (haskell-mode . hindent-mode)))

(use-package hindent
  :ensure t
  :config
  (setq hindent-reformat-buffer-on-save t))

(use-package company-shell
  :ensure t)

(use-package company-jedi
  :ensure t
  :hook (python-mode . jedi:setup))

(use-package org-auto-tangle
  :ensure t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))

(defun add-pcomplete-to-capf ()
  (add-hook 'completion-at-point-functions 'pcomplete-completions-at-point nil t))

(add-hook 'org-mode-hook #'add-pcomplete-to-capf)

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)

(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)
(setq org-src-window-setup 'current-window)

(add-hook 'org-mode-hook 'org-indent-mode)
(add-hook 'org-mode-hook 'auto-fill-mode)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (shell . t)
   (python . t)))

(setq org-confirm-babel-evaluate nil)

(require 'ox-beamer)

(setq org-html-postamble nil)

(use-package htmlize
  :ensure t)

(use-package ox-twbs
  :ensure t)

(setq org-latex-pdf-process
      '("xelatex --shell-escape -interaction nonstopmode -output-directory %o %f"
        "xelatex --shell-escape -interaction nonstopmode -output-directory %o %f"
        "xelatex --shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex --shell-escape --batch %f"))

(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)

(setq TeX-parse-self t)

(setq TeX-PDF-mode t)
