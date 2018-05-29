(defsystem "paras"
  :class :package-inferred-system
  :version "0.0.1"
  :author "Eitaro Fukamachi"
  :description "Embeded trivial Lisp interpreter"
  :depends-on ("paras/main")
  :in-order-to ((test-op (test-op "paras/tests"))))

(defsystem "paras/tests"
  :class :package-inferred-system
  :depends-on ("rove"
               "paras/tests/parser"
               "paras/tests/compiler"
               "paras/tests/main")
  :perform (test-op (o c) (symbol-call :rove '#:run c)))
