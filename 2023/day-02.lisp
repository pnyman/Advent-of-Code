(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :serapeum)
(ql:quickload :alexandria)

(defpackage 2023-day-2
  (:use :cl)
  (:import-from :serapeum #:dict #:prod)
  (:import-from :alexandria #:hash-table-values #:hash-table-keys)
  (:import-from :str #:split))

(in-package :2023-day-2)

(defun get-input ()
  (let ((games (make-hash-table)))
    (loop for line in (uiop:read-file-lines "input/day-02-input.txt")
          for game-number from 1 do
            (setf (gethash game-number games)
                  (loop for reveal in (split ";" (nth 1 (split ":" line)))
                        for d = (dict "red" 0 "green" 0 "blue" 0) do
                          (loop for cubes in (split "," reveal)
                                for (number color) = (split " " cubes :omit-nulls t)
                                do (setf (gethash color d) (parse-integer number)))
                        collect d)))
    games))

(defun solve-1 ()
  (let ((games (get-input))
        (bag (dict "red" 12 "green" 13 "blue" 14)))
    (loop for game-number in (hash-table-keys games)
          when (loop for reveal in (gethash game-number games)
                     always (loop for color in (hash-table-keys bag)
                                  always (<= (gethash color reveal) (gethash color bag))))
            sum game-number)))

(defun solve-2 ()
  (let ((games (get-input)))
    (loop for game-number in (hash-table-keys games)
          for bag = (dict "red" 0 "green" 0 "blue" 0) do
            (loop for reveal in (gethash game-number games) do
              (loop for color in (hash-table-keys bag) do
                (setf (gethash color bag)
                      (max (gethash color reveal) (gethash color bag)))))
          sum (prod (hash-table-values bag)))))
