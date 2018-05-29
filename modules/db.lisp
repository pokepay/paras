(defpackage #:paras/modules/db
  (:use #:cl)
  (:import-from #:cl-dbi)
  (:export #:*db*
           #:db-fetch))
(in-package #:paras/modules/db)

(defvar *db*)

(defun db-fetch (sql &optional binds)
  (second
   (dbi:fetch
    (apply #'dbi:execute (dbi:prepare *db* sql) binds))))
