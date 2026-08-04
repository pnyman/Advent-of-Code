(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(use-package :str)
(use-package :arrow-macros)

(defpackage AoC-2015-02
  (:use :cl))

(in-package :AoC-2015-02)

(defun get-input ()
  (uiop:read-file-lines "input/day-02.txt"))

(defun solve-1 (input)
  (loop for line in input
        for (l w h) = (mapcar #'parse-integer (str:split "x" line))
        for (a b c) = (list (* l w) (* w h) (* h l))
        sum (+ (* 2 (+ a b c)) (min a b c))))

(defun solve-2 (input)
  (loop for line in input
        for (l w h) = (mapcar #'parse-integer (str:split "x" line))
        for (a b) = (remove (max l w h) (list l w h) :count 1)
        sum (+ (* 2 (+ a b)) (* l w h))))
