(defpackage #:paras/modules/db
  (:use #:cl)
  (:import-from #:cl-dbi)
  (:export #:*db*
           #:fetch))
(in-package #:paras/modules/db)

(defvar *db*)

(defun fetch (sql &optional binds)
  (second
   (dbi:fetch
    (apply #'dbi:execute (dbi:prepare *db* sql) binds))))
