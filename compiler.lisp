(defpackage #:paras/compiler
  (:use #:cl
        #:paras/errors
        #:paras/types)
  (:shadowing-import-from #:paras/errors
                          #:end-of-file
                          #:undefined-function)
  (:import-from #:paras/builtin)
  (:import-from #:paras/user)
  (:export #:compiled-form
           #:compiled-form-bindings
           #:compiled-form-body
           #:compile-code))
(in-package #:paras/compiler)

(defstruct compiled-form
  bindings
  body)

(defun package-external-symbols (package)
  (let ((symbols '()))
    (do-external-symbols (s package symbols)
      (push s symbols))))

(defun function-allowed-p (function-name)
  (let ((package (symbol-package function-name)))
    (when (find (package-name package)
                (cons "PARAS/BUILTIN" paras/builtin:*modules*)
                :test #'string=)
      (do-external-symbols (symbol package)
        (when (eq symbol function-name)
          (return-from function-allowed-p t))))))

(defun compile-code (code &optional (bindings '()))
  (let ((*package* (find-package '#:paras-user)))
    (labels ((recur (code)
               (typecase code
                 (cons
                  (let ((fn (first code)))
                    (unless (and (symbolp fn)
                                 (handler-case (symbol-function fn)
                                   (cl:undefined-function () nil))
                                 (function-allowed-p fn))
                      ;; The function is not allowed to be called.
                      (error 'undefined-function :name fn))
                    (macroexpand
                     (cons fn
                           (mapcar #'recur (rest code))))))
                 (paras-variable-type
                  (handler-case (symbol-value code)
                    (cl:unbound-variable ()
                      (error 'undefined-variable :name code)))
                  code)
                 (paras-constant-type code)
                 (otherwise (error 'type-not-allowed :value code)))))
      (make-compiled-form
       :bindings bindings
       :body
       (progv
           (mapcar #'car bindings)
           (mapcar #'cdr bindings)
         (recur code))))))
