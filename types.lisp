(defpackage #:paras/types
  (:use #:cl)
  (:export #:paras-type
           #:paras-variable-type
           #:paras-constant-type
           #:paras-form-type))
(in-package #:paras/types)

(deftype paras-constant-type ()
  '(or number string keyword boolean))

(deftype paras-variable-type ()
  'symbol)

(deftype paras-form-type ()
  'cons)

(deftype paras-type ()
  '(or
    paras-form-type
    paras-variable-type
    paras-constant-type))
