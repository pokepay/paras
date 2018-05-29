(defpackage #:paras/errors
  (:use #:cl)
  (:shadow #:end-of-file
           #:undefined-function)
  (:export #:paras-error
           #:parser-error
           #:type-not-allowed
           #:end-of-file
           #:compilation-error
           #:undefined-function
           #:undefined-variable
           #:undefined-module
           #:execution-error))
(in-package #:paras/errors)

(define-condition paras-error (error) ())

(define-condition parser-error (paras-error)
  ((error :initarg :error))
  (:report (lambda (condition stream)
             (format stream
                     "Parser error: ~A"
                     (class-name (class-of (slot-value condition 'error)))))))

(define-condition type-not-allowed (parser-error)
  ((value :initarg :value))
  (:report (lambda (condition stream)
             (format stream
                     "Type '~A' of '~S' is not allowed"
                     (type-of (slot-value condition 'value))
                     (slot-value condition 'value)))))

(define-condition end-of-file (parser-error)
  ()
  (:report (lambda (condition stream)
             (declare (ignore condition))
             (format stream "End of file"))))

(define-condition compilation-error (paras-error) ())

(define-condition undefined-function (compilation-error)
  ((name :initarg :name))
  (:report (lambda (condition stream)
             (format stream
                     "Function '~S' is not defined"
                     (slot-value condition 'name)))))

(define-condition undefined-variable (compilation-error)
  ((name :initarg :name))
  (:report (lambda (condition stream)
             (format stream
                     "Variable '~S' is not defined"
                     (slot-value condition 'name)))))

(define-condition undefined-module (compilation-error)
  ((name :initarg :name))
  (:report (lambda (condition stream)
             (format stream
                     "Unknown module: ~A" (slot-value condition 'name)))))

(define-condition execution-error (paras-error)
  ((internal-error :initarg :internal-error))
  (:report (lambda (condition stream)
             (let ((error (slot-value condition 'internal-error)))
               (format stream "Error (~A): ~A"
                       (type-of error)
                       error)))))
