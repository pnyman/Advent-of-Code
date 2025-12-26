(ql:quickload :uiop)
(ql:quickload :arrow-macros)
(ql:quickload :iterate)
(ql:quickload :str)

(defpackage 2025-day-4
  (:use :cl :arrow-macros :iterate))

(in-package :2025-day-4)

(defparameter *input* "../input/day-04-input.txt")

(defun get-input ()
  (let ((diagram (make-hash-table)))
    (iter (for line in (uiop:read-file-lines *input*))
          (for y from 0)
          (iter (for cell in-string line)
                (for x from 0)
                (setf (gethash (complex y x) diagram) (string= cell "@"))))
    diagram))

(defun check-adjacent (position diagram)
  (when (gethash position diagram)
    (let ((rolls))
      (iter (with deltas = '(-1 0 1))
            (for y in deltas)
            (iter (for x in deltas)
                  (push (gethash (+ position (complex y x)) diagram) rolls)))
      (<= (count-if #'identity rolls) 4))))

(defun part-1 ()
  (let ((diagram (get-input)))
    (iter (for (key nil) in-hashtable diagram)
          (counting (check-adjacent key diagram) into result)
          (finally (return result)))))

(defun part-2 ()
  (let ((diagram (get-input))
        (result 0)
        (continue t))
    (iter (while continue)
          (iter (for (key nil) in-hashtable diagram)
                (when (check-adjacent key diagram)
                  (collect key into acc))
                (finally (if acc
                             (progn
                               (incf result (length acc))
                               (iter (for key in acc)
                                     (setf (gethash key diagram) nil)))
                             (setf continue nil)))))
    result))
