(ql:quickload :uiop)
(ql:quickload :serapeum)
(ql:quickload :str)
(serapeum:toggle-pretty-print-hash-table)

(defpackage 2024-day-6 (:use :cl))
(in-package :2024-day-6)

(defstruct pos
  type
  coord
  (visited nil)
  from-direction)


;; (defun get-input ()
;;   (let ((map (make-hash-table))
;;         (guard 0)
;;         (lines (uiop:read-file-lines "input/day-06-test.txt")))
;;     (loop for line in lines
;;           for r from 0 do
;;             (loop for c in (coerce line 'list)
;;                   for i from 0
;;                   do (setf (gethash (complex r i) map) c)
;;                   when (eq c #\^)
;;                     do (setf guard (complex r i))))
;;     (values map guard)))


(defun get-input ()
  "Med struct för del 2."
  (let ((map (make-hash-table))
        (guard 0)
        (lines (uiop:read-file-lines "input/day-06-test.txt")))
    (loop for line in lines
          for r from 0 do
            (loop for c in (coerce line 'list)
                  for i from 0
                  for coord = (complex r i)
                  do (setf (gethash coord map) (make-pos :type c :coord coord))
                  when (eq c #\^)
                    do (setf guard (complex r i))))
    (values map guard)))


(defun turn-right (direction)
  "DIRECTION is a complex number"
  (case direction
    (#C(-1 0) #C(0 1))
    (#C(0 1) #C(1 0))
    (#C(1 0) #C(0 -1))
    (#C(0 -1) #C(-1 0))))

;; (defun part-1 ()
;;   (let ((direction #C(-1 0))
;;         (positions nil))
;;     (multiple-value-bind (map guard) (get-input)
;;       (loop while (gethash guard map) do
;;         (push guard positions)
;;         (when (eql (gethash (+ guard direction) map) #\#)
;;           (setf direction (turn-right direction)))
;;         (incf guard direction)))
;;     (length (remove-duplicates positions))))

(defun part-1 ()
  "Med struct för del 2."
  (let ((direction #C(-1 0))
        (positions nil))
    (multiple-value-bind (map guard) (get-input)
      (loop while (gethash guard map)
            for next-pos = (gethash (+ guard direction) map)
            do (push guard positions)
               (when (and next-pos (eql (pos-type next-pos) #\#))
                 (setf direction (turn-right direction)))
               (incf guard direction)))
    (length (remove-duplicates positions))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun part-2 ()
  "Ger fel svar."
  (let ((direction #C(-1 0))
        (positions nil)
        (blocks nil))
    (multiple-value-bind (map guard) (get-input)
      (loop while (gethash guard map)
            for this-pos = (gethash guard map)
            for next-pos = (gethash (+ guard direction) map)
            do (setf (pos-visited this-pos) t)
               (setf (pos-from-direction this-pos) direction)
               (push this-pos positions)
               (when (and next-pos (eql (pos-type next-pos) #\#))
                 (setf direction (turn-right direction)))
               (incf guard direction))
      (loop for position in positions
            for coord = (pos-coord position)
            for new-direction = (turn-right (pos-from-direction position)) do
              (loop while (gethash coord map)
                    for this-pos = (gethash coord map)
                    for next-pos = (gethash (incf coord new-direction) map)
                    when (and next-pos
                              (eql (pos-type next-pos) #\#)
                              (eql (pos-from-direction this-pos) direction))
                      do (push position blocks))))
    (print (remove-duplicates blocks))
    (length (remove-duplicates blocks))))
