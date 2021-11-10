(defpackage #:paras/special
  (:import-from #:cl
                #:defmacro
                #:&body)
  (:export #:quote
           #:lambda))
(in-package #:paras/special)

(defmacro quote (form)
  `(cl:quote ,form))

(defmacro lambda (lambda-list &body forms)
  `(cl:lambda ,lambda-list ,@forms))
