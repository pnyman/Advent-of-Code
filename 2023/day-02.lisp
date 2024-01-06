(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :serapeum)
(ql:quickload :alexandria)

(defpackage 2023-day-2
  (:use :cl))

(in-package :2023-day-2)

(defun get-input ()
  (let ((games (make-hash-table)))
    (loop for line in (uiop:read-file-lines "input/day-02-input.txt")
          for game-number from 1
          for l = nil do
            (loop for reveal in (str:split ";" (nth 1 (str:split ":" line)))
                  for temp = (serapeum:dict "red" 0 "green" 0 "blue" 0) do
                    (loop for cubes in (str:split "," reveal) do
                      (destructuring-bind (number color) (str:split " " cubes :omit-nulls t)
                        (setf (gethash color temp) (parse-integer number))))
                    (push temp l))
            (setf (gethash game-number games) l))
    games))


(defun solve-1 ()
  (let ((games (get-input))
        (bag (serapeum:dict "red" 12 "green" 13 "blue" 14)))
    (loop for game-number being the hash-keys in games
          when (loop for reveal in (gethash game-number games)
                     always (loop for color being the hash-keys in bag
                                  always (<= (gethash color reveal) (gethash color bag))))
            sum game-number into result
          finally (return result))))


(defun solve-2 ()
  (let ((games (get-input)))
    (loop for game-number being the hash-keys in games
          for bag = (serapeum:dict "red" 0 "green" 0 "blue" 0) do
            (loop for reveal in (gethash game-number games) do
              (loop for color being the hash-keys in bag do
                (setf (gethash color bag)
                      (max (gethash color reveal) (gethash color bag))))) 
          sum (reduce #'* (alexandria:hash-table-values bag)) into result
          finally (return result))))
