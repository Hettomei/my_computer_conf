(defun middle-of-line-forward ()
  "Put cursor at the middle point of the line. try to mimic vim-skip"
  (interactive)
  (goto-char (/ (+ (point) (point-at-eol)) 2)))

(defun middle-of-line-backward ()
  "Put cursor at the middle point of the line. try to mimic vim-skip"
  (interactive)
  (goto-char (/ (+ (point) (point-at-bol)) 2)))

(defun delete-and-replace-word ()
  "Delete the word and go in insert mode. When word is not found go forward-word"
  (interactive)
  (let ((bounds (bounds-of-thing-at-point 'word)))
    (if bounds
	(progn
	  ;; kill-region will save it in kill ring. Delete just delete
	  (delete-region (car bounds) (cdr bounds))
	  (evil-insert 1))
	(progn
	  ;; When word not found.... continue. It will call this method a maximum of 500 (see max-lisp-eval-depth)
	  (forward-word)
	  (delete-and-replace-word)))))

(defun copy-word ()
  "Copy the word. When word is not found go forward-word"
  (interactive)
  (let ((bounds (bounds-of-thing-at-point 'word)))
    (if bounds
	(copy-region-as-kill (car bounds) (cdr bounds))
	(progn
	  ;; When word not found.... continue. It will call this method a maximum of 500 (see max-lisp-eval-depth)
	  (forward-word)
	  (copy-word)))))

(defun replace-with-paste ()
  "Delete the word and Paste another on it. When word is not found go forward-word"
  (interactive)
  (let ((bounds (bounds-of-thing-at-point 'word)))
    (if bounds
	(progn
	  ;; kill-region will save it in kill ring. Delete just delete
	  (delete-region (car bounds) (cdr bounds))
	  (yank))
	(progn
	  ;; When word not found.... continue. It will call this method a maximum of 500 (see max-lisp-eval-depth)
	  (forward-word)
	  (replace-with-paste)))))

(defun set-case-insensitive ()
  "Ignore case for vim-search"
  (interactive)
  (setq evil-ex-search-case (quote insensitive)))

(defun set-case-sensitive ()
  "Consider case for vim-search"
  (interactive)
  (setq evil-ex-search-case (quote sensitive)))

(defun set-case-smart ()
  "Smart case for vim-search"
  (interactive)
  (setq evil-ex-search-case (quote smart)))

;; load evil
(use-package evil
  :ensure t ;; install the evil package if not installed
  :init ;; tweak evil's configuration before loading it
  (setq evil-backspace-join-lines t)
  (setq evil-ex-complete-emacs-commands nil)
  (setq evil-ex-search-case (quote sensitive))
  ;; (setq evil-search-module 'evil-search)
  (setq evil-move-beyond-eol nil)
  ; Mini bug, if I am on the last word, and press * it found nothing. But it s close to nowrapscan
  (setq evil-search-wrap nil)
  (setq evil-shift-round nil)
  (setq evil-split-window-below t)
  (setq evil-vsplit-window-right t)
  ; make Y copy from point to end of line.
  (setq evil-want-Y-yank-to-eol t)
  :config ;; tweak evil after loading it
  (evil-mode 1)

  ;; set leader to space
  (evil-set-leader 'normal (kbd "SPC"))

  ;; cannot use <leader><leader>
  (evil-define-key 'normal 'global (kbd "<leader>SPC") 'save-buffer)
  (evil-define-key 'normal 'global (kbd "<leader>e") 'find-file)

  ;; Need to refine this <leader>f: need to display file name
  (evil-define-key 'normal 'global (kbd "<leader>f") 'find-file)

  (evil-define-key 'normal 'global (kbd "C-<left>") 'evil-window-left)
  (evil-define-key 'normal 'global (kbd "C-<down>") 'evil-window-down)
  (evil-define-key 'normal 'global (kbd "C-<up>") 'evil-window-up)
  (evil-define-key 'normal 'global (kbd "C-<right>") 'evil-window-right)

  (evil-define-key 'normal 'global (kbd "C-w x") 'window-swap-state)


  ;; mimic vim-skip
  (evil-define-key 'normal 'global (kbd "s") 'middle-of-line-forward)
  (evil-define-key 'normal 'global (kbd "S") 'middle-of-line-backward)

  (evil-define-key 'visual 'global (kbd "v") 'er/expand-region)

  ;; fast act on words
  (evil-define-key 'normal 'global (kbd "<leader>r") 'delete-and-replace-word)
  (evil-define-key 'normal 'global (kbd "<leader>p") 'replace-with-paste)
  (evil-define-key 'normal 'global (kbd "<leader>y") 'copy-word))

(use-package evil-commentary
  :ensure t
  :config
  (evil-commentary-mode 1))

(use-package evil-numbers
  :ensure t
  :config
  (evil-define-key 'normal 'global (kbd "C-a") 'evil-numbers/inc-at-pt)
  (evil-define-key 'normal 'global (kbd "M-a") 'evil-numbers/dec-at-pt))

;; https://github.com/emacs-evil/evil-surround
;; To remove the ' arround 'Hello world!' press ds'
;; To change the ( into [ arround (printf ok) press cs(]
;; To ADD to a line something let s say :
;; hello world
;; press: yss(
;; ( hello world )
;; press: yss)
;; (hello world)
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

;; evil-visualstar allow you to press * during visual mode to start search mode
(use-package evil-visualstar
  :ensure t
  :config
  (global-evil-visualstar-mode t))

;; Redefine syntax for vimrc file.
;; Thanks to https://stackoverflow.com/questions/4236808/syntax-highlight-a-vimrc-file-in-emacs
(define-generic-mode 'vimrc-generic-mode
  '()
  '()
  '(("^[\t ]*:?\\(!\\|ab\\|map\\|unmap\\)[^\r\n\"]*\"[^\r\n\"]*\\(\"[^\r\n\"]*\"[^\r\n\"]*\\)*$"
     (0 font-lock-warning-face))
    ("\\(^\\|[\t ]\\)\\(\".*\\)$"
     (2 font-lock-comment-face))
    ("\"\\([^\n\r\"\\]\\|\\.\\)*\""
     (0 font-lock-string-face)))
  '("/vimrc\\'" "\\.vim\\(rc\\)?\\'")
  '((lambda ()
      (modify-syntax-entry ?\" ".")))
  "Generic mode for Vim configuration files.")

(provide 'evil-config)
