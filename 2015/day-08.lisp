(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(use-package :arrow-macros)

(defpackage AoC-2015-08
  (:use :cl))

(in-package :AoC-2015-08)

(defun get-test-input ()
  (uiop:read-file-lines "input/day-08-test.txt"))

(defun get-input ()
  (uiop:read-file-lines "input/day-08.txt"))

(defun memory-length (line)
  (let ((i 1) (len 0))
    (loop while (< i (1- (length line))) do
      (if (char= (char line i) #\\)
          (cond ((char= (char line (1+ i)) #\x) (incf i 4))
                (t (incf i 2)))
          (incf i 1))
      (incf len))
    len))

(defun solve-1 (input)
  (loop for line in input
        sum (- (length line) (memory-length line))))

(defun encoded-length (line)
  (let ((i 0) (len 4))
    (loop while (< i (length line)) do
      (if (char= (char line i) #\\)
          (cond ((char= (char line (1+ i)) #\x)
                 (incf len 4) (incf i 4))
                (t (incf len 3) (incf i 2)))
          (incf i 1))
      (incf len))
    len))

(defun solve-2 (input)
  (loop for line in input
        sum (- (encoded-length line) (length line))))
