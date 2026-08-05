(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(use-package :arrow-macros)

(defpackage AoC-2015-17
  (:use :cl))

(in-package :AoC-2015-17)

(defun get-input ()
  (mapcar #'parse-integer
          (uiop:read-file-lines "input/day-17.txt")))
