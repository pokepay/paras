(uiop:define-package #:paras/builtin
  (:use #:paras/errors)
  (:import-from #:cl
                #:defun
                #:defmacro
                #:defvar
                #:&rest
                #:t
                #:nil)
  (:use-reexport #:paras/modules/core)
  (:export #:use
           #:require
           #:t
           #:nil
           #:*modules*))
(cl:in-package #:paras/builtin)

(defvar *modules* '("PARAS/MODULES/CORE"))

(defun require-module-package (module)
  (cl:assert (cl:keywordp module))
  (cl:labels ((load-package (package)
                (cl:cond
                  ((cl:find package *modules* :test 'equal)
                   package)
                  ((cl:find-package package)
                   #+sbcl (sb-ext:add-package-local-nickname module (cl:find-package package) :paras-user)
                   (cl:push package *modules*)
                   package)
                  ((asdf:find-system (cl:string-downcase package) nil)
                   (asdf:load-system (cl:string-downcase package))
                   #+sbcl (sb-ext:add-package-local-nickname module (cl:find-package package) :paras-user)
                   (cl:push package *modules*)
                   package)))
              (load-module (module-name)
                (cl:or (load-package (cl:format nil "~A/~A" :paras/modules module-name))
                       (load-package module-name))))
    (load-module (cl:symbol-name module))))

(defun use-module-package (module)
  (cl:let ((package (require-module-package module)))
    (cl:when package
      (cl:use-package package :paras-user)
      package)))

(defmacro require (&rest modules)
  `(cl:progn
     ,@(cl:loop :for module :in modules
          :collect `(cl:or (require-module-package ,module)
                           (cl:error 'undefined-module :name ,module)))))

(defmacro use (&rest modules)
  `(cl:progn
     ,@(cl:loop :for module :in modules
          :collect `(cl:or (use-module-package ,module)
                           (cl:error 'undefined-module :name ,module)))))
