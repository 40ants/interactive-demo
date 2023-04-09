(defsystem "interactive-demo-docs"
  :author "Alexander Artemenko <svetlyak.40wt@gmail.com>"
  :license "Unlicense"
  :homepage "https://40ants.com/lisp-interactive-demo/"
  :class :package-inferred-system
  :description "Provides documentation for interactive-demo."
  :source-control (:git "https://github.com/40ants/lisp-interactive-demo")
  :bug-tracker "https://github.com/40ants/lisp-interactive-demo/issues"
  :pathname "docs"
  :depends-on ("interactive-demo"
               "interactive-demo-docs/index"))
