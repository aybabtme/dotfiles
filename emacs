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
(add-to-list 'load-path "~/.emacs.d/elisp/yasnippet")

;;;; requires 
(require 'evil)
(require 'flymake)
(require 'company)
(require 'yasnippet)
(require 'multiple-cursors)
; go
(require 'company-go)
(require 'go-eldoc)
(require 'go-flymake)
;(require 'go-flycheck)

; ===================================================================
; general
; ===================================================================

; evil mode
(evil-mode 1)

; yas snippets
(add-to-list 'yas-snippet-dirs "~/.emacs.d/elisp/yasnippet-go")
(yas-global-mode 1)

; autocomplete with company
(add-hook 'after-init-hook 'global-company-mode)
(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-idle-delay .1)                         ; decrease delay before autocompletion popup shows
;(setq company-echo-delay 0)                          ; remove annoying blinking
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

; multicursors
(setq mc/cmds-to-run-for-all
      '(
        evil-append-line
        evil-backward-WORD-begin
        evil-backward-word-begin
        evil-delete-char
        evil-delete-line
        evil-digit-argument-or-evil-beginning-of-line
        evil-emacs-state
        evil-end-of-line
        evil-force-normal-state
        evil-forward-WORD-begin
        evil-forward-WORD-end
        evil-forward-word-begin
        evil-forward-word-end
        evil-insert
        evil-next-line
        evil-normal-state
        evil-previous-line
        ))

; ====================================================================
; keybindings
; ====================================================================

(setq mac-command-modifier 'hyper)
(global-set-key (kbd "M-s") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c M-s") 'mc/mark-all-like-this)

; ====================================================================
; go mode
; ====================================================================

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

(load "server")
(unless (server-running-p) (server-start))
