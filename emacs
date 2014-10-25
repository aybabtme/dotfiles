(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.org/packages/") t)

; evil mode
(add-to-list 'load-path "~/.emacs.d/evil/")
(require 'evil)
(evil-mode 1)

; autocomplete
(add-to-list 'load-path "~/.emacs.d/popup-el/")
(add-to-list 'load-path "~/.emacs.d/autocomplete/")
(add-to-list 'load-path "~/.emacs.d/go-autocomplete/")
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)

; go mode
(add-to-list 'load-path "~/.emacs.d/go-mode.el/")
(require 'go-mode)

(defun user-go-mode-hook ()
  ; gofmt on sav
  (add hook 'before-save-hook 'gofmt-before-save)
  ; godef on Meta+.
  (local-set-key (kbd "M-.") 'godef-jump))
  ; build, test, vet on builds
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))
(add-hook 'go-mode-hook 'user-go-mode-hook)
