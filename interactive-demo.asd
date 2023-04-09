#-asdf3.1 (error "interactive-demo requires ASDF 3.1 because for lower versions pathname does not work for package-inferred systems.")
(defsystem "interactive-demo"
  :description "A demo of interactive image based development in Common Lisp, created specially for YouTube video."
  :author "Alexander Artemenko <svetlyak.40wt@gmail.com>"
  :license "Unlicense"
  :homepage "https://40ants.com/interactive-demo/"
  :source-control (:git "https://github.com/40ants/interactive-demo")
  :bug-tracker "https://github.com/40ants/interactive-demo/issues"
  :class :40ants-asdf-system
  :defsystem-depends-on ("40ants-asdf-system")
  :pathname "src"
  :depends-on ("interactive-demo/core")
  :in-order-to ((test-op (test-op "interactive-demo-tests"))))
