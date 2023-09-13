;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(add-to-list 'load-path "~/.doom.d/my")

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Kai Eckert"
      user-mail-address "k.eckert@hs-mannheim.de")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/sync/org/")
(after! org
        ;; custom list of static agenda files that are not managed by my-roam-agenda
        (defvar my-org-agenda-files nil "Custom list of static agenda files")
        (setq my-org-agenda-files '("/home/kai/sync/org/calendars/calendar-kai.org" "/home/kai/sync/org/calendars/calendar-flo-kai.org" "/home/kai/sync/org/calendars/calendar-team.org"))


        (require 'my-roam-agenda)
        (require 'org-download)
        ; (load "my-org-present")
        ; WORKAROUND, https://github.com/org-roam/org-roam/issues/2198
        (setq org-fold-core-style 'overlays)
        (setq org-latex-caption-above nil)
        (setq org-todo-keywords '(
                                  (sequence "TODO(t!)" "WAIT(w@)" "OPEN(o!)"  "|" "DONE(d!)" "CANCELED(c@)" "IRRELEVANT(i!)" "HOLD(h@)"  )
                                  (sequence "PLANNED(p!)" "ACTIVE(a!)" "|" "SUBMITTED(s!)" "ACCEPTED(a@)" "REJECTED(r@)" "ICED(i@)")
                                  ))
        (setq org-capture-templates
        '(
        ("m" "Email Workflow")
        ("mt" "Todo" entry (file+olp "~/sync/org/roam/mail.org" "Todos")
                "* TODO %a (%:fromname )\n%i")
        ))
        (setq org-roam-capture-templates
        '(
                ("d" "default" plain "%?" :target (file+head "${slug}.org" "#+title: ${title}\n") :unnarrowed t)

                ("p" "people" plain "%?" :target (file+head "people/${slug}.org" "#+title: ${title}\n") :unnarrowed t)

                ;; bibliography note template
                ("r" "bibliography reference" plain (file "~/sync/org/templates/reference.org")
                :target
                (file+head "references/${citekey}.org" ":PROPERTIES:\n :NOTER_DOCUMENT: ${file}\n :END:\n \n #+title: ${citekey} - ${author-or-editor-abbrev} - ${title}\n\n")
                :unnarrowed t)


                ))
        ;; Needs more work, could be something for a filtered view of active stuff
        ;; https://emacs.stackexchange.com/questions/70106/in-org-tags-view-how-can-i-only-see-headlines-with-non-inherited-tags
        (defun my/org-tags-view (&optional todo-only watch)
                (interactive)
                (let ((org-use-tag-inheritance nil))
                (org-tags-view todo-only watch)))

        ;; Agenda settings
        (setq org-agenda-compact-blocks nil)
        (setq org-agenda-block-separator 9620) ;≡ 8801 /  ─ 9472
        (setq org-agenda-custom-commands
        '(("c" "My Agenda"
                ((agenda "" (
                (org-agenda-overriding-header "Calendar")
                (org-agenda-span 2)
                (org-agenda-start-day nil)
                (org-deadline-warning-days 1)
                ))
                (tags-todo "SCHEDULED>\"<+1d>\"+SCHEDULED<\"<+4d>\"" (
                (org-agenda-overriding-header "Scheduled soon")
                (org-agenda-prefix-format "%(let ((scheduled (org-get-scheduled-time (point)))) (if scheduled (format-time-string \"%A\" scheduled) \"\")) ")
                (org-agenda-sorting-strategy '(scheduled-up))
                ))
                (tags-todo "DEADLINE>\"<+1d>\"+DEADLINE<\"<+8d>\"" (
                (org-agenda-overriding-header "Upcoming Deadlines")
                (org-agenda-prefix-format "%(let ((deadline (org-get-deadline-time (point)))) (if deadline (format-time-string \"%A\" deadline) \"\")) ")
                (org-agenda-sorting-strategy '(deadline-up))
                ))
                (alltodo "" (
                (org-agenda-todo-ignore-scheduled t)
                (org-agenda-overriding-header "Open Todos")
                ))
                )

                ( ;; options set here apply to the entire block
                (org-agenda-compact-blocks nil))
                (org-agenda-block-separator "*")
                ))
                ;; ...other commands here
                )
  )



;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(use-package! org-roam-bibtex
  :after org-roam
  :config
  (require 'org-ref)
  (setq! reftex-default-bibliography '("~/sync/org/roam/references/references.bib") )
  ;; This is overwritten by bibtex-completion-bibliography anyway
  ;; (setq! helm-bibtex-bibliography '("~/sync/org/roam/references/references.bib") )
  (setq! bibtex-completion-bibliography '("~/sync/org/roam/references/references.bib") )
  (setq! bibtex-completion-pdf-field "file")
  (setq! bibtex-completion-notes-path "~/sync/org/roam/references")
  (org-roam-bibtex-mode)
  (setq! orb-insert-interface 'helm-bibtex)
  (setq! orb-preformat-keywords '("citekey" "entry-type" "date" "pdf?" "note?" "file" "author" "editor" "author-abbrev" "editor-abbrev" "author-or-editor-abbrev" "title"))
  ) ; optional: if using Org-ref v2 or v3 citation links

;; (setq confirm-kill-emacs yes-or-n-p)

(defun kai-rename-image ()
  "Rename image at point."
  (interactive)
  (let* ((current-path (org-element-property :path (org-element-context)))
         (current-name (file-name-nondirectory current-path))
         (current-dir (f-dirname current-path))
         (ext (file-name-extension current-name))
         (new-name (read-string "Rename file at point to: " (file-name-sans-extension current-name)))
         (new-path (concat current-dir "/" new-name "." ext)))
    (rename-file current-path new-path)
    (message "File successfully renamed...")
    (org-download-replace-all current-name (concat new-name "." ext))))

(use-package! orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; E-Mail Setup

;; Each path is relative to the path of the maildir you passed to mu
(set-email-account! "HSMA"
  '((mu4e-sent-folder       . "/Inbox")
    (mu4e-drafts-folder     . "/Drafts")
    (mu4e-trash-folder      . "/trash")
    (mu4e-refile-folder     . "/archive")
    (smtpmail-smtp-user     . "k.eckert@hs-mannheim.de")
    (mu4e-compose-signature . "Prof. Dr. Kai Eckert\nMannheim University of Applied Sciences\nhttp://www.kaiec.org/\nPGP Public Key:   http://www.kaiec.org/2012/pgp/pubkey.asc\nA987  3760  12A6  35A4  E6D2  577E  513A  6B84  C755  5A67")
  ) t )

;; add to $DOOMDIR/config.el
(after! mu4e
  (remove-hook! 'mu4e-compose-mode-hook #'org-msg-post-setup)
  (setq mu4e-compose-format-flowed t)
  (setq message-kill-buffer-on-exit t)
  (setq mu4e-compose-dont-reply-to-self t)
  (setq mu4e-compose-crypto-policy '(sign-all-messages))
  (setq sendmail-program (executable-find "msmtp")
	send-mail-function #'smtpmail-send-it
	message-sendmail-f-is-evil t
	message-sendmail-extra-arguments '("--read-envelope-from")
	message-send-mail-function #'message-send-mail-with-sendmail)
  ;; deactivate mail fetching, only reindex at update
  (setq mu4e-get-mail-command "~/dotfiles/bin/mail-emacs")
  (setq mu4e-update-interval 300)
  ;;(setq mu4e-split-view 'single-window)
  (setq mu4e-split-view nil)
    ;; https://systemcrafters.net/emacs-mail/email-workflow-with-org-mode/
    (defun efs/capture-mail-todo (msg)
    (interactive)
    (call-interactively 'org-store-link)
    (org-capture nil "mt"))


    ;; Add custom actions for our capture templates
    (add-to-list 'mu4e-headers-actions
    '("todo" . efs/capture-mail-todo) t)
    (add-to-list 'mu4e-view-actions
    '("todo" . efs/capture-mail-todo) t)

    ;; do not kill all windows when mu4e opens main vew
    ;; https://github.com/djcb/mu/issues/2382
    (add-to-list 'display-buffer-alist
             `(,(regexp-quote mu4e-main-buffer-name)
               display-buffer-same-window))
)
