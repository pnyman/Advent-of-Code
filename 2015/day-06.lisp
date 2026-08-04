(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(use-package :arrow-macros)

(defpackage AoC-2015-06
  (:use :cl))

(in-package :AoC-2015-06)

(defun get-input ()
  (uiop:read-file-lines "input/day-06.txt"))

(defun parse-line (line)
  (let ((line (str:split " " line))
        (start-x) (start-y)
        (stop-x) (stop-y))
    (when (> (length line) 4) (setf line (cdr line)))
    (destructuring-bind (x y) (str:split "," (second line))
      (setf start-x (parse-integer x)) (setf start-y (parse-integer y)))
    (destructuring-bind (x y) (str:split "," (fourth line))
      (setf stop-x (parse-integer x)) (setf stop-y (parse-integer y)))
    (list :action (read-from-string (car line))
          :start-x start-x :start-y start-y
          :stop-x stop-x :stop-y stop-y)))

(defun solve-1 (input)
  (let ((lights (make-array '(1000 1000) :element-type 'boolean :initial-element nil))
        (lit 0))
    (loop for line in input
          for foo = (parse-line line)
          for action = (getf foo :action) do
            (loop for x from (getf foo :start-x) to (getf foo :stop-x) do
              (loop for y from (getf foo :start-y) to (getf foo :stop-y) do
                (setf (aref lights x y)
                      (cond ((eq action 'on)  t)
                            ((eq action 'off) nil)
                            (t (not (aref lights x y))))))))

    (loop for x from 0 to 999 do
      (loop for y from 0 to 999
            when (aref lights x y)
              do (incf lit)))
    lit))

(defun solve-2 (input)
  (let ((lights (make-array '(1000 1000) :element-type 'integer :initial-element 0))
        (brightness 0))
    (loop for line in input
          for foo = (parse-line line)
          for action = (getf foo :action) do
            (loop for x from (getf foo :start-x) to (getf foo :stop-x) do
              (loop for y from (getf foo :start-y) to (getf foo :stop-y) do
                (setf (aref lights x y)
                      (cond ((eq action 'on) (1+ (aref lights x y)))
                            ((eq action 'off) (max (1- (aref lights x y)) 0))
                            (t (+ (aref lights x y) 2)))))))

    (loop for x from 0 to 999 do
      (loop for y from 0 to 999
            do (incf brightness (aref lights x y))))
    brightness))
