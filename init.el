(require 'package)


(setq package-enable-at-startup nil)

(package-initialize)

(require 'cask "/usr/share/emacs/site-lisp/cask/cask.el")

(cask-initialize)

(add-to-list 'load-path (expand-file-name "bundles" user-emacs-directory))

(require 'custom-bundle)
(require 'anything-bundle)

(defun switch-full-screen (&optional ii)
  (interactive "p")
  (if (> ii 0)
    (shell-command "wmctrl -r :ACTIVE: -badd,fullscreen"))
  (if (< ii 0)
    (shell-command "wmctrl -r :ACTIVE: -bremove,fullscreen"))
  (if (equal ii 0)
    (shell-command "wmctrl -r :ACTIVE: -btoggle,fullscreen")))

(defun darkroom-mode ()
  "Make things simple-looking by removing decoration
   and choosing a simple theme."
  (interactive)
  (switch-full-screen 1)     ;; requires above function
  ;;(color-theme-retro-green)  ;; requires color-theme
  (setq left-margin 10)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (set-face-foreground 'mode-line "gray15")
  (set-face-background 'mode-line "black")
  (auto-fill-mode 1))

(defun darkroom-mode-reset ()
  (interactive)
  (switch-full-screen -1)
  (color-theme-subtle-hacker) ;; Choose your favorite theme
  (menu-bar-mode 1)
  (tool-bar-mode 1)
  (scroll-bar-mode 1)
  (set-left-margin 0))


;; A small minor mode to use a big fringe
(defvar bzg-big-fringe-mode nil)
(define-minor-mode bzg-big-fringe-mode
  "Minor mode to use big fringe in the current buffer."
  :init-value nil
  :global t
  :variable bzg-big-fringe-mode
  :group 'editing-basics
  (if (not bzg-big-fringe-mode)
      (set-fringe-style nil)
    (set-fringe-mode
     (/ (- (frame-pixel-width)
           (* 100 (frame-char-width)))
        2))))

;; Now activate this global minor mode
;; (bzg-big-fringe-mode 1)

;; To activate the fringe by default and deactivate it when windows
;; are split vertically, uncomment this:
;;(add-hook 'window-configuration-change-hook
;;  (lambda ()
;;    (if (delq nil
;;          (let ((fw (frame-width)))
;;            (mapcar (lambda(w) (< (window-width w) (/ fw 2)))
;;              (window-list))))
;;      (bzg-big-fringe-mode 0)
;;      (bzg-big-fringe-mode 1))))

;; Use a minimal cursor
;; (setq default-cursor-type 'hbar)

;; Get rid of the indicators in the fringe
;; (mapcar (lambda(fb) (set-fringe-bitmap-face fb 'org-hide))
        ;;fringe-bitmaps)

(require 'tex)
    (TeX-global-PDF-mode t)

(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

;; The following lines are always needed.  Choose your own keys.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(provide 'init)

(add-hook 'term-mode-hook 'evil-emacs-state)

;;;
;;; Org Mode
;;;
(add-to-list 'load-path (expand-file-name "~/git/org-mode/lisp"))
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
(require 'org)
;;
;; Standard key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(add-to-list 'load-path "~/.emacs.d/plugins/evil-org-mode")
(require 'evil-org)
(require 'evil-tabs)
(global-evil-tabs-mode t)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(load-theme 'cyberpunk)
;;; init.el ends here
