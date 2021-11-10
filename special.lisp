(defpackage #:paras/special
  (:import-from #:cl
                #:defmacro)
  (:export #:quote))
(in-package #:paras/special)

(defmacro quote (form)
  `(cl:quote ,form))
