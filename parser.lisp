(defpackage #:paras/parser
  (:use #:cl
        #:paras/types)
  (:shadowing-import-from #:paras/special
                          #:quote
                          #:lambda)
  (:shadowing-import-from #:paras/errors
                          #:parser-error
                          #:end-of-file
                          #:undefined-function)
  (:import-from #:paras/user
                #:%
                #:%1
                #:%2
                #:%3
                #:%4
                #:%5)
  (:import-from #:named-readtables
                #:defreadtable
                #:find-readtable)
  (:export #:parse-string
           #:parse))
(in-package #:paras/parser)

(defun quote-reader (stream char)
  `(quote ,(read stream t nil t)))

(defun maptree (fn tree)
  (labels ((rec (tree)
             (etypecase tree
               (atom (funcall fn tree))
               (cons (cons (rec (car tree))
                           (if (cdr tree)
                               (rec (cdr tree))
                               nil))))))
    (if (null tree)
        nil
        (rec tree))))

(defvar *in-lambda-reader* nil)

(defun lambda-reader (stream char)
  (when *in-lambda-reader*
    (error "Nested ~A()s are not allowed" char))
  (let ((form (let ((*in-lambda-reader* t))(read stream t nil t)))
        (args (make-array 5 :element-type 'bit :initial-element 0))
        (restargs (gensym))
        (%-used nil))
    (flet ((add-arg (n)
             (setf (aref args (1- n)) 1)))
      (let ((form
              (maptree (lambda (x)
                         (case x
                           (%
                            (add-arg 1)
                            (setf %-used t))
                           ((%1 %2 %3 %4 %5)
                            (add-arg
                             (parse-integer (subseq (string x) 1)))))
                         x)
                       form))
            (lambda-list '())
            (ignored-args '()))
        (dotimes (i (1+ (or (position 1 args :from-end t)
                            -1)))
          (when (zerop (aref args i))
            (push (intern (format nil "%~D" (1+ i))) ignored-args))
          (push (intern (format nil "%~D" (1+ i))) lambda-list))
        `(lambda (,@(nreverse lambda-list) &rest ,restargs ,@(and %-used '(&aux (% %1))))
           (declare (ignore ,restargs ,@(nreverse ignored-args)))
           ,form)))))

(defreadtable paras
  (:macro-char #\( (get-macro-character #\())
  (:macro-char #\) (get-macro-character #\)))
  (:macro-char #\" (get-macro-character #\"))
  (:macro-char #\' #'quote-reader)
  (:macro-char #\^ #'lambda-reader))

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
