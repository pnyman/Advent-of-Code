(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :serapeum)
(ql:quickload :arrow-macros)
(use-package :arrow-macros)

(defpackage AoC-2015-20
  (:use :cl))

(in-package :AoC-2015-20)

(defparameter *input* 34000000)

;;; part 1

(defun solve-1 (target)
  (let ((houses (make-array 1000000)))
    (loop for elf from 1 below (length houses) do
      (loop for house from elf below (length houses) by elf
            do (incf (aref houses house) (* 10 elf))))
    (loop for house from 1 below (length houses)
          when (>= (aref houses house) target)
            return house)))

;;; part 2

(defun solve-2 (target)
  (let ((houses (make-array 1000000))
        (elves (make-array 1000000)))
    (loop for elf from 1 below (length houses) do
      (loop for house from elf below (length houses) by elf
            when (< (aref elves elf) 50)
              do (incf (aref houses house) (* 11 elf))
                 (incf (aref elves elf))))
    (loop for house from 1 below (length houses)
          when (>= (aref houses house) target)
            return house)))
