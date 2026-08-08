(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(use-package :arrow-macros)

(defpackage AoC-2015-18
  (:use :cl))

(in-package :AoC-2015-18)

(defparameter *deltas*
  (list (list :dr  0 :dc  1)   ; right
        (list :dr  0 :dc -1)   ; left
        (list :dr  1 :dc  0)   ; down
        (list :dr -1 :dc  0)   ; up
        (list :dr  1 :dc  1)   ; down right
        (list :dr  1 :dc -1)   ; down left
        (list :dr -1 :dc  1)   ; up right
        (list :dr -1 :dc -1))) ; up left

(defparameter *rows* 0)
(defparameter *cols* 0)

(defun get-input ()
  (let* ((data (uiop:read-file-lines "input/day-18.txt"))
         (grid (make-array
                (list (length data) (length (first data)))
                :element-type 'boolean
                :initial-element nil)))
    (setf *rows* (array-dimension grid 0))
    (setf *cols* (array-dimension grid 1))
    (loop for r below *rows*
          for line = (coerce (nth r data) 'list) do
            (loop for c below *cols*
                  when (eq (nth c line) #\#)
                    do (setf (aref grid r c) t)))
    grid))

(defun count-neighbours (grid row col)
  (loop for delta in *deltas*
        for r = (+ row (getf delta :dr))
        for c = (+ col (getf delta :dc))
        when (and (>= r 0) (< r *rows*)
                  (>= c 0) (< c *cols*)
                  (aref grid r c))
          sum 1))

(defun maybe-toggle-light (grid row col)
  (let ((neighbours (count-neighbours grid row col))
        (on (aref grid row col)))
    (cond (on (<= 2 neighbours 3))
          (t (= neighbours 3)))))

(defun count-lighted (grid)
  (let ((lighted 0))
    (loop for r below *rows* do
      (loop for c below *cols*
            when (aref grid r c)
              do (incf lighted)))
    lighted))

(defun light-corners (grid)
  (setf (aref grid 0 0) t)
  (setf (aref grid 0 (1- *cols*)) t)
  (setf (aref grid (1- *rows*) 0) t)
  (setf (aref grid (1- *rows*) (1- *cols*)) t))

(defun solve (&key (part-2 nil) (steps 100))
  (let ((grid (get-input)))
    (when part-2 (light-corners grid))
    (dotimes (n steps)
      (let ((new-grid (make-array (list *rows* *cols*)
                                  :element-type 'boolean
                                  :initial-element nil)))
        (loop for r below *rows* do
          (loop for c below *cols* do
            (setf (aref new-grid r c)
                  (maybe-toggle-light grid r c))))
        (setf grid new-grid)
        (when part-2 (light-corners grid))))
    (count-lighted grid)))
