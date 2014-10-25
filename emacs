;; -*- mode: emacs-lisp -*-
(setq warning-suppress-types nil)
(setq debug-on-error t)
(setq package-enable-at-startup nil)

(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

;;;; Load paths
(add-to-list 'load-path "~/.emacs.d/elisp/company-go/")
(add-to-list 'load-path "~/.emacs.d/elisp/emacs-flymake/")
(add-to-list 'load-path "~/.emacs.d/elisp/emacs-go-eldoc/")
(add-to-list 'load-path "~/.emacs.d/elisp/evil/")
(add-to-list 'load-path "~/.emacs.d/elisp/go-errcheck/")
(add-to-list 'load-path "~/.emacs.d/elisp/go-mode/")
(add-to-list 'load-path "~/.emacs.d/elisp/goflymake/")

;;;; requires 
(require 'evil)
(require 'flymake)
(require 'company)
; go
(require 'company-go)
(require 'go-flymake)
;(require 'go-flycheck)
(require 'go-eldoc)

; ===================================================================
; general
; ===================================================================

; evil mode
(evil-mode 1)

; autocomplete with company
(add-hook 'after-init-hook 'global-company-mode)
(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
(setq company-echo-delay 0)                          ; remove annoying blinking
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

; ====================================================================
; go mode
; ====================================================================

(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))
(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd "C-c i") 'go-goto-imports)))
(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd "M-.") 'godef-jump)))
(add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))
(add-hook 'go-mode-hook 'go-eldoc-setup)
