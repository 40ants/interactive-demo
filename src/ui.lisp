(uiop:define-package #:interactive-demo/ui
  (:use #:cl)
  (:import-from #:ltk
                #:with-ltk)
  (:import-from #:serapeum
                #:maphash-new
                #:->)
  (:import-from #:interactive-demo
                #:object-color
                #:*color-names*
                #:object-size
                #:object-distance
                #:size
                #:object))
(in-package #:interactive-demo/ui)

(setf ltk:*wish-pathname*
      "/nix/store/43k72f6ihyi9b1l55k0l4sbrm8ffc917-tk-8.6.13/bin/wish")


(defparameter *color-codes*
  (maphash-new (lambda (key value)
                 (values value key))
               *color-names*))

(-> show-ui (object) t)

(defun show-ui (obj)
  (with-ltk ()
    (let ((size-scale
            (make-instance 'ltk:scale
                           :master nil
                           :from 0
                           :to 10
                           :length 150
                           :variable "foo"
                           :command (lambda (value)
                                      (setf (object-size obj)
                                            value))))
          (distance-scale
            (make-instance 'ltk:scale
                           :master nil
                           :from 0
                           :to 7
                           :length 150
                           :command (lambda (value)
                                      (setf (object-distance obj)
                                            value)))))
      (ltk:pack
       (make-instance 'ltk:label
                      :text "Размер:"))
      (setf (ltk:value size-scale)
            (object-size obj))
      (ltk:pack size-scale)
      
      (ltk:pack
       (make-instance 'ltk:label
                      :text "Расстояние от центра:"))
      (setf (ltk:value distance-scale)
            (object-distance obj))
      (ltk:pack distance-scale)

      (ltk:pack
       (make-instance 'ltk:label
                      :text "Цвет"))
      (let ((combo (make-instance 'ltk:combobox
                                  :values '("red" "green" "blue")
                                  :state :readonly)))
        (setf (ltk:text combo)
              (gethash (object-color obj)
                       *color-names*))
        
        (ltk:bind combo "<<ComboboxSelected>>"
          (lambda (event)
            (declare (ignore event))
            
            (let ((value (ltk:text combo)))
              (setf (object-color obj)
                    (gethash value
                             *color-codes*)))))
        (ltk:pack combo)))))
