(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(use-package :arrow-macros)

(ql:quickload :yason)
(ql:quickload :alexandria)

(defpackage AoC-2015-12
  (:use :cl)
  (:import-from :alexandria #:hash-table-values))

(in-package :AoC-2015-12)

;;; part 1

(defun get-input ()
  (uiop:read-file-line "input/day-12.json"))

(defun to-int (nums)
  (reduce (lambda (acc c) (+ (* acc 10) (digit-char-p c)))
          nums
          :initial-value 0))

;; (char input i) mycket snabbare än (nth i lst)
(defun solve-1 (input)
  (let ((i 0) (sign 1) (sum 0) (len (length input)))
    (loop while (< i len)
          for c = (char input i) do
            (cond
              ((eq c #\-) (setf sign -1) (incf i))
              ((digit-char-p c)
               (loop
                 for c = (and (< i len) (char input i))
                 while (and c (digit-char-p c))
                 collect c into nums
                 do (incf i)
                 finally (incf sum (* sign (to-int nums)))))
              (t (setf sign 1) (incf i))))
    sum))

;; could have used json:
(defun sum-numbers (obj)
  (cond ((numberp obj) obj)
        ((stringp obj) 0)
        ((hash-table-p obj)
         (loop for v in (hash-table-values obj)
               sum (sum-numbers v)))
        ((listp obj)
         (reduce #'+ (mapcar #'sum-numbers obj)))
        (t 0)))

;;; part 2

(defun sum-numbers-no-red (obj)
  (cond ((numberp obj) obj)
        ((stringp obj) 0)
        ((hash-table-p obj)
         (loop for v in (hash-table-values obj)
               when (equal v "red")
                 return 0
               sum (sum-numbers-no-red v)))
        ((listp obj)
         (reduce #'+ (mapcar #'sum-numbers-no-red obj)))
        (t 0)))

(defun solve-2 ()
  (let ((json (with-open-file (stream "input/day-12.txt")
                (yason:parse stream))))
    (sum-numbers-no-red json)))

;; (defun solve-2 (input)
;;   (sum-numbers-no-red (yason:parse input)))
