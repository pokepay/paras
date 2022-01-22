(defpackage #:paras/modules/time
  (:use #:cl)
  (:export #:now
           #:year-of
           #:month-of
           #:day-of
           #:hour-of
           #:minute-of
           #:second-of
           #:zone-of
           #:day-of-week))
(in-package #:paras/modules/time)

(defstruct timestamp
  year
  month
  day
  hour
  minute
  second
  zone
  daylight-p
  day-of-week)

(defun now ()
  (multiple-value-bind (second minute hour day month year day-of-week daylight-p zone)
      (decode-universal-time (get-universal-time))
    (make-timestamp
     :year year
     :month month
     :day day
     :hour hour
     :minute minute
     :second second
     :day-of-week day-of-week
     :daylight-p daylight-p
     :zone zone)))

(defun year-of (time) (timestamp-year time))
(defun month-of (time) (timestamp-month time))
(defun day-of (time) (timestamp-day time))
(defun hour-of (time) (timestamp-hour time))
(defun minute-of (time) (timestamp-minute time))
(defun second-of (time) (timestamp-second time))
(defun zone-of (time) (timestamp-zone time))
(defun day-of-week (time)
  (aref #("Mon" "Tue" "Wed" "Thu" "Fri" "Sat" "Sun") (timestamp-day-of-week time)))
