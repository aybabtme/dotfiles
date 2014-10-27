;; -*- mode: emacs-lisp -*-
(setq warning-suppress-types nil)
(setq package-enable-at-startup nil)

(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

;;;; Load paths
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
(require 'yasnippet)
(require 'multiple-cursors)
(require 'auto-complete-config)
(require 'auto-complete)

; go
(require 'go-eldoc)
(require 'go-flymake)
(require 'go-autocomplete)
(require 'go-flycheck)
(require 'golint)

; ===================================================================
; general
; ===================================================================

;disable backup
(setq backup-inhibited t)
;disable auto save
(setq auto-save-default nil)

; evil mode
(evil-mode 0)

; helm mode
(helm-mode 1)

; yas snippets
(add-to-list 'yas-snippet-dirs "~/.emacs.d/elisp/yasnippet-go")
(yas-global-mode 1)

; autocomplete
(ac-config-default)
(auto-complete-mode 1)

; multicursors
(setq mc/cmds-to-run-for-all
      '(
        evil-append-line
        evil-backward-WORD-begin
        evil-backward-word-begin
        evil-delete-char
        evil-delete-lineOA
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

(defun go-mode-setup ()
  (setq compile-command "go build -v && go test -v && go vet")
  (define-key (current-local-map) "\C-c\C-c" 'compile)
  (go-eldoc-setup)
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook 'go-mode-setup)

(load "server")
(unless (server-running-p) (server-start))
