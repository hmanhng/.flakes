;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Hmanhng"
      user-mail-address "hmanhng@icloud.com")

(setq confirm-kill-emacs nil)

(setq lsp-idle-delay 0.500)
(setq lsp-enable-indentation nil)

(use-package! treesit-auto
  :custom
  (treesit-auto-install t)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(setq evil-split-window-below t
      evil-vsplit-window-right t)

(setq evil-want-fine-undo t)

(setq evil-ex-substitute-global t)

(setq evil-kill-on-visual-paste nil)

(setq evil-disable-insert-state-bindings t)

(setq  ;; See https://github.com/justbur/emacs-which-key
 which-key-idle-delay 0.2
 which-key-separator " ")
(setq which-key-use-C-h-commands t)

(setq undo-fu-ignore-keyboard-quit t)

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

(map! :g "C-s" #'save-buffer)

(map! :after evil :gnvi "C-f" #'consult-line)

(when (version< "29.0.50" emacs-version)
  (pixel-scroll-precision-mode))

(setq which-key-allow-multiple-replacements t)
(after! which-key
  (pushnew!
   which-key-replacement-alist
   '(("" . "\\`+?evil[-:]?\\(?:a-\\)?\\(.*\\)") . (nil . " \\1"))
   '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . " \\1"))))

(after! marginalia
  (setq marginalia-censor-variables nil)

  (defadvice! +marginalia--anotate-local-file-colorful (cand)
    "Just a more colourful version of `marginalia--anotate-local-file'."
    :override #'marginalia--annotate-local-file
    (when-let (attrs (file-attributes (substitute-in-file-name
                                       (marginalia--full-candidate cand))
                                      'integer))
      (marginalia--fields
       ((marginalia--file-owner attrs)
        :width 12 :face 'marginalia-file-owner)
       ((marginalia--file-modes attrs))
       ((+marginalia-file-size-colorful (file-attribute-size attrs))
        :width 7)
       ((+marginalia--time-colorful (file-attribute-modification-time attrs))
        :width 12))))

  (defun +marginalia--time-colorful (time)
    (let* ((seconds (float-time (time-subtract (current-time) time)))
           (color (doom-blend
                   (face-attribute 'marginalia-date :foreground nil t)
                   (face-attribute 'marginalia-documentation :foreground nil t)
                   (/ 1.0 (log (+ 3 (/ (+ 1 seconds) 345600.0)))))))
      ;; 1 - log(3 + 1/(days + 1)) % grey
      (propertize (marginalia--time time) 'face (list :foreground color))))

  (defun +marginalia-file-size-colorful (size)
    (let* ((size-index (/ (log10 (+ 1 size)) 7.0))
           (color (if (< size-index 10000000) ; 10m
                      (doom-blend 'orange 'green size-index)
                    (doom-blend 'red 'orange (- size-index 1)))))
      (propertize (file-size-human-readable size) 'face (list :foreground color)))))

(use-package! info-colors
  :after info
  :commands (info-colors-fontify-node)
  :hook (Info-selection . info-colors-fontify-node))

(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-footer)
(setq +doom-dashboard-banner-file (expand-file-name "images/banner.png" doom-private-dir))

(define-globalized-minor-mode global-rainbow-mode rainbow-mode
  (lambda ()
    (when (not (memq major-mode
                (list 'org-agenda-mode)))
     (rainbow-mode 1))))
(global-rainbow-mode 1 )

(after! doom-modeline
  (setq all-the-icons-scale-factor 1.1
        auto-revert-check-vc-info t
        doom-modeline-major-mode-icon (display-graphic-p)
        doom-modeline-major-mode-color-icon (display-graphic-p)
        doom-modeline-buffer-file-name-style 'relative-to-project
        doom-modeline-github t
        doom-modeline-github-interval 60
        doom-modeline-vcs-max-length 60)
  (remove-hook 'doom-modeline-mode-hook #'size-indication-mode)
  (doom-modeline-def-modeline 'main
    '(bar modals workspace-name window-number persp-name buffer-position selection-info buffer-info matches remote-host debug vcs matches)
    '(github mu4e grip gnus checker misc-info repl lsp " ")))

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
(add-to-list 'default-frame-alist '(alpha-background . 100))

(use-package! centered-cursor-mode
  :demand
  :config
  ;; Optional, enables centered-cursor-mode in all buffers.
  (global-centered-cursor-mode))

(setq display-line-numbers-type 'relative)

(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Desktop/org/")

(use-package! visual-fill-column
  :custom
  (visual-fill-column-width 300)
  (visual-fill-column-center-text t)
  :hook (org-mode . visual-fill-column-mode))

(setq org-use-property-inheritance t)

(use-package! org-tempo
  :after org
  :init
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("els" . "src elisp"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp")))
