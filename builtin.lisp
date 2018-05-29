(uiop:define-package #:paras/builtin
  (:use #:paras/errors)
  (:import-from #:cl
                #:defmacro
                #:&rest
                #:t
                #:nil)
  (:use-reexport #:paras/modules/core)
  (:export #:use
           #:t
           #:nil))
(cl:in-package #:paras/builtin)

(defmacro use (&rest modules)
  `(cl:use-package
     ',@(cl:loop :for module :in modules
           :for package := (cl:format nil "~A/~A" :paras/modules module)
           :if (cl:find-package package)
             :collect package
           :else
             :do (cl:error 'undefined-module :name module))))
