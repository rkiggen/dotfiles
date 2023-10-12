;; Define and initialise package repositories
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; install use-package if it is not installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(setq package-enable-at-startup nil)

;; ensure all packages are installed from the package manager
(setq use-package-always-ensure 't)

(defun efs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                   (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'efs/display-startup-time)

;; create backups in a separate folder
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )

;; Don't write lock-files
(setq create-lockfiles nil)

;; Keyboard-centric user interface
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(defalias 'yes-or-no-p 'y-or-n-p)

(use-package doom-themes
  :config
  (let ((chosen-theme 'doom-material-dark))
    (doom-themes-visual-bell-config)
    (doom-themes-org-config)
    (setq doom-challenger-deep-brighter-comments t
          doom-challenger-deep-brighter-modeline t
          doom-rouge-brighter-comments t
          doom-ir-black-brighter-comments t
          modus-themes-org-blocks 'gray-background
          doom-dark+-blue-modeline nil)
    (load-theme chosen-theme t)))

(use-package diminish
  :config
  (diminish 'visual-line-mode))

(defun pt/project-relative-file-name (include-prefix)
  "Return the project-relative filename, or the full path if INCLUDE-PREFIX is t."
  (letrec
      ((fullname (if (equal major-mode 'dired-mode) default-directory (buffer-file-name)))
       (root (project-root (project-current)))
       (relname (if fullname (file-relative-name fullname root) fullname))
       (should-strip (and root (not include-prefix))))
    (if should-strip relname fullname)))

(use-package mood-line
  :config
  (defun pt/mood-line-segment-project-advice (oldfun)
    "Advice to use project-relative file names where possible."
    (let
        ((project-relative (ignore-errors (pt/project-relative-file-name nil))))
         (if
             (and (project-current) (not org-src-mode) project-relative)
             (propertize (format "%s  " project-relative) 'face 'mood-line-buffer-name)
           (funcall oldfun))))

  (advice-add 'mood-line-segment-buffer-name :around #'pt/mood-line-segment-project-advice)
  (mood-line-mode))

;; Sensible line breaking
  (add-hook 'text-mode-hook 'visual-line-mode)
  
  ;; Overwrite selected text
  (delete-selection-mode t)
  
  ;; Scroll to the first and last line of the buffer
  (setq scroll-error-top-bottom t)

;;; Vim Bindings
(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  ;; allows for using cgn
  ;; (setq evil-search-module 'evil-search)
  (setq evil-want-keybinding nil)
  ;; no vim insert bindings
  (setq evil-undo-system 'undo-fu)
  :config
  (evil-mode 1))

;;; Vim Bindings Everywhere else
(use-package evil-collection
  :after evil
  :config
  (setq evil-want-integration t)
  (evil-collection-init))

; Reveal.js + Org mode
(use-package ox-reveal
:ensure ox-reveal)

;;(require 'ox-reveal)
(setq org-reveal-root "file:///home/rkiggen/.emacs.d/publishing/slides/reveal.js")

(defun edit-init-file ()
  "Edit my init file in another window."
  (interactive)
  (let ((mwf-init-file "~/.emacs.d/rkiggen.org"))
    (find-file mwf-init-file)))

(global-set-key (kbd "C-c i") 'edit-init-file)
