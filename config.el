;; [[file:config.org::*turn on lexical binding][turn on lexical binding:1]]
;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; turn on lexical binding:1 ends here

;; [[file:config.org::*Linenum][Linenum:1]]
(setq display-line-numbers-type 't)
;; Linenum:1 ends here

;; [[file:config.org::*Org Bullets][Org Bullets:1]]
(require 'org-bullets)
(use-package org-bullets
  :hook (org-mode . org-bullets-mode))
;; Org Bullets:1 ends here

;; [[file:config.org::*Org Folder][Org Folder:1]]
(setq org-directory "~/org/")
;; Org Folder:1 ends here

;; [[file:config.org::*Org to Latex][Org to Latex:1]]
(setq org-use-sub-superscripts nil)
(setq org-latex-to-pdf-process
  '("xelatex -interaction nonstopmode %f"
     "xelatex -interaction nonstopmode %f")) ;; for multiple passes
(setq org-latex-pdf-process (list
   "latexmk -pdflatex='lualatex -shell-escape -interaction nonstopmode' -pdf -f  %f"))
(require 'org-make-toc)
;; Org to Latex:1 ends here

;; [[file:config.org::*PDF viewer][PDF viewer:1]]
(setq +latex-viewers '(okular pdf-tools))
(add-to-list 'org-file-apps '("\\.pdf" . "okular %s"))
(after! tex
  (add-to-list 'TeX-view-program-list '("Okular" "evince %o"))
  (add-to-list 'TeX-view-program-selection '(output-pdf "Okular")))
;; PDF viewer:1 ends here

;; [[file:config.org::*Compile][Compile:1]]
(setq TeX-save-query nil
      TeX-show-compilation t
      TeX-command-extra-options "-shell-escape")
(after! latex
  (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t)))
;; Compile:1 ends here

;; [[file:config.org::*Font][Font:1]]
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
(setq doom-font (font-spec :family "Iosevka SS13 Medium Extended" :size 19)
      doom-big-font (font-spec :family "Iosevka SS13 Medium Extended" :size 30)
      doom-variable-pitch-font (font-spec :family "Hack" :size 19)
      doom-serif-font (font-spec :family "IBM Plex Mono" :weight 'light)
      )
;; Font:1 ends here

;; [[file:config.org::*Theme][Theme:1]]
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
 (setq doom-theme 'doom-Iosvkem)
;; Theme:1 ends here

;; [[file:config.org::*Fullscreen][Fullscreen:1]]
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; Fullscreen:1 ends here

;; [[file:config.org::*Beacon][Beacon:1]]
(require 'beacon)
(setq beacon-mode 1)
;; Beacon:1 ends here

;; [[file:config.org::*Evil Mode][Evil Mode:1]]
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
;; Evil Mode:1 ends here

;; [[file:config.org::*Eshell][Eshell:1]]
(global-set-key (kbd "C-x t") 'eshell)
;; Eshell:1 ends here

;; [[file:config.org::*Lsp][Lsp:1]]
(global-set-key (kbd "C-c e") 'lsp-find-definition)
(global-set-key (kbd "C-c r") 'lsp-find-references)
(global-set-key (kbd "C-c d") 'lsp-find-declaration)
(global-set-key (kbd "C-c t") 'lsp-find-implementation)
(global-set-key (kbd "C-c f") 'lsp-find-type-definition)
;; Lsp:1 ends here

;; [[file:config.org::*Mail and Mu4e][Mail and Mu4e:1]]
(setq  auth-source-debug t)
(setq auth-sources '((:source "~/.authinfo.gpg")))
(require 'pinentry)
(require 'mu4e)
(require 'smtpmail)

;;(alert (format "hello, %s" name) 'notify 'quiet 0 'nocolor 'log)

;; (setq mu4e-alert-notify-repeated-mails t)
;; (mu4e-alert-notify-unread-mail-async)
 (setq
  mu4e-get-mail-command (format "INSIDE_EMACS=%s mbsync -a" emacs-version)
  epa-pinentry-mode 'ask
  mu4e-update-interval 120)
;; (setq mu4e-get-mail-command (format "INSIDE_EMACS=%s mbsync -a" emacs-version)
;;       epa-pinentry-mode 'ask)
(pinentry-start)
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
(setq mu4e-compose-format-flowed t)
(remove-hook! 'mu4e-compose-pre-hook #'org-msg-mode)
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
                (smtpmail-starttls-credentials . (("smtp.office365.com" 587 nil nil)))
                (smtpmail-default-smtp-server . "smtp.office365.com")
                (smtpmail-smtp-server . "smtp.office365.com")
	              (smtpmail-auth-credentials  . '(expand-file-name "~/.authinfo.gpg") )
                (smtpmail-smtp-service . 587)
                ;; (smtpmail-debug-info . t)
                ;; (smtpmail-debug-verbose . t)
                ;; (setq mu4e-sent-messages-behavior 'sent)
                (mu4e-trash-folder  . "/hotmail/Deleted")
                (mu4e-drafts-folder . "/hotmail/Drafts")
                (mu4e-sent-folder   . "/hotmail/Sent")
                (mu4e-refile-folder . "/hotmail/Archive")
                ))

      (make-mu4e-context
       :name "TUWien"
       :enter-func (lambda () (mu4e-message "Entering TUWien context"))
       :leave-func (lambda () (mu4e-message "Leaving TUWien context"))
       :match-func (lambda (msg) (when msg (mu4e-message-contact-field-matches
                                            msg '(:from :to :cc :bcc) "vardas@par.tuwien.ac.at")))
       :vars '( ( user-mail-address . "vardas@par.tuwien.ac.at")
                ( user-full-name . "Ioannis Vardas")
                ( message-send-mail-function . smtpmail-send-it )
                ( smtpmail-smtp-user . "ivardas")
                (gnutls-min-prime-bits . 256)
                (smtpmail-stream-type . starttls)
                (smtpmail-starttls-credentials . (("mail.intern.tuwien.ac.at" 587 nil nil)))
                (smtpmail-default-smtp-server . "mail.intern.tuwien.ac.at")
                (smtpmail-smtp-server . "mail.intern.tuwien.ac.at")
	              (smtpmail-auth-credentials  . '(expand-file-name "~/.authinfo.gpg") )
                (smtpmail-smtp-service . 587)
                ;; (smtpmail-debug-info . t)
                ;; (smtpmail-debug-verbose . t)
                (setq mu4e-sent-messages-behavior 'sent)
                (mu4e-trash-folder  . "/TUWien/Deleted")
                (mu4e-drafts-folder . "/TUWien/Drafts")
                (mu4e-sent-folder   . "/TUWien/Sent Items")
                (mu4e-refile-folder . "/TUWien/Archive")
            ))))
(add-to-list 'mu4e-view-actions '("ViewInBrowser" . mu4e-action-view-in-browser) t)
;; Mail and Mu4e:1 ends here

;; [[file:config.org::*Mu4e-alert][Mu4e-alert:1]]
(require 'mu4e-alert)
(mu4e-alert-set-default-style 'libnotify)
(add-hook 'after-init-hook #'mu4e-alert-enable-notifications)
(add-hook 'after-init-hook #'mu4e-alert-enable-mode-line-display)
;; (setq epa-pinentry-mode 'loopback)
;; Mu4e-alert:1 ends here

;; [[file:config.org::*Mu4e-signature][Mu4e-signature:1]]
(defun my-mu4e-choose-signature ()
  "Insert one of a number of sigs"
  (interactive)
  (let ((message-signature
          (mu4e-read-option "Signature:"
            '(("formal" .
              (concat
           "Ioannis Vardas\n"
           "Research Group for Parallel Computing\nFaculty of Informatics\nTechnical University of Vienna\n"
           "T: +43-(1)-58801-191415"))
               ("informal" .
              "Ioannis\n")))))
    (message-insert-signature)))

(add-hook 'mu4e-compose-mode-hook
          (lambda () (local-set-key (kbd "C-c C-w") #'my-mu4e-choose-signature)))
;; Mu4e-signature:1 ends here

;; [[file:config.org::*Diary][Diary:1]]
;; Diary configs
(setq appt-active 1)
(setq diary-number-of-entries 6)
(setq org-agenda-include-diary t)
(setq appt-message-warning-time 12)
(setq appt-display-interval 4)
(setq appt-audible 1)
;; Diary:1 ends here

;; [[file:config.org::*Flyspell][Flyspell:1]]
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'org-mode-hook  'flyspell-mode)
;; Flyspell:1 ends here

;; [[file:config.org::*LSP in buffers][LSP in buffers:1]]
(cl-defmacro lsp-org-babel-enable (lang) ;
  "Support LANG in org source code block."
  (setq centaur-lsp 'lsp-mode)
  (cl-check-type lang stringp)
  (let* ((edit-pre (intern (format "org-babel-edit-prep:%s" lang)))
         (intern-pre (intern (format "lsp--%s" (symbol-name edit-pre)))))
    `(progn
       (defun ,intern-pre (info)
         (let ((file-name (->> info caddr (alist-get :file))))
           (unless file-name
             (setq file-name (make-temp-file "babel-lsp-")))
           (setq buffer-file-name file-name)
           (lsp-deferred)))
       (put ',intern-pre 'function-documentation
            (format "Enable lsp-mode in the buffer of org source block (%s)."
                    (upcase ,lang)))
       (if (fboundp ',edit-pre)
           (advice-add ',edit-pre :after ',intern-pre)
         (progn
           (defun ,edit-pre (info)
             (,intern-pre info))
           (put ',edit-pre 'function-documentation
                (format "Prepare local buffer environment for org source block (%s)."
                        (upcase ,lang))))))))
(defvar org-babel-lang-list
  '("go" "python" "ipython" "bash" "sh"))
(dolist (lang org-babel-lang-list)
  (eval `(lsp-org-babel-enable ,lang)))
;; LSP in buffers:1 ends here

;; [[file:config.org::*Python][Python:1]]
(after! lsp-python-ms
  (set-lsp-priority! 'mspyls 1))
;; Python:1 ends here

;; [[file:config.org::*Flycheck][Flycheck:1]]
(add-hook 'flycheck-after-syntax-check-hook
          (lambda  ()
            (if flycheck-current-errors
                (flycheck-list-errors)
              (when (get-buffer "*Flycheck errors*")
                (switch-to-buffer "*Flycheck errors*")
                (kill-buffer (current-buffer))
                (delete-window)))))
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
;; Flycheck:1 ends here
