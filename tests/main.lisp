(defpackage #:paras/tests/main
  (:use #:cl
        #:rove
        #:paras/main))
(in-package #:paras/tests/main)

(deftest execution-tests
  (ok (= (execute-form (compile-code (parse-string "12"))) 12)
      "Can execute an integer")
  (ok (= (execute-form (compile-code (parse-string "3.14"))) 3.14)
      "Can execute a float")
  (ok (string= (execute-form (compile-code (parse-string "\"Hello\""))) "Hello")
      "Can execute a string")
  (ok (eq (execute-form (compile-code (parse-string ":hello"))) :hello)
      "Can execute a keyword")
  (ok (eq (execute-form (compile-code (parse-string "t"))) t)
      "Can execute T")
  (ok (eq (execute-form (compile-code (parse-string "nil"))) nil)
      "Can execute NIL")
  (ok (eq (execute-form (compile-code (parse-string "(equal 1 2)"))) nil)
      "Can execute a form"))
