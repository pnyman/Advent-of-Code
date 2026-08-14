(ql:quickload :uiop)

(defpackage AoC-2015-17
  (:use :cl))

(in-package :AoC-2015-17)

(defun get-input ()
  (mapcar #'parse-integer
          (uiop:read-file-lines "../input/day-17.txt")))

(defun combinations (containers target &optional (count 0))
  (cond
    ((zerop target) (list count))
    ((or (null containers) (< target 0)) nil)
    (t (append
        (combinations (rest containers) (- target (first containers)) (1+ count))
        (combinations (rest containers) target count)))))

(defun solve-1 (containers &optional (target 150))
  (length (combinations containers target)))

(defun solve-2 (containers &optional (target 150))
  (let* ((results (combinations containers target)))
    (count (reduce #'min results) results)))
