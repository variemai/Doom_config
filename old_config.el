;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
;; I SHOULD PUT THIS IN ORG BUT I AM TOO LAZY TO DO SO

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(require 'org-bullets)
(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

;; (setq org-bullets-mode 1)
(setq doom-font (font-spec :family "IBM Plex Mono SemiBold" :size 19)
      doom-variable-pitch-font (font-spec :family "IBM Plex Mono SemiBold" :size 19))
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
 (setq doom-theme 'doom-vibrant)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(require 'evil-multiedit)
;; Highlights all matches of the selection in the buffer.
(define-key evil-visual-state-map "R" 'evil-multiedit-match-all)

;; Match the word under cursor (i.e. make it an edit region). Consecutive presses will
;; incrementally add the next unmatched match.
(define-key evil-normal-state-map (kbd "M-d") 'evil-multiedit-match-and-next)
;; Match selected region.
(define-key evil-visual-state-map (kbd "M-d") 'evil-multiedit-match-and-next)
;; Insert marker at point
(define-key evil-insert-state-map (kbd "M-d") 'evil-multiedit-toggle-marker-here)

;; Same as M-d but in reverse.
(define-key evil-normal-state-map (kbd "M-D") 'evil-multiedit-match-and-prev)
(define-key evil-visual-state-map (kbd "M-D") 'evil-multiedit-match-and-prev)

;; OPTIONAL: If you prefer to grab symbols rather than words, use
;; `evil-multiedit-match-symbol-and-next` (or prev).

;; Restore the last group of multiedit regions.
(define-key evil-visual-state-map (kbd "C-M-D") 'evil-multiedit-restore)

;; RET will toggle the region under the cursor
(define-key evil-multiedit-state-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)

;; ...and in visual mode, RET will disable all fields outside the selected region
(define-key evil-motion-state-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)

;; For moving between edit regions
(define-key evil-multiedit-state-map (kbd "C-n") 'evil-multiedit-next)
(define-key evil-multiedit-state-map (kbd "C-p") 'evil-multiedit-prev)
(define-key evil-multiedit-insert-state-map (kbd "C-n") 'evil-multiedit-next)
(define-key evil-multiedit-insert-state-map (kbd "C-p") 'evil-multiedit-prev)

;; Ex command that allows you to invoke evil-multiedit with a regular expression, e.g.
(evil-ex-define-cmd "ie[dit]" 'evil-multiedit-ex-match)

;; Hotkeys for multiple edit
;; D: clear the region
;; C: clear to end-of-region and go into insert mode
;; A: go into insert mode at end-of-region
;; I: go into insert mode at start-of-region
;; V: select the region
;; $: go to end-of-region
;; 0/^: go to start-of-region
;; gg/G: go to the first/last region

;;org mode
(setq org-use-sub-superscripts nil)
(setq org-latex-to-pdf-process
  '("xelatex -interaction nonstopmode %f"
     "xelatex -interaction nonstopmode %f")) ;; for multiple passes
(setq org-latex-pdf-process (list
   "latexmk -pdflatex='lualatex -shell-escape -interaction nonstopmode' -pdf -f  %f"))
;; (defvar my-term-shell "/bin/zsh")
;;   (defadvice ansi-term (before force-bash)
;;     (interactive (list my-term-shell)))
;;   (ad-activate 'ansi-term)
;; (global-set-key (kbd "C-x t") 'vterm)

(global-set-key (kbd "C-x t") 'eshell)

;; (defun +vterm/split_right (arg)
;;   "Open a terminal buffer in the current window at project root.

;; If prefix ARG is non-nil, cd into `default-directory' instead of project root."
;;   (interactive "P")
;;   (unless (fboundp 'module-load)
;;     (user-error "Your build of Emacs lacks dynamic modules support and cannot load vterm"))
;;   (require 'vterm)
;;   ;; This hack forces vterm to redraw, fixing strange artefacting in the tty.
;;   (select-window (split-window-horizontally))
;;   ((pop-to-buffer "*scratch*"))
;;   (let* ((project-root (or (doom-project-root) default-directory))
;;          (default-directory
;;            (if arg
;;                default-directory
;;              project-root))
;;          display-buffer-alist)
;;     (setenv "PROOT" project-root)
;;     (vterm)
;;     (+vterm--change-directory-if-remote)))

;;fullscreen at startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(evil-mu4e mu4e-alert mu4e-maildirs-extension mu4e-overview flycheck))
 '(send-mail-function 'smtpmail-send-it))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; (require 'rtags)
;; (add-hook 'c-mode-hook 'rtags-start-process-unless-running)
;; (add-hook 'c++-mode-hook 'rtags-start-process-unless-running)
;; (use-package! rtags
;;   :hook (c++-mode . rtags-start-process-unless-running)
;;   :hook (c-mode . rtags-start-process-unless-running)
;;   :config (setq rtags-completions-enabled t
;;                 rtags-path "/home/vardas/sources/rtags/src/rtags.el"
;;                 rtags-rc-binary-name "/home/vardas/.local/bin/rc"
;;                 ;;rtags-use-helm t
;;                 rtags-rdm-binary-name "/home/vardas/.local/bin/rdm")
;;   :bind (("C-c E" . rtags-find-symbol)
;;   ("C-c e" . rtags-find-symbol-at-point)
;;   ("C-c O" . rtags-find-references)
;;   ("C-c o" . rtags-find-references-at-point)
;;   ("C-c s" . rtags-find-file)
;;   ("C-c v" . rtags-find-virtuals-at-point)
;;   ("C-c F" . rtags-fixit)
;;   ("C-c f" . rtags-location-stack-forward)
;;   ("C-c b" . rtags-location-stack-back)
;;   ("C-c n" . rtags-next-match)
;;   ("C-c p" . rtags-previous-match)
;;   ("C-c P" . rtags-preprocess-file)
;;   ("C-c R" . rtags-rename-symbol)
;;   ("C-c x" . rtags-show-rtags-buffer)
;;   ("C-c T" . rtags-print-symbol-info)
;;   ("C-c t" . rtags-symbol-type)
;;   ("C-c I" . rtags-include-file)
;;   ("C-c i" . rtags-get-include-file-for-symbol)))
;; (setq rtags-display-result-backend 'ivy)
;; ;; Use rtags for auto-completion.
;; (require 'company-rtags)
;; (setq company-async-timeout 5)
;; (set-company-backend! 'c-mode-hook '(company-rtags))
;;  (rtags-enable-standard-keybindings)
;; (rtags-diagnostics)
;; (setq company-idle-delay 0)
;; (define-key c-mode-base-map (kbd "M-p") 'company-rtags)
;; (add-hook 'c++-mode-hook 'flycheck-mode)
;; (add-hook 'c-mode-hook 'flycheck-mode)
;; (add-hook 'c-mode-hook 'lsp-deferred)
;; (add-hook 'c++-mode-hook 'lsp-deferred)
(global-set-key (kbd "C-c e") 'lsp-find-definition)
(global-set-key (kbd "C-c r") 'lsp-find-references)
(global-set-key (kbd "C-c d") 'lsp-find-declaration)
(global-set-key (kbd "C-c t") 'lsp-find-implementation)
(global-set-key (kbd "C-c f") 'lsp-find-type-definition)
(setq  auth-source-debug t)
(setq auth-sources '((:source "~/.authinfo.gpg")))
(require 'pinentry)
(require 'mu4e)
(require 'smtpmail)

;;(alert (format "hello, %s" name) 'notify 'quiet 0 'nocolor 'log)

;; (setq mu4e-alert-notify-repeated-mails t)
;; (mu4e-alert-notify-unread-mail-async)
 ;;(setq mu4e-get-mail-command (format "INSIDE_EMACS=%s mbsync -a" emacs-version))
(setq mu4e-get-mail-command (format "INSIDE_EMACS=%s mbsync -a" emacs-version)
      epa-pinentry-mode 'ask)
(pinentry-start)
(setq mu4e-update-interval 120)
(setq mu4e-headers-auto-update t)
(setq mu4e-compose-signature-auto-include nil)
(setq mu4e-maildir (expand-file-name "~/Maildir"))
(setq mu4e-compose-in-new-frame t)
(setq mu4e-change-filenames-when-moving t)
(setq smtpmail-queue-mail nil)  ;; start in normal mode
(setq mu4e-attachment-dir  "~/Downloads")
(setq message-kill-buffer-on-exit t)
(setq mu4e-compose-dont-reply-to-self t)
(setq mu4e-view-show-addresses 't)
;; (setq browse-url-browser-function 'browse-url-generic)
;; (setq browse-url-generic-program "qutebrowser")

(defun my-mu4e-html2text (msg)
;;My html2text function; shows short message inline, show
;;long messages in some external browser (see `browse-url-generic-program')
  (let ((html (or (mu4e-message-field msg :body-html) "")))
    (if (> (length html) 8000)
      (progn
	(mu4e-action-view-in-browser msg)
	"[Viewing message in external browser]")
      (mu4e-shr2text msg))))
(setq mu4e-html2text-command 'my-mu4e-html2text)

;;(setq mu4e-sent-messages-behavior 'delete)
;; mu4e contexts for the different email addresses
(setq mu4e-context-policy 'pick-first)
(setq mu4e-compose-context-policy 'always-ask)
(setq mu4e-contexts
      (list
      (make-mu4e-context
          :name "Forth"
          :enter-func (lambda () (mu4e-message "Entering Forth context"))
          :leave-func (lambda () (mu4e-message "Leaving Forth context"))
          :match-func (lambda (msg)
		 (when msg
		    (mu4e-message-contact-field-matches
		     msg '(:from :to :cc :bcc) "vardas@ics.forth.gr")))
          :vars '( ( user-mail-address . "vardas@ics.forth.gr")
                   ( user-full-name . "Ioannis Vardas")
                   ( message-send-mail-function . smtpmail-send-it )
                   ( smtpmail-smtp-user . "vardas@ics.forth.gr")
                   (gnutls-min-prime-bits . 128)
                   (smtpmail-stream-type . ssl)
                   (smtpmail-starttls-credentials . (("enigma.ics.forth.gr" 465 nil nil)))
                   (smtpmail-default-smtp-server . "enigma.ics.forth.gr")
                   (smtpmail-smtp-server . "enigma.ics.forth.gr")
	                 (smtpmail-auth-credentials  . '(expand-file-name "~/.authinfo.gpg") )
                   (smtpmail-smtp-service . 465)
                   (smtpmail-debug-info . t)
                   (smtpmail-debug-verbose . t)
                   ;; (mu4e-sent-messages-behavior 'sent)
                   (mu4e-drafts-folder . "/forth/Drafts")
                   (mu4e-sent-folder   . "/forth/Sent")
                   (mu4e-refile-folder . "/forth/Archive")
                   (mu4e-trash-folder . "/forth/Trash")
                   ))

      (make-mu4e-context
       :name "Hotmail"
       :enter-func (lambda () (mu4e-message "Entering Hotmail context"))
       :leave-func (lambda () (mu4e-message "Leaving Hotmail context"))
       :match-func (lambda (msg) (when msg (mu4e-message-contact-field-matches
                                            msg '(:from :to :cc :bcc) "johnvardas@hotmail.com")))
       :vars '( ( user-mail-address . "johnvardas@hotmail.com")
                ( user-full-name . "Ioannis Vardas")
                ( message-send-mail-function . smtpmail-send-it )
                ( smtpmail-smtp-user . "johnvardas@hotmail.com")
                (gnutls-min-prime-bits . 256)
                (smtpmail-stream-type . starttls)
                (smtpmail-starttls-credentials . (("smtp-mail.outlook.com" 587 nil nil)))
                (smtpmail-default-smtp-server . "smtp-mail.outlook.com")
                (smtpmail-smtp-server . "smtp-mail.outlook.com")
	              (smtpmail-auth-credentials  . '(expand-file-name "~/.authinfo.gpg") )
                (smtpmail-smtp-service . 587)
                ;; (smtpmail-debug-info . t)
                ;; (smtpmail-debug-verbose . t)
                ;; (setq mu4e-sent-messages-behavior 'sent)
                (mu4e-trash-folder  . "/hotmail/Deleted")
                (mu4e-drafts-folder . "/hotmail/Drafts")
                (mu4e-sent-folder   . "/hotmail/Sent")
                (mu4e-refile-folder . "/hotmail/Archive")
                )))
      )
(add-to-list 'mu4e-view-actions '("ViewInBrowser" . mu4e-action-view-in-browser) t)

(require 'mu4e-alert)
(mu4e-alert-set-default-style 'libnotify)
(add-hook 'after-init-hook #'mu4e-alert-enable-notifications)
(add-hook 'after-init-hook #'mu4e-alert-enable-mode-line-display)

(require 'beacon)
(setq epa-pinentry-mode 'loopback)
(setq beacon-mode 1)
;; Diary configs
(setq appt-active 1)
(setq diary-number-of-entries 6)
(setq org-agenda-include-diary t)
(setq appt-message-warning-time 12)
(setq appt-display-interval 4)
(setq appt-audible 1)
(require 'org-make-toc)
;; (require `helm-config)
;; (helm-mode 1)
;; (setq helm-autoresize-max-height 100)
;; (setq helm-autoresize-min-height 20)
;; (helm-autoresize-mode 1)
;; (global-set-key (kbd "C-c h") 'helm-command-prefix)
;; (global-unset-key (kbd "C-x c"))

;; (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
;; (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
;; (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
;;                                         ; (global-set-key (kbd "C-c h") 'helm-command-prefix)
;; (global-set-key (kbd "C-x C-f") 'helm-find-files)
;; (global-set-key (kbd "C-x b") 'helm-mini)
;; (setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x
;; (add-hook 'org-mode-hook (lambda () (org-bullets-mode)))

;; #+LaTeX_CLASS: beamer in org files
;; (unless (boundp 'org-export-latex-classes)
;;   (setq org-export-latex-classes nil))
;; (add-to-list 'org-export-latex-classes
;;   ;; beamer class, for presentations
;;   '("beamer"
;;      "\\documentclass[11pt]{beamer}\n
;;       \\mode<{{{beamermode}}}>\n
;;       \\usetheme{{{{beamertheme}}}}\n
;;       \\usecolortheme{{{{beamercolortheme}}}}\n
;;       \\beamertemplateballitem\n
;;       \\setbeameroption{show notes}
;;       \\usepackage[utf8]{inputenc}\n
;;       \\usepackage[T1]{fontenc}\n
;;       \\usepackage{hyperref}\n
;;       \\usepackage{color}
;;       \\usepackage{listings}
;;       \\lstset{numbers=none,language=[ISO]C++,tabsize=4,
;;   frame=single,
;;   basicstyle=\\small,
;;   showspaces=false,showstringspaces=false,
;;   showtabs=false,
;;   keywordstyle=\\color{blue}\\bfseries,
;;   commentstyle=\\color{red},
;;   }\n
;;       \\usepackage{verbatim}\n
;;       \\institute{{{{beamerinstitute}}}}\n
;;        \\subject{{{{beamersubject}}}}\n"

;;      ("\\section{%s}" . "\\section*{%s}")

;;      ("\\begin{frame}[fragile]\\frametitle{%s}"
;;        "\\end{frame}"
;;        "\\begin{frame}[fragile]\\frametitle{%s}"
;;        "\\end{frame}")))

;;   ;; letter class, for formal letters

;;   (add-to-list 'org-export-latex-classes

;;   '("letter"
;;      "\\documentclass[11pt]{letter}\n
;;       \\usepackage[utf8]{inputenc}\n
;;       \\usepackage[T1]{fontenc}\n
;;       \\usepackage{color}"

;;      ("\\section{%s}" . "\\section*{%s}")
;;      ("\\subsection{%s}" . "\\subsection*{%s}")
;;      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;;      ("\\paragraph{%s}" . "\\paragraph*{%s}")
;;      ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
