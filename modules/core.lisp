(defpackage #:paras/modules/core
  (:import-from #:cl
                #:defun
                #:defmacro
                #:&rest
                #:&optional
                #:apply)
  (:export #:equal
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
           #:progn))
(in-package #:paras/modules/core)

;;
;; Conditions

(defun equal (x y)
  (cl:equal x y))

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

(defmacro progn (&rest forms)
  `(cl:progn ,@forms))
