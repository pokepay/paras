(defpackage #:paras/modules/list
  (:import-from #:cl
                #:defun
                #:&rest
                #:apply
                #:check-type)
  (:export #:map
           #:list
           #:length
           #:includes
           #:sum))
(in-package #:paras/modules/list)

(defun list (&rest values)
  (apply #'cl:list values))

(defun map (fn &rest lists)
  (apply #'cl:mapcar fn lists))

(defun length (list)
  (check-type list cl:list)
  (cl:list-length list))

(defun includes (list value)
  (check-type list cl:list)
  (cl:find value list :test 'cl:equal))

(defun sum (values)
  (check-type values cl:list)
  (cl:reduce #'cl:+ values))
