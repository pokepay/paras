(uiop:define-package #:paras/builtin
  (:use #:paras/errors)
  (:import-from #:cl
                #:defmacro
                #:defvar
                #:&rest
                #:t
                #:nil)
  (:use-reexport #:paras/modules/core)
  (:export #:use
           #:t
           #:nil
           #:*modules*))
(cl:in-package #:paras/builtin)

(defvar *modules* '("PARAS/MODULES/CORE"))

(defmacro use (&rest modules)
  `(cl:progn
     ,@(cl:loop :for module :in modules
          :for package := (cl:format nil "~A/~A" :paras/modules module)
          :collect `(cl:if (asdf:find-system ,(cl:string-downcase package) nil)
                           (cl:progn
                             (asdf:load-system ,(cl:string-downcase package))
                             (cl:use-package ,package :paras-user)
                             (cl:push ,package *modules*))
                           (cl:error 'undefined-module :name ,module)))))
