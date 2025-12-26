(ql:quickload :uiop)
(ql:quickload :arrow-macros)
(ql:quickload :iterate)
(ql:quickload :str)

(defpackage 2025-day-3
  (:use :cl :arrow-macros :iterate))

(in-package :2025-day-3)

(defparameter *input* "../input/day-03-input.txt")

(defun get-input ()
  (iter (for line in (uiop:read-file-lines *input*))
        (collect (mapcar (lambda (x) (parse-integer x))
                         (str:split "" line :omit-nulls t)))))

(defun part-1 ()                        ; 17359
  (iter (for bank in (get-input))
        (for a = (reduce #'max (butlast bank)))
        (for b = (reduce #'max (subseq bank (1+ (position a bank)))))
        (summing (+ (* a 10) b) into result)
        (finally (return result))))

(defun part-2 ()                        ; 172787336861064
  (iter (for bank in (get-input))
        (for to-remove = (- (length bank) 12))
        (for stack = nil)
        (iter (for battery in bank)
              (iter (while (and stack
                                (plusp to-remove)
                                (< (car (last stack)) battery)))
                    (setf stack (butlast stack))
                    (decf to-remove))
              (setf stack (append stack (list battery))))
        (summing (parse-integer (format nil "~{~A~}" (subseq stack 0 12))) into total)
        (finally (return total))))
