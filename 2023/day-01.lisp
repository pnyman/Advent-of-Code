(ql:quickload :uiop)

(defpackage 2023-day-1
  (:use :cl))

(in-package :2023-day-1)

(defun get-input ()
  (uiop:read-file-lines "input/day-01-input.txt"))

;;; part 1

(defun get-number (str)
  (let ((numbers (remove-if-not 'digit-char-p (map 'list #'identity str))))
    (parse-integer (concatenate 'string (list (first numbers) (first (last numbers)))))))

(defun solve-1 ()
  (let ((data (get-input)))
    (loop for line in data
          sum (get-number line))))

;;; part 2

(defparameter *cardinal-number-map*
  (loop for number from 1 to 9
        collect (cons (format nil "~r" number) (write-to-string number))))

(defun cardinal->int (cardinal)
  (cdr (assoc cardinal *cardinal-number-map* :test #'string-equal)))

(defun maybe-number (x)
  (or (cardinal->int x)
      (when (every #'digit-char-p x) x)))

(defun first-last-digit (s)
  (let ((acc (remove nil (loop for i below (length s)
                               append (loop for j from (1+ i) to (length s) 
                                            collect (maybe-number (subseq s i j)))))))
    (parse-integer
     (concatenate 'string
                  (subseq (nth 0 acc) 0 1)
                  (subseq (nth (1- (length acc)) acc) 0 1)))))



(defun solve-2 ()
  (let ((data (get-input)))
    (loop for line in data
          sum (first-last-digit line))))

