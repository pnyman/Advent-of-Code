(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(use-package :arrow-macros)

(defpackage AoC-2016-02
  (:use :cl))

(in-package :AoC-2016-02)

(defun get-input ()
  (uiop:read-file-lines "../input/day-02.txt"))

(defparameter keypad
  (make-array '(3 3) :initial-contents
              '((1 2 3) (4 5 6) (7 8 9))))

(defparameter keypad2
  (make-array '(5 5) :initial-contents
              '(("" "" "1" "" "")
                ("" "2" "3" "4" "")
                ("5" "6" "7" "8" "9")
                ("" "A" "B" "C" "")
                ("" "" "D" "" ""))))

(defun solve-1 (input)
  (let ((row 1) (col 1) (code))
    (dolist (line input)
      (dolist (c (coerce line 'list))
        (case c
          (#\R (when (< col 2) (incf col)))
          (#\L (when (> col 0) (decf col)))
          (#\D (when (< row 2) (incf row)))
          (#\U (when (> row 0) (decf row)))))
      (push (aref keypad row col) code))
    (format nil "~{~a~}" (reverse code))))

(defun solve-2 (input)
  (let ((row 2) (col 1) (code))
    (dolist (line input)
      (dolist (c (coerce line 'list))
        (case c
          (#\R (and (< col 4) (plusp (length (aref keypad2 row (1+ col)))) (incf col)))
          (#\L (and (> col 0) (plusp (length (aref keypad2 row (1- col)))) (decf col)))
          (#\D (and (< row 4) (plusp (length (aref keypad2 (1+ row) col))) (incf row)))
          (#\U (and (> row 0) (plusp (length (aref keypad2 (1- row) col))) (decf row)))))
      (push (aref keypad2 row col) code))
    (format nil "~{~a~}" (reverse code))))
