(add-to-list 'load-path (concat emacs-home "ruby"))

(add-hook 'ruby-mode-hook 'ruby-electric-mode)
;; Rake files are ruby, too, as are gemspecs, rackup files, etc.
(setq auto-mode-alist (append auto-mode-alist
			      '(("\\.rake$" . ruby-mode)
				("\\.gemspec$" . ruby-mode)
				("\\.ru" . ruby-mode)
				("\\.god" . ruby-mode)
				("Rakefile$" . ruby-mode)
				("Gemfile$" . ruby-mode)
				("capfile$" . ruby-mode)
				("Capfile$" . ruby-mode)
				("Vagrantfile$" . ruby-mode))))
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

;; expand snippet on TAB
(defun yas/advise-indent-function (function-symbol)
  (eval `(defadvice ,function-symbol (around yas/try-expand-first activate)
           ,(format
             "Try to expand a snippet before point, then call `%s' as usual"
             function-symbol)
           (let ((yas/fallback-behavior nil))
             (unless (and (interactive-p)
                          (yas/expand))
               ad-do-it)))))

(yas/advise-indent-function 'ruby-indent-command)

;; Yari
(defun ri-bind-key ()
  (local-set-key [f1] 'yari))
(add-hook 'ruby-mode-hook 'ri-bind-key)

(provide 'ruby)