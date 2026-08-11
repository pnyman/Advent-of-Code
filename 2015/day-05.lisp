(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(use-package :arrow-macros)

(defpackage AoC-2015-05
  (:use :cl))

(in-package :AoC-2015-05)

(defun get-input ()
  (uiop:read-file-lines "input/day-05.txt"))

;;; part 1

(defun contains-three-vowels-p (s)
  (<= 3 (length (remove-if-not
                 (lambda (x) (member x '("a" "e" "i" "o" "u") :test #'string=))
                 s))))

(defun has-twice-in-a-row-p (s)
  (loop for i from 0 to (- (length s) 2)
          thereis (eq (char s i) (char s (1+ i)))))

(defun no-forbidden-strings-p (s)
  (loop for x in '("ab" "cd" "pq" "xy")
        never (search x s)))

(defun solve-1 (input)
  (loop for s in input
        when (and (contains-three-vowels-p s)
                  (has-twice-in-a-row-p s)
                  (no-forbidden-strings-p s))
          sum 1))

;;; part 2

(defun has-non-overlapping-pairs-p (s)
  (loop for i from 0 to (- (length s) 2)
          thereis (search (subseq s i (+ i 2))
                          (subseq s (+ i 2))
                          :test #'string=)))

(defun has-repeating-p (s)
  (loop for i from 0 to (- (length s) 3)
          thereis (string= (subseq s i (+ i 1))
                           (subseq s (+ i 2) (+ i 3)))))

(defun solve-2 (input)
  (loop for s in input
        when (and (has-non-overlapping-pairs-p s)
                  (has-repeating-p s))
          sum 1))
