(ql:quickload :uiop)
(ql:quickload :arrow-macros)

(defpackage 2025-day-1
  (:use :cl :arrow-macros))
(in-package :2025-day-1)

(defparameter *input* "input/day-01-input.txt")

(defun parse-line (s)
  (let ((num (->> s
               (remove-if-not #'digit-char-p)
               (parse-integer))))
    (if (find #\L s) (- num) num)))

(defun get-input ()
  (mapcar #'parse-line (uiop:read-file-lines *input*)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun part-1 ()                        ; 1135
  (let ((arrow 50))
    (loop for x in (get-input)
          do (setf arrow (mod (+ arrow x) 100))
          when (zerop arrow) count 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun passes (arrow step &optional (scale 100))
  (let* ((start arrow)
         (end (+ start step))
         (new-pos (mod end scale)))
    (values (cond ((> step 0)
                   (floor end scale))
                  ((< step 0)
                   (- (floor (- start 1) scale)
                      (floor (- end 1) scale)))
                  (t 0))
            new-pos)))

(defun part-2 ()                        ; 6558
  (let ((arrow 50)
        (clicks 0))
    (loop for x in (get-input)
          do (multiple-value-bind (p q) (passes arrow x)
               (incf clicks p)
               (setf arrow q)))
    clicks))
