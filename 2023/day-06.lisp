(ql:quickload :uiop)
(ql:quickload :str)
(use-package :str)

(defpackage 2023-day-6
  (:use :cl))

(in-package :2023-day-6)

(defun get-input ()
  (let* ((input (uiop:read-file-lines "input/day-06-input-test.txt"))
         (times (split-omit-nulls " " (second (split ":" (first input)))))
         (distances (split-omit-nulls " " (second (split ":" (second input))))))
    (values times distances)))


(defun solve-1 ()
  (multiple-value-bind (times distances) (get-input)
    (let ((times (mapcar #'parse-integer times))
          (distances (mapcar #'parse-integer distances))
          (ways 1))
      (loop for time in times
            for dist in distances
            for wins = (loop for hold below time
                             count (> (* hold (- time hold)) dist))
            do (setf ways (* ways wins)))
      ways)))


(defun solve-2 ()
  (multiple-value-bind (times distances) (get-input)
    (let ((time (parse-integer (apply #'concatenate 'string times)))
          (distance (parse-integer (apply #'concatenate 'string distances))))
      (loop for hold below time
            count (> (* hold (- time hold)) distance)))))
