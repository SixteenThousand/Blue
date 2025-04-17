(setq default-frame-alist '((fullscreen . maximized)))
			    
(tab-bar-mode)
(dynamic-completion-mode)

;; colourscheme
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(leuven-dark)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; set font size
(set-face-attribute 'default nil :height 130)

;; keybindings
(keymap-global-set "C-x C-n" 'make-frame-command)
(keymap-global-set "C-x C-t" 'tab-new)
(keymap-global-set "C-x T" 'tab-bar-close-tab)
(keymap-global-set "C-<next>" 'tab-previous)
(keymap-global-set "C-<prior>" 'tab-next)
(keymap-global-set "C-x C-q" 'kill-buffer-and-window) 
(keymap-global-set "C-x b" 'ibuffer)
(keymap-global-set "C-x C-o" 'other-window)
(keymap-global-set "C-x C-w" #'(lambda () (interactive) (other-window 1)))
(keymap-global-set "C-x W" #'(lambda () (interactive) (other-window -1)))
(defun six-source-file ()
  (interactive)
  (eval-buffer)
  (message "Changes Applied!")
  )
(keymap-global-set "<f12>" #'six-source-file)

(defun six-enter-filebrowser ()
  (interactive)
  (dired (file-name-directory (buffer-file-name)))
  )
(keymap-global-set "M--" #'six-enter-filebrowser)
(defun six-goto-config ()
  (interactive)
  (dired "~/.emacs.d/")
  )
(keymap-global-set "C-x C-'" #'six-goto-config)
;; (keymap-global-set "M--" #'dired-up-directory)
(keymap-global-set "M-<up>" #'dired-up-directory)

(print "And It Goes On...")
