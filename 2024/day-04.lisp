(ql:quickload :uiop)
(ql:quickload :serapeum)
(serapeum:toggle-pretty-print-hash-table)

(defpackage 2024-day-4 (:use :cl))
(in-package :2024-day-4)

(defun get-input ()
  (uiop:read-file-lines "input/day-04-input.txt"))

(defun make-matrix ()
  (let* ((input (get-input))
         (m (make-hash-table :test 'equal)))
    (loop for r from 0 below (length input)
          for row = (coerce (nth r input) 'list) do
            (loop for i from 0 below (length row)
                  for value = (nth i row) do
                    (setf (gethash (complex r i) m) value)))
    m))

(defun check-1 (m key delta)
  (let ((xmas '(#\X #\M #\A #\S))
        (a (list (gethash key m))))
    (loop for n from 1 to 3
          for value = (gethash (incf key delta) m)
          do (push value a))
    (equal a xmas)))

(defun part-1 ()
  (let* ((m (make-matrix))
         (deltas (list #C(-1 -1) #C(1 1) #C(1 -1) #C(-1 1)
                       #C(-1 0) #C(0 -1) #C(0 1) #C(1 0)))
         (search (loop for key being the hash-key of m
                       append
                       (loop for delta in deltas
                             collect (check-1 m key delta)))))
    (count t search)))

(defun check-2 (m key1)
  (let ((key2 (+ key1 #C(0 2)))
        (mas '(#\M #\A #\S))
        (a nil) (b nil))
    (loop for n from 0 to 2
          do (push (gethash (+ key1 (* n #C(1 1))) m) a)
             (push (gethash (+ key2 (* n #C(1 -1))) m) b))
    (and (or (equal a mas) (equal (reverse a) mas))
         (or (equal b mas) (equal (reverse b) mas)))))

(defun part-2 ()
  (let* ((m (make-matrix))
         (search (loop for key being the hash-key of m
                       collect (check-2 m key))))
    (count t search)))
