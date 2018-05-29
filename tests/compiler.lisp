(defpackage #:paras/tests/compiler
  (:use #:cl
        #:rove
        #:paras/compiler)
  (:shadowing-import-from #:paras/errors
                          #:undefined-function
                          #:undefined-variable))
(in-package #:paras/tests/compiler)

(deftest compilation-tests
  (ok (typep (compile-code 12) 'compiled-form)
      "Can compile an integer")
  (ok (typep (compile-code 3.14) 'compiled-form)
      "Can compile a float")
  (ok (typep (compile-code "Hello") 'compiled-form)
      "Can compile a string")
  (ok (typep (compile-code :hello) 'compiled-form)
      "Can compile a keyword")
  (ok (typep (compile-code t) 'compiled-form)
      "Can compile T")
  (ok (typep (compile-code nil) 'compiled-form)
      "Can compile NIL")
  (ok (typep (compile-code '(paras/builtin:equal 1 2)) 'compiled-form)
      "Can compile a cons")
  (ok (signals (compile-code '(paras/builtin::undefined "should signal an error"))
          'undefined-function)
      "Undefined function")
  (ok (signals (compile-code 'a)
          'undefined-variable)
      "Undefined variable"))

#+todo
(deftest compilation-bindings-tests)
