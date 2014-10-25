(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.org/packages/") t)

; evil mode
(add-to-list 'load-path "~/.emacs.d/evil/")
(require 'evil)
(evil-mode 1)

(add-to-list 'load-path "~/.emacs.d/emacs-flymake/")
(require 'flymake)

; autocomplete with company
(add-hook 'after-init-hook 'global-company-mode)

; ====================================================================
; go mode
; ====================================================================
(add-to-list 'load-path "~/.emacs.d/go-mode.el/")
(require 'go-mode-load)

(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))
(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd "C-c i") 'go-goto-imports)))
(add-hook 'go-mode-hook (lambda ()
                          (local-set-key (kbd \"M-.\") 'godef-jump)))

; gocode autocomplete
(add-to-list 'load-path "~/.emacs.d/company-go/")
(require 'company)
(require 'company-go)

(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
(setq company-echo-delay 0)                          ; remove annoying blinking
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

(add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))

; go flymake
(add-to-list 'load-path "~/.emacs.d/goflymake")
(require 'go-flymake)

; (add-to-list 'load-path "~/.emacs.d/goflymake")
; (require 'go-flycheck)
