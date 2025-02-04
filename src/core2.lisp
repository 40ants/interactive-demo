(uiop:define-package #:interactive-demo
  (:use #:cl)
  (:import-from #:cl-raylib
                #:+red+
                #:+maroon+
                #:+darkgray+
                #:draw-fps
                #:draw-text
                #:draw-grid
                #:draw-cube-wires
                #:draw-cube
                #:with-mode-3d
                #:+raywhite+
                #:clear-background
                #:with-drawing
                #:window-should-close
                #:set-target-fps
                #:with-window
                #:make-camera3d)
  (:import-from #:3d-vectors
                #:vec)
  (:import-from #:40ants-slynk)
  (:nicknames #:interactive-demo/core)
  (:export #:hello
           #:make-hello
           #:say
           #:main))
(in-package #:interactive-demo)


(defclass object ()
  ((position :initarg :pos
             :accessor object-position)
   (color :initarg :color
          :accessor object-color)
   (size :initarg :size
         :type float
         :initform 2.0
         :accessor object-size)
   (relative-speed :initform 1.0
                   :type float
                   :reader relative-speed)
   (distance-from-center :initarg :distance
                         :type float
                         :initform 3.0
                         :accessor object-distance)))


(defmethod print-object ((obj object) stream)
  (print-unreadable-object (obj stream)
    (format stream "COLOR=~A"
            (object-color obj))))

(defparameter *welcome-text*
  "Welcome to the image-based development!")

(defparameter *cube-pos*
  (vec 0.0 0.0 0.0))


(defvar *world* nil)


(defparameter *camera* nil)

(defparameter *speed* 0.000001)


(defun draw-object (obj)
  (draw-cube (object-position obj)
             (object-size obj)
             (object-size obj)
             (object-size obj)
             (object-color obj))
  (draw-cube-wires (object-position obj)
                   (+ (object-size obj)
                      0.1)
                   (+ (object-size obj)
                      0.1)
                   (+ (object-size obj)
                      0.1)
                   +maroon+)



  
  (let* ((base-distance (object-distance obj))
         (distance
           (+ base-distance
              (sin (* (/ (get-internal-real-time)
                         internal-time-units-per-second)
                      10))))
         (speed (* *speed*
                   (relative-speed obj)))
         (x (* distance
               (cos (* (get-internal-real-time)
                       speed))))
         (y (* distance
               (sin (* (get-internal-real-time)
                       speed))))
         (z 0)
         (new-pos (vec x y z)))
    (setf (object-position obj)
          new-pos)))







(defun draw-object (obj)
  (draw-cube (object-position obj)
             (object-size obj)
             (object-size obj)
             (object-size obj)
             (object-color obj))
  (draw-cube-wires (object-position obj)
                   (+ (object-size obj)
                      0.1)
                   (+ (object-size obj)
                      0.1)
                   (+ (object-size obj)
                      0.1)
                   +maroon+)

  (let* ((base-distance (object-distance obj))
         (distance (+ base-distance
                      (sin (* (/ (get-internal-real-time)
                                 internal-time-units-per-second)
                              10))))
         (speed (* *speed*
                   (relative-speed obj)))
         (x (* distance
               (cos (* (get-internal-real-time)
                       speed))))
         (y (* distance
               (sin (* (get-internal-real-time)
                       speed))))
         (z 0)
         (new-pos (vec x y z)))
    (setf (object-position obj)
          new-pos)))


(defun draw-world ()
  (loop for obj in *world*
        do (draw-object obj)))


(defun game-loop ()
  (let* ((screen-width
           (parse-integer (or (uiop:getenv "WIDTH")
                              "1000")))
         (screen-height
           (parse-integer (or (uiop:getenv "HEIGHT")
                              "1000")))
         (title "Image-based Common Lisp Development Demo")
         (camera-pos (vec 0.0 0.0 10.0))
         (camera-target (vec 0.0 0.0 0.0))
         (camera-up (vec 0.0 1.0 0.0))
         (camera (make-camera3d
                  :position camera-pos
                  :target camera-target
                  :up camera-up
                  :fovy 90
                  :projection cl-raylib:+camera-perspective+)))
    ;; To be able to play with camera position
    (setf *camera* camera)
    
    (with-window (screen-width screen-height title)
      (set-target-fps 60)
      (loop
        ;; dectect window close button or ESC key
        (when (window-should-close)
          (return))

        (with-drawing
          (clear-background +raywhite+)
          (with-mode-3d (camera)
            (draw-world))

          (draw-text *welcome-text* 10 40 20 +darkgray+)
          (draw-fps 10 10))))))


(defun init-world ()
  (setf *world*
        (list
         (make-instance 'object
                        :pos (vec 0 0 0)
                        :color raylib:+red+
                        :distance 1.0
                        :size 2.0)
         (make-instance 'object
                        :pos (vec 0 0 0)
                        :color raylib:+green+
                        :distance 4.0
                        :size 1.0)
         ;; (make-instance 'object
         ;;                :pos (vec 3 4 0)
         ;;                :color raylib:+blue+
         ;;                :distance 7.0
         ;;                :size 0.5)
         )))


(defun main ()
  (40ants-slynk:start-slynk-if-needed)
  (init-world)
  (game-loop))
