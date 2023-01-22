;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(add-to-list 'load-path "~/.doom.d/my")

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Kai Eckert"
      user-mail-address "hallo@kaiec.de")

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
(setq org-directory "~/org/")
(setq org-roam-capture-templates
      '(
        ("d" "default" plain "%?" :target (file+head "${slug}.org" "#+title: ${title}\n") :unnarrowed t)

        ("p" "people" plain "%?" :target (file+head "people/${slug}.org" "#+title: ${title}\n") :unnarrowed t)

        ;; bibliography note template
        ("r" "bibliography reference" plain (file "~/org/templates/reference.org")
        :target
        (file+head "references/${citekey}.org" "#+title: ${citekey} - ${author-or-editor-abbrev} - ${title}\n")
        :unnarrowed t)

        ))
(after! org
        (require 'my-roam-agenda)
        ; WORKAROUND, https://github.com/org-roam/org-roam/issues/2198
        (setq org-fold-core-style 'overlays)
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
  (setq! reftex-default-bibliography '("~/org/roam/references/references.bib") )
  ;; This is overwritten by bibtex-completion-bibliography anyway
  ;; (setq! helm-bibtex-bibliography '("~/org/roam/references/references.bib") )
  (setq! bibtex-completion-bibliography '("~/org/roam/references/references.bib") )
  (setq! bibtex-completion-pdf-field "file")
  (setq! bibtex-completion-notes-path "~/org/roam/references")
  (org-roam-bibtex-mode)
  (setq! orb-insert-interface 'helm-bibtex)
  (setq! orb-preformat-keywords '("citekey" "entry-type" "date" "pdf?" "note?" "file" "author" "editor" "author-abbrev" "editor-abbrev" "author-or-editor-abbrev" "title"))
  ) ; optional: if using Org-ref v2 or v3 citation links

;; (setq confirm-kill-emacs yes-or-n-p)
(use-package! org-super-agenda
  :after org-agenda
  :init
 (setq org-agenda-skip-scheduled-if-done t
    org-agenda-skip-deadline-if-done t
    org-agenda-include-deadlines t
    org-agenda-block-separator nil
    org-agenda-compact-blocks t
    ; org-agenda-start-day nil  ;; i.e. today
    org-agenda-span 14
    org-agenda-start-on-weekday 1)
  (setq org-agenda-custom-commands
        '(("c" "Super view"
           ((agenda "" ((org-agenda-overriding-header "Week")
                        (org-super-agenda-groups
                         '((:name "Today"
                                  :time-grid t
                                  :date today
                                  :order 1)))))
            (alltodo "" ((org-agenda-overriding-header "")
                         (org-super-agenda-groups
                          '((:log t)
                            (:name "To refile"
                                   :file-path "refile\\.org")
                            (:name "Next to do"
                                   :todo "NEXT"
                                   :order 1)
                            (:name "Important"
                                   :priority "A"
                                   :order 6)
                            (:name "Today's tasks"
                                   :file-path "journal/")
                            (:name "Due Today"
                                   :deadline today
                                   :order 2)
                            (:name "Scheduled Soon"
                                   :scheduled future
                                   :order 8)
                            (:name "Reschedule"
                                   :scheduled past
                                   :order 8)
                            (:name "Waiting"
                                   :todo "WAIT"
                                   :order 8)
                            (:name "Overdue"
                                   :deadline past
                                   :order 7)
                            (:name "Meetings"
                                   :and (:todo "MEET" :scheduled future)
                                   :order 10)
                            (:discard (:not (:todo "TODO")))))))))))
  :config
  (org-super-agenda-mode))
