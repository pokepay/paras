(defpackage #:paras/tests/parser
  (:use #:cl
        #:rove
        #:paras/parser
        #:paras/errors)
  (:shadowing-import-from #:paras/errors
                          #:undefined-function
                          #:end-of-file))
(in-package #:paras/tests/parser)

(deftest can-parse-values
  (ok (= (parse-string "12") 12)
      "Can parse an integer")
  (ok (= (parse-string "3.14") 3.14)
      "Can parse a float")
  (ok (= (parse-string "-2") -2)
      "Can parse a negative integer")
  (ok (= (parse-string "+2") 2)
      "Can parse a positive integer")
  (ok (equal (parse-string "\"Hello\"") "Hello")
      "Can parse a string")
  (ok (equal (parse-string ":hello") :hello)
      "Can parse a keyword")
  (ok (eq (parse-string "t") t)
      "Can parse T")
  (ok (eq (parse-string "nil") nil)
      "Can parse NIL")
  (ok (eq (parse-string "a") 'paras/user::a)
      "Can parse a symbol")
  (ok (eq (parse-string "|a|") 'paras/user::|a|)
      "Can parse a symbol (with bars)")
  (ok (equal (parse-string "(hello world)")
             '(paras/user::hello paras/user::world))
      "Can parse a cons"))

(deftest cannot-parse-values
  (ok (signals (parse-string "a:b") 'parser-error)
      "Cannot parse a symbol (with package)"))

(deftest end-of-file-tests
  (ok (signals (parse-string "\"Hello") 'end-of-file)
      "Cannot parse an incomplete string")
  (ok (signals (parse-string "(hello") 'end-of-file)
      "Cannot parse an incomplete cons"))
