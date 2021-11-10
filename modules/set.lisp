(defpackage #:paras/modules/set
  (:import-from #:cl
                #:defun)
  (:export #:intersection
           #:union
           #:difference))
(in-package #:paras/modules/set)

(defun intersection (list1 list2)
  (cl:intersection list1 list2 :test 'cl:equal))

(defun union (list1 list2)
  (cl:union list1 list2 :test 'cl:equal))

(defun difference (list1 list2)
  (cl:set-difference list1 list2 :test 'cl:equal))
