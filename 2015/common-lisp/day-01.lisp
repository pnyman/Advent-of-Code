(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(use-package :str)
(use-package :arrow-macros)

(defpackage AoC-2015-01
  (:use :cl))

(in-package :AoC-2015-01)

(defun get-input ()
  (uiop:read-file-line "input/day-01.txt"))

(defun solve-1 (input)
  (loop for char across input
        if (equal char #\() sum 1 else sum -1))

(defun solve-2 (input)
  (loop for char across input
        for n from 1
        if (equal char #\() sum 1 into floor
          else sum -1 into floor
        when (= floor -1)
          return n))
