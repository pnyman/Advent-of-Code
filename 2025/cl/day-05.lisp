(ql:quickload :uiop)
(ql:quickload :arrow-macros)
(ql:quickload :iterate)
(ql:quickload :str)

(defpackage 2025-day-5
  (:use :cl :arrow-macros :iterate))

(in-package :2025-day-5)

(defparameter *input* "../input/day-05-input.txt")

(defun get-input ()
  (let ((fresh nil)
        (available nil))
    (iter (for line in (uiop:read-file-lines *input*))
          (cond ((find #\- line)
                 (-<>> line
                   (str:split "-")
                   (mapcar #'parse-integer)
                   (push <> fresh)))
                ((plusp (length line))
                 (-> line
                   (parse-integer)
                   (push available)))))
    (values fresh available)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun part-1 ()                        ; 505
  (let ((result 0))
    (multiple-value-bind (fresh available) (get-input)
      (iter (for x in available)
            (iter (for (low high) in fresh)
                  (when (<= low x high)
                    (incf result)
                    (return)))))
    result))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun merge-intervals (intervals)
  (let ((sorted (sort intervals #'< :key #'first))
        (result nil))
    (dolist (interval sorted result)
      (destructuring-bind (low high) interval
        (if (null result)
            (push (list low high) result)
            (let ((r-high (second (car result))))
              (if (> low (1+ r-high))
                  (push (list low high) result)
                  (setf (second (car result))
                        (max high r-high)))))))))

(defun part-2 ()                        ; 344423158480189
  (multiple-value-bind (fresh _) (get-input)
    (declare (ignore _))
    (loop for (low high) in (merge-intervals fresh)
          sum (1+ (- high low)))))
