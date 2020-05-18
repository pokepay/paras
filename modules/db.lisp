(defpackage #:paras/modules/db
  (:use #:cl)
  (:import-from #:cl-dbi)
  (:export #:*db*
           #:fetch
           #:execute))
(in-package #:paras/modules/db)

(defvar *db*)

(defun fetch (sql &optional binds)
  (second
   (dbi:fetch
    (dbi:execute (dbi:prepare *db* sql) binds))))

(defun execute (sql &optional binds)
  (dbi:do-sql *db* sql binds))
