;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ! THIS FILES IS AUTOGENERATED FROM config.org
;; ! DO NOT EDIT MANUALLY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq user-full-name       "Julien Tant"
      user-mail-address    "julien@craftyx.fr")

(setq doom-font                (font-spec :family "JetBrainsMono Nerd Font" :size 15)
      doom-variable-pitch-font (font-spec :family "Ubuntu" :size 15)
      doom-big-font            (font-spec :family "JetBrainsMono Nerd Font" :size 24))

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))


(setq doom-theme 'doom-gruvbox)

;; display the absolute line numbers (with t). other options are nil (no line numbers) or relative (line numbers relative to the cursor position)
(setq display-line-numbers-type t)

(make-directory "~/org" 'parents)
(make-directory "~/org-roam" 'parents)

(setq org-directory (file-truename "~/org/"))
(setq org-roam-directory (file-truename "~/org-roam"))

 (use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  )

(after! circe
  (set-irc-server! "irc.libera.chat"
    `(:tls t
      :port 6697
      :nick "JulienTant"
      :sasl-username "JulienTant"
      :sasl-password (lambda (&rest _) (+pass-get-secret "irc/libera.chat"))
      :channels ("#emacs", "#neomutt", "#xmonad"))))
