(defpackage #:paras/modules/core
  (:import-from #:cl
                #:defun
                #:defmacro
                #:&rest
                #:&body
                #:&optional
                #:apply)
  (:export #:equal
           #:not
           #:and
           #:or
           #:<
           #:<=
           #:>
           #:>=
           #:floor
           #:+
           #:-
           #:*
           #:if
           #:when
           #:progn
           #:let))
(in-package #:paras/modules/core)

;;
;; Conditions

(defun equal (x y)
  (cl:equal x y))

(defun not (object)
  (cl:not object))

(defmacro and (&rest forms)
  `(cl:and ,@forms))

(defmacro or (&rest forms)
  `(cl:or ,@forms))

(defun < (number &rest more-numbers)
  (apply #'cl:< number more-numbers))

(defun <= (number &rest more-numbers)
  (apply #'cl:<= number more-numbers))

(defun > (number &rest more-numbers)
  (apply #'cl:> number more-numbers))

(defun >= (number &rest more-numbers)
  (apply #'cl:>= number more-numbers))

;;
;; Operators

(defun + (number &rest more-numbers)
  (apply #'cl:+ number more-numbers))

(defun - (number &rest more-numbers)
  (apply #'cl:- number more-numbers))

(defun * (number &rest more-numbers)
  (apply #'cl:* number more-numbers))

(defun floor (number)
  (cl:nth-value 0 (cl:floor number)))

;;
;; Controls

(defmacro if (test then &optional else)
  `(cl:if ,test ,then ,else))

(defmacro when (test &body forms)
  `(cl:when ,test ,@forms))

(defmacro progn (&body forms)
  `(cl:progn ,@forms))

(defmacro let ((&rest bindings) &body forms)
  `(cl:let* ,bindings ,@forms))
