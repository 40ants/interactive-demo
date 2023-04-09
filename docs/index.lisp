(uiop:define-package #:interactive-demo-docs/index
  (:use #:cl)
  (:import-from #:pythonic-string-reader
                #:pythonic-string-syntax)
  #+quicklisp
  (:import-from #:quicklisp)
  (:import-from #:named-readtables
                #:in-readtable)
  (:import-from #:40ants-doc
                #:defsection
                #:defsection-copy)
  (:import-from #:interactive-demo-docs/changelog
                #:@changelog)
  (:import-from #:docs-config
                #:docs-config)
  (:export #:@index
           #:@readme
           #:@changelog))
(in-package #:interactive-demo-docs/index)

(in-readtable pythonic-string-syntax)


(defmethod docs-config ((system (eql (asdf:find-system "interactive-demo-docs"))))
  ;; 40ANTS-DOC-THEME-40ANTS system will bring
  ;; as dependency a full 40ANTS-DOC but we don't want
  ;; unnecessary dependencies here:
  #+quicklisp
  (ql:quickload "40ants-doc-theme-40ants")
  #-quicklisp
  (asdf:load-system "40ants-doc-theme-40ants")
  
  (list :theme
        (find-symbol "40ANTS-THEME"
                     (find-package "40ANTS-DOC-THEME-40ANTS")))
  )


(defsection @index (:title "interactive-demo - A demo of interactive image based development in Common Lisp, created specially for YouTube video."
                    :ignore-words ("JSON"
                                   "HTTP"
                                   "TODO"
                                   "Unlicense"
                                   "REPL"
                                   "GIT"))
  (interactive-demo system)
  "
[![](https://github-actions.40ants.com/40ants/lisp-interactive-demo/matrix.svg?only=ci.run-tests)](https://github.com/40ants/lisp-interactive-demo/actions)

![Quicklisp](http://quickdocs.org/badge/interactive-demo.svg)
"
  (@installation section))


(defsection-copy @readme @index)


(defsection @installation (:title "Installation")
  """
To build this project, you'll need a Qlot and Roswell, because CL-RAYLIB should be installed from Ultralisp.org.

Having Qlot and Roswell installed, run these steps to build a demo:

```
qlot install
qlot exec ros build roswell/demo.ros
```

Now you can run the demo:

```
SLYNK_PORT=7000 roswell/demo
```

Connect to it using SLY and play with content of the `src/core.lisp` file.
""")


(defsection @demo (:title "Demo")
  """
Here is how this demo looks like:

![](demo.gif)
""")
