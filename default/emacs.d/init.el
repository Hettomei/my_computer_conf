;;; Generated by https://github.com/editor-bootstrap/emacs-bootstrap

(add-to-list 'load-path (concat user-emacs-directory "elisp"))

(require 'base)
(require 'base-theme)
(require 'base-extensions)

(require 'tim-base)
(require 'ag-config)
(require 'evil-config)

(require 'lang-javascript)
(require 'lang-web)

(add-to-list 'auto-mode-alist '("\\.bashrcc\\'" . sh-mode))

;; Lang, just uncomment, reload emacs, and voilà

(require 'lang-python)
;; (require 'lang-ruby)
;; (require 'lang-go)
;; (require 'lang-php)
;; (require 'lang-c)


;; Tips

;; C-u M-! inserts the result of the ‘shell-command’

;; To save session :
;; M-x desktop-save
;; Then reopen emacs then
;; M-x desktop-change-dir
;; And find dir

;; How to quickly create a new mode :
;; https://emacs.stackexchange.com/questions/2533/how-can-i-prevent-flycheck-mode-from-checking-certain-files/2541#2541?newreg=6182441417524097a0075ad78c8b187a :
;; you can also find a new mode in evil-config.el
;; (define-derived-mode my-cfg-mode sh-mode "My CFg Mode"
;;   "A mode for my CFg files."
;;   (sh-set-shell "bash"))
;; (add-to-list 'auto-mode-alist '("\\.cfg\\'" . my-cfg-mode))


;; count number of occurence
;; M-x swipper RET
