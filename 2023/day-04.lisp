(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(use-package :str)
(use-package :arrow-macros)

(defpackage 2023-day-4
  (:use :cl))

(in-package :2023-day-4)

(defun get-input ()
  (->> (uiop:read-file-lines "input/day-04-input.txt")
    (mapcar (lambda (x)
              (loop for s in (split "|" (first (rest (split ":" x))))
                    collect (loop for n in (split-omit-nulls " " s)
                                  collect (parse-integer n)))))))

(defun wins (card)
  (length (intersection (first card) (second card))))

(defun points (card)
  (floor (expt 2 (1- (wins card)))))

(defun solve-1 ()
  (loop for card in (get-input)
        sum (points card) into points
        finally (return points)))

(defun solve-2 ()
  (let* ((cards (get-input))
         (amounts (make-array (length cards) :initial-element 1)))
    (loop for i below (length cards) do
      (loop for j from 1 to (wins (nth i cards))
            do (incf (aref amounts (+ i j)) (aref amounts i))))
    (reduce #'+ amounts)))
