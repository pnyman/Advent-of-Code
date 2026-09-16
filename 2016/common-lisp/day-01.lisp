(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(use-package :arrow-macros)

(defpackage AoC-2016-01
  (:use :cl))

(in-package :AoC-2016-01)

(defun get-input ()
  (str:split ", " (uiop:read-file-line "../input/day-01.txt")))

(defun turn (way dir)
  (let ((directions '(N E S W)))
    (if (eq way #\R)
        (nth (mod (+ (position dir directions) 1) 4) directions)
        (nth (mod (+ (position dir directions) 3) 4) directions))))

(defun solve (input)
  (let ((position (list :x 0 :y 0))
        (ht (make-hash-table :test 'equal))
        (location) (dir 'N))
    (dolist (part input)
      (setf dir (turn (char part 0) dir))
      (dotimes (i (parse-integer (subseq part 1)))
        (case dir
          (E (incf (getf position :x)))
          (W (decf (getf position :x)))
          (N (incf (getf position :y)))
          (S (decf (getf position :y))))
        (when (not location)
          (if (gethash position ht)
              (setf location (copy-list position))
              (setf (gethash (copy-list position) ht) t)))))
    (format t "Part 1: ~a~%" (+ (abs (getf position :x)) (abs (getf position :y))))
    (format t "Part 2: ~a~%" (+ (abs (getf location :x)) (abs (getf location :y))))))
