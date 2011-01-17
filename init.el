;; Path Constants
(defvar emacs-home "~/.emacs.d/")

;; Load the files in emacs home
(add-to-list 'load-path emacs-home)

(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

;; color theme
;; zenburn theme
(require 'zenburn)
(zenburn)

;;inspiration-653726 theme
;; (require 'inspiration-653726)
;; (inspiration-653726)

;; Enable IDO
(ido-mode t)

;; Toggle to Fullscreen using F11 key
(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
			 (if (equal 'fullboth current-value)
			     (if (boundp 'old-fullscreen) old-fullscreen nil)
			   (progn (setq old-fullscreen current-value)
				  'fullboth)))))
(global-set-key [f11] 'toggle-fullscreen)
(x-send-client-message nil 0 nil "_NET_WM_STATE" 32
		       '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
(x-send-client-message nil 0 nil "_NET_WM_STATE" 32
		       '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
(add-hook 'after-make-frame-functions 'toggle-fullscreen)
(toggle-fullscreen)

;; Disable the startup message
(setq inhibit-startup-message t)

;; no splash screen
(setq inhibit-splash-screen t)

(progn
  ;; no toolbar
  (if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
  ;;no menubar
  (menu-bar-mode -1)
  ;; no scroll bar
  (scroll-bar-mode -1)
  )

;; nXhtml mode
(add-to-list 'load-path (concat emacs-home "nxhtml"))

;; haml mode
(require 'haml-mode)

;; yasnippet
(add-to-list 'load-path  (concat emacs-home "yasnippet"))
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory (concat emacs-home "yasnippet/snippets"))
(setq yas/prompt-functions '(yas/dropdown-prompt))

;; Ruby
(require 'ruby)

;; javascript
(add-to-list 'auto-mode-alist '("\\.js$" . javascript-mode))

;; autocompletion
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/home/keerthi/.emacs.d//ac-dict")
(ac-config-default)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(server-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; Google talk integration with emacs.
(add-to-list 'load-path  (concat emacs-home "emacs-jabber-0.8.0"))
(require 'jabber-autoloads)
(setq jabber-account-list '
(("jaikeerthi@artha42.com"
  (:network-server . "talk.google.com")
  (:connection-type . ssl)
)))