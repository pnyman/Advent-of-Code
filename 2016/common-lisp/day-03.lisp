(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(use-package :arrow-macros)

(defpackage AoC-2016-03
  (:use :cl))

(in-package :AoC-2016-03)

(defun get-input ()
  (-<> "../input/day-03.txt"
    (uiop:read-file-lines)
    (mapcar (lambda (x) (mapcar #'parse-integer (str:words x))) <>)))

(defun triangle? (sides)
  (and (> (+ (first sides) (second sides)) (third sides))
       (> (+ (first sides) (third sides)) (second sides))
       (> (+ (second sides) (third sides)) (first sides))))

(defun solve-1 (input)
  (length (remove-if-not #'triangle? input)))

(defun solve-2 (input)
  (loop for row to (- (length input) 3) by 3
        sum (loop for col to 2
                  count (triangle? (list (nth col (nth row input))
                                         (nth col (nth (+ row 1) input))
                                         (nth col (nth (+ row 2) input)))))))
