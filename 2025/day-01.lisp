(ql:quickload :uiop)
(ql:quickload :arrow-macros)
(ql:quickload :iterate)

(defpackage 2025-day-1
  (:use :cl :arrow-macros :iterate))

(in-package :2025-day-1)

(defparameter *input* "input/day-01-input.txt")

(defun parse-line (line)
  (->> line (remove #\R) (substitute #\- #\L) (parse-integer)))

(defun get-input ()
  (mapcar #'parse-line (uiop:read-file-lines *input*)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun part-1 ()                        ; 1135
  (loop with arrow = 50
        for x in (get-input)
        count (zerop (setf arrow (mod (+ arrow x) 100)))))

(defun part-1 ()                        ; 1135
  (loop with arrow = 50
        for x in (get-input)
        count (-<> (+ arrow x) (mod 100) (setf arrow <>) (zerop))))

(defun part-1 ()
  (iter (with dial = 50)
        (for rot in (get-input))
        (counting (zerop (mod (incf dial rot) 100)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun passes (start step)
  (let ((end (+ start step)))
    (cond ((plusp step) (floor end 100))
          ((minusp step) (- (floor (1- start) 100)
                            (floor (1- end) 100)))
          (t 0))))

(defun part-2 ()                        ; 6558
  (loop with arrow = 50
        with clicks = 0
        for x in (get-input)
        do (incf clicks (passes arrow x))
           (setf arrow (mod (+ arrow x) 100))
        finally (return clicks)))
