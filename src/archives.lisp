(in-package :coleslaw)

;;; Archives

(defclass archive-index () ())

(defmethod discover ((doc-type (eql (find-class 'archive-index))))
  (let ((content (by-date (find-all 'post))))
    (add-document (index-archives content))))

(defun index-archives (content)
  "Return Archives."
  (make-instance 'archive-index :slug "archives" :name "archives"
                 :content content :title "Blog Archives"))

(defmethod render ((object archive-index) &key prev next)
  (funcall (theme-fn 'archives) (list :tags (find-all 'tag-index)
                                   :months (find-all 'month-index)
                                   :config *config*
                                   :archives object
                                   :prev prev
                                   :next next)))

(defmethod publish ((doc-type (eql (find-class 'archive-index))))
  (dolist (archive (find-all 'archive-index))
    (write-document archive)))
