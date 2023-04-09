(defsystem "interactive-demo-ci"
  :author "Alexander Artemenko <svetlyak.40wt@gmail.com>"
  :license "Unlicense"
  :homepage "https://40ants.com/lisp-interactive-demo/"
  :class :package-inferred-system
  :description "Provides CI settings for interactive-demo."
  :source-control (:git "https://github.com/40ants/lisp-interactive-demo")
  :bug-tracker "https://github.com/40ants/lisp-interactive-demo/issues"
  :pathname "src"
  :depends-on ("40ants-ci"
               "interactive-demo-ci/ci"))
