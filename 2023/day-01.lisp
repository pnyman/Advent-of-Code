(ql:quickload :uiop)

(defpackage 2023-day-1
  (:use :cl))

(in-package :2023-day-1)

(defun get-input ()
  (uiop:read-file-lines "input/day-01-input.txt"))

;;; part 1

(defun get-number (str)
  (let ((numbers (remove-if-not 'digit-char-p (coerce str 'list))))
    (parse-integer (format nil "~a~a" (first numbers) (first (last numbers))))))

(defun solve-1 ()
  (loop for line in (get-input)
        sum (get-number line)))

;;; part 2

(defparameter *cardinal-number-map*
  (loop for number from 1 to 9
        collect (cons (format nil "~r" number) (write-to-string number))))

(defun maybe-number (x)
  (or (cdr (assoc x *cardinal-number-map* :test #'string-equal))
      (when (every #'digit-char-p x) x)))

(defun first-last-digits (line)
  (let ((acc (loop for i below (length line)
                   append (loop for j from (1+ i) to (length line)
                                for num = (maybe-number (subseq line i j))
                                when num collect num))))
    (parse-integer (format nil "~a~a" (first acc) (first (last acc))))))

(defun solve-2 ()
  (loop for line in (get-input)
        sum (first-last-digits line)))
