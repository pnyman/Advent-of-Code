(ql:quickload :uiop)
(ql:quickload :str)
;; (ql:quickload :arrow-macros)

(defpackage 2024-day-1
  (:use :cl))
(in-package :2024-day-1)

(defun get-input ()
  (let ((lines (uiop:read-file-lines "input/day-01-input.txt")))
    (loop for line in lines
          for words = (str:words line)
          collect (parse-integer (first words)) into a
          collect (parse-integer (second words)) into b
          finally (return (list a b)))))

(defun part-1 ()
  (destructuring-bind (a b) (get-input)
    (loop for m in (sort a #'<)
          for n in (sort b #'<)
          sum (abs (- m n)))))

(defun part-2 ()
  (let ((h (make-hash-table)))
    (destructuring-bind (a b) (get-input)
      (loop for n in b do
        (incf (gethash n h 0)))
      (loop for n in a
            sum (* n (gethash n h 0))))))
