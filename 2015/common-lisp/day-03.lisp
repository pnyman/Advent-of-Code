(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(use-package :str)
(use-package :arrow-macros)

(defpackage AoC-2015-03
  (:use :cl))

(in-package :AoC-2015-03)

(defun get-input ()
  (uiop:read-file-line "input/day-03.txt"))

(defun nr-houses (houses)
  (length
   (remove-duplicates houses
                      :test (lambda (a b)
                              (and (= (car a) (car b))
                                   (= (cadr a) (cadr b)))))))

(defun advance (houses char)
  (let ((pos (first houses)))
    (cond ((char= char #\v) (list (car pos) (1+ (cadr pos))))
          ((char= char #\^) (list (car pos) (1- (cadr pos))))
          ((char= char #\>) (list (1+ (car pos)) (cadr pos)))
          ((char= char #\<) (list (1- (car pos)) (cadr pos))))))

(defun solve-1 (input)
  (let ((houses '((0 0))))
    (loop for char across input do
      (setf houses (cons (advance houses char) houses)))
    (nr-houses houses)))

(defun solve-2 (input)
  (let ((santa '((0 0)))
        (robo '((0 0))))
    (loop for char across input
          for n from 0 do
            (if (zerop (mod n 2))
                (setf santa (cons (advance santa char) santa))
                (setf robo (cons (advance robo char) robo))))
    (nr-houses (append santa robo))))
