(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(use-package :arrow-macros)

(defpackage AoC-2015-10
  (:use :cl))

(in-package :AoC-2015-10)

(defparameter *input* '(1 1 1 3 1 2 2 1 1 3))

(defun look-and-say (input)
  (if (= (length input) 1)
      (list 1 (car input))
      (let ((ctr 1)
            (previous (car input))
            (acc nil))
        (loop for n in (cdr input)
              do (if (= n previous)
                     (incf ctr)
                     (progn (push ctr acc)
                            (push previous acc)
                            (setf previous n)
                            (setf ctr 1)))
              finally (push ctr acc)
                      (push n acc))
        (reverse acc))))

(defun solve (input nr)
  (loop for i from 1 to nr do
    (setf input (look-and-say input)))
  (length input))
