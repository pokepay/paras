(defpackage #:paras/parser
  (:use #:cl
        #:paras/types)
  (:shadowing-import-from #:paras/errors
                          #:parser-error
                          #:end-of-file
                          #:undefined-function)
  (:import-from #:paras/user)
  (:import-from #:named-readtables
                #:defreadtable
                #:find-readtable)
  (:export #:parse-string
           #:parse))
(in-package #:paras/parser)

(defreadtable paras
  (:macro-char #\( (get-macro-character #\())
  (:macro-char #\) (get-macro-character #\)))
  (:macro-char #\" (get-macro-character #\")))

(defun parse (&optional (stream *standard-input*))
  (let ((*readtable* (find-readtable 'paras))
        (*package* (find-package '#:paras-user)))
    (let ((code
            (handler-case
                (read stream)
              (cl:end-of-file ()
                (error 'end-of-file))
              (error (e)
                (error 'parser-error :error e)))))
      (unless (typep code 'paras-type)
        (error 'type-not-allowed :value code))
      code)))

(defun parse-string (code)
  (with-input-from-string (stream code)
    (parse stream)))
