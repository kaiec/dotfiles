;;; my-roam-agenda.el -*- lexical-binding: t; -*-


(provide 'my-roam-agenda)

(defun roam-extra:get-filetags ()
  (split-string (or (org-roam-get-keyword "filetags") "")))

(defun roam-extra:add-filetag (tag)
  (let* ((new-tags (cons tag (roam-extra:get-filetags)))
         (new-tags-str (combine-and-quote-strings new-tags)))
    (org-roam-set-keyword "filetags" new-tags-str)))

(defun roam-extra:del-filetag (tag)
  (let* ((new-tags (seq-difference (roam-extra:get-filetags) `(,tag)))
         (new-tags-str (combine-and-quote-strings new-tags)))
    (org-roam-set-keyword "filetags" new-tags-str)))


(defun roam-extra:todo-p ()
  "Return non-nil if current buffer has any TODO entry.

TODO entries marked as done are ignored, meaning the this
function returns nil if current buffer contains only completed
tasks."
  (org-element-map
      (org-element-parse-buffer 'headline)
      'headline
    (lambda (h)
      (eq (org-element-property :todo-type h)
          'todo))
    nil 'first-match))

(defun roam-extra:update-todo-tag ()
  "Update TODO tag in the current buffer."
  (when (and (not (active-minibuffer-window))
             (org-roam-file-p))
    (org-with-point-at 1
      (let* ((tags (roam-extra:get-filetags))
             (is-todo (roam-extra:todo-p)))
        (cond ((and is-todo (not (seq-contains-p tags "todo")))
               (roam-extra:add-filetag "todo"))
              ((and (not is-todo) (seq-contains-p tags "todo"))
               (roam-extra:del-filetag "todo")))))))

(defun roam-extra:todo-files ()
  "Return a list of roam files containing todo tag."
  (org-roam-db-sync)
  (let ((todo-nodes (seq-filter (lambda (n)
                                  (seq-contains-p (org-roam-node-tags n) "todo"))
                                 (org-roam-node-list))))
    (seq-uniq (seq-map #'org-roam-node-file todo-nodes))))

(defun roam-extra:update-todo-files (&rest _)
  "Update the value of `org-agenda-files'."
  (setq org-agenda-files (roam-extra:todo-files)))

(add-to-list 'org-tags-exclude-from-inheritance "todo")
(add-hook 'find-file-hook #'roam-extra:update-todo-tag)
(add-hook 'before-save-hook #'roam-extra:update-todo-tag)
(advice-add 'org-agenda :before #'roam-extra:update-todo-files)
