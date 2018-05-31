(defpackage #:paras
  (:nicknames #:paras/main)
  (:use #:cl
        #:paras/types)
  (:import-from #:paras/parser
                #:parse
                #:parse-string)
  (:import-from #:paras/compiler
                #:compile-code
                #:recompile-form
                #:compiled-form
                #:compiled-form-body)
  (:import-from #:paras/errors
                #:execution-error)
  (:export #:execute-form
           #:compile-code
           #:recompile-form
           #:parse
           #:parse-string))
(in-package #:paras)

(defun execute-form (form)
  (check-type form compiled-form)
  (let ((code (compiled-form-body form)))
    (handler-case
        (etypecase code
          (paras-form-type (eval code))
          (paras-variable-type (symbol-value code))
          (paras-constant-type code))
      (error (e) (error 'execution-error :internal-error e)))))
