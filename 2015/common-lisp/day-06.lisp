(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(use-package :arrow-macros)

(defpackage AoC-2015-06
  (:use :cl))

(in-package :AoC-2015-06)

(defun get-input ()
  (uiop:read-file-lines "../input/day-06.txt"))

(defun parse-line (line)
  (let* ((line (reverse (str:words line)))
         (start (str:split "," (third line)))
         (stop (str:split "," (first line))))
    (list (read-from-string (fourth line))
          (parse-integer (first start)) (parse-integer (second start))
          (parse-integer (first stop)) (parse-integer (second stop)))))

(defun parse-line (line)
  (let* ((line (reverse (str:words line)))
         (start (str:split "," (third line)))
         (stop (str:split "," (first line))))
    (append (list (read-from-string (fourth line)))
            (mapcar #'parse-integer
                    (list (first start) (second start)
                          (first stop) (second stop))))))

(defun solve-1 (input)
  (let ((lights (make-array '(1000 1000) :element-type 'boolean :initial-element nil)))
    (loop for line in input
          for (action x1 y1 x2 y2) = (parse-line line) do
            (loop for x from x1 to x2 do
              (loop for y from y1 to y2 do
                (setf (aref lights x y)
                      (cond ((eq action 'on)  t)
                            ((eq action 'off) nil)
                            (t (not (aref lights x y))))))))
    (loop for x from 0 to 999
          sum (loop for y from 0 to 999
                    when (aref lights x y) sum 1))))

(defun solve-2 (input)
  (let ((lights (make-array '(1000 1000) :element-type 'integer :initial-element 0)))
    (loop for line in input
          for (action x1 y1 x2 y2) = (parse-line line) do
            (loop for x from x1 to x2 do
              (loop for y from y1 to y2 do
                (setf (aref lights x y)
                      (cond ((eq action 'on) (1+ (aref lights x y)))
                            ((eq action  'off) (max (1- (aref lights x y)) 0))
                            (t (+ (aref lights x y) 2)))))))
    (loop for x from 0 to 999
          sum (loop for y from 0 to 999 sum (aref lights x y)))))
