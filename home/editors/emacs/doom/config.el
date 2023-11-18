;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Hmanhng"
      user-mail-address "hmanhng@icloud.com")

(setq doom-font (font-spec :family "Maple Mono" :size 25)
      doom-variable-pitch-font (font-spec :family "SF Pro Display" :size 20))
;; Makes commented text and keywords italics.
;; This is working in emacsclient but not emacs.
;; Your font must have an italic face available.
(set-face-attribute 'font-lock-comment-face nil
                    :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
                    :slant 'italic)

(setq doom-theme 'doom-one)
(custom-theme-set-faces! 'doom-one
  '(line-number :foreground "dim gray")
  '(line-number-current-line :foreground "white"))
(add-to-list 'default-frame-alist '(alpha-background . 90))

(setq display-line-numbers-type 'relative)

(use-package! centered-cursor-mode
  :demand
  :config
  ;; Optional, enables centered-cursor-mode in all buffers.
  (global-centered-cursor-mode))

(setq confirm-kill-emacs nil)

(setq lsp-idle-delay 0.500)

(setq  ;; See https://github.com/justbur/emacs-which-key
 which-key-idle-delay 0.2
 which-key-separator " ")
(setq which-key-use-C-h-commands t)

(setq undo-fu-ignore-keyboard-quit t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Desktop/org/")

(define-globalized-minor-mode global-rainbow-mode rainbow-mode
  (lambda ()
    (when (not (memq major-mode
                (list 'org-agenda-mode)))
     (rainbow-mode 1))))
(global-rainbow-mode 1 )

(after! nix-mode
  (set-formatter! 'alejandra '("alejandra" "-q") :modes '(nix-mode)))
(set-formatter! 'shfmt '("shfmt" "-i" "2") :modes '(sh-mode))
(setq-hook! 'nix-mode-hook
  +format-with-lsp nil)

(defun cust/vsplit-file-open (f)
  (let ((evil-vsplit-window-right t))
    (+evil/window-vsplit-and-follow)
    (find-file f)))

(defun cust/split-file-open (f)
  (let ((evil-split-window-below t))
    (+evil/window-split-and-follow)
    (find-file f)))
(map! :after embark
      :map embark-file-map
      "V" #'cust/vsplit-file-open
      "X" #'cust/split-file-open)

(map!
 ;; needf to invert + and =
 ;; and also need to be consistant because C-- was on text-scale-decrease
 :n "C-+" #'doom/increase-font-size
 :n "C--" #'doom/decrease-font-size
 :n "C-=" #'doom/reset-font-size
 :n "<C-wheel-up>" #'doom/increase-font-size
 :n "<C-wheel-down>" #'doom/decrease-font-size)
