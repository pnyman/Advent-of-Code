(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(use-package :arrow-macros)

(defpackage AoC-2015-18
  (:use :cl))

(in-package :AoC-2015-18)

(declaim (optimize (speed 3) (safety 0)))

(declaim (type (simple-array fixnum (8 2)) *deltas*))
(defparameter *deltas*
  (make-array '(8 2) :element-type 'fixnum
                     :initial-contents '((0 1) (0 -1) (1 0) (-1 0)
                                         (1 1) (1 -1) (-1 1) (-1 -1))))

(declaim (type fixnum *rows* *cols*))
(defparameter *rows* 0)
(defparameter *cols* 0)

(defun get-input ()
  (let* ((data (uiop:read-file-lines "../input/day-18.txt")))
    (setf *rows* (length data))
    (setf *cols* (length (first data)))
    ;; make a ring around the actual data
    ;; to avoid having to do range checks
    (let ((grid (make-array (list (+ *rows* 2) (+ *cols* 2))
                            :element-type 'boolean
                            :initial-element nil)))
      (loop for r below *rows*
            for line = (coerce (nth r data) 'list) do
              (loop for c below *cols*
                    when (eq (nth c line) #\#)
                      do (setf (aref grid (1+ r) (1+ c)) t)))
      grid)))

(defun count-neighbours (grid row col)
  (declare (type (simple-array boolean (* *)) grid)
           (type fixnum row col))
  (loop for i below 8
        for r fixnum = (+ row (aref *deltas* i 0))
        for c fixnum = (+ col (aref *deltas* i 1))
        when (aref grid r c)            ; range check not needed
          sum 1 fixnum))

(defun maybe-toggle-light (grid row col)
  (declare (type (simple-array boolean (* *)) grid))
  (let ((neighbours (count-neighbours grid row col))
        (on (aref grid row col)))
    (cond (on (<= 2 neighbours 3))
          (t (= neighbours 3)))))

(defun count-lighted (grid)
  (declare (type (simple-array boolean (* *)) grid))
  (let ((lighted 0))
    (declare (type fixnum lighted))
    (loop for r from 1 to *rows* do
      (loop for c from 1 to *cols*
            when (aref grid r c)
              do (incf lighted)))
    lighted))

(defun light-corners (grid)
  (declare (type (simple-array boolean (* *)) grid))
  (setf (aref grid 1 1) t)
  (setf (aref grid 1 *cols*) t)
  (setf (aref grid *rows* 1) t)
  (setf (aref grid *rows* *cols*) t))

(defun solve (&key (part-2 nil) (steps 100))
  (declare (type fixnum steps))
  (let ((grid (get-input)))
    (when part-2 (light-corners grid))
    (dotimes (n steps)
      (let ((new-grid (make-array (list (+ *rows* 2) (+ *cols* 2))
                                  :element-type 'boolean
                                  :initial-element nil)))
        (loop for r from 1 to *rows* do
          (loop for c from 1 to *cols* do
            (setf (aref new-grid r c)
                  (maybe-toggle-light grid r c))))
        (setf grid new-grid)
        (when part-2 (light-corners grid))))
    (count-lighted grid)))
