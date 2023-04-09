(defsystem "interactive-demo-tests"
  :author "Alexander Artemenko <svetlyak.40wt@gmail.com>"
  :license "Unlicense"
  :homepage "https://40ants.com/interactive-demo/"
  :class :package-inferred-system
  :description "Provides tests for interactive-demo."
  :source-control (:git "https://github.com/40ants/interactive-demo")
  :bug-tracker "https://github.com/40ants/interactive-demo/issues"
  :pathname "t"
  :depends-on ("interactive-demo-tests/core")
  :perform (test-op (op c)
                    (unless (symbol-call :rove :run c)
                      (error "Tests failed"))))
