(ql:quickload :uiop)
(ql:quickload :serapeum)
(ql:quickload :str)
(serapeum:toggle-pretty-print-hash-table)

(defpackage 2024-day-5 (:use :cl))
(in-package :2024-day-5)

(defparameter *rules* (make-hash-table))
(defparameter *updates* nil)

(defun get-input ()
  (clrhash *rules*)
  (setf *updates* nil)
  (let ((lines (uiop:read-file-lines "input/day-05-input.txt")))
    (loop for line in lines do
      (when (search "|" line)
        (destructuring-bind (k v) (str:split "|" line)
          (let ((k (parse-integer k))
                (v (parse-integer v)))
            (if (gethash k *rules*)
                (setf (gethash k *rules*) (cons v (gethash k *rules*)))
                (setf (gethash k *rules*) (list v))))))
      (when (search "," line)
        (push (mapcar (lambda (x) (parse-integer x))
                      (str:split "," line))
              *updates*)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun correct-order-p (update)
  (if (null (rest update))
      t
      (let ((rule (gethash (first update) *rules*)))
        (if (loop for pnr in (rest update)
                  always (member pnr rule))
            (correct-order-p (rest update))
            (return-from correct-order-p nil)))))

(defun part-1 ()
  (get-input)
  (loop for update in *updates*
        when (correct-order-p update)
          sum (nth (floor (length update) 2) update)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun index-correct-first (update &optional (idx 0))
  (if (>= idx (length update))
      nil
      (let ((theme (gethash (nth idx update) *rules*))
            (others (loop for j from 0 below (length update)
                          when (not (= idx j))
                            collect (nth j update))))
        (if (every (lambda (n) (find n theme)) others)
            idx
            (index-correct-first update (1+ idx))))))

(defun find-correct-order (update)
  (let ((result '()))
    (loop while update do
      (let ((idx (index-correct-first update)))
        (when idx
          (push (nth idx update) result)
          (setf update (remove (nth idx update) update :count 1)))))
    (nreverse result)))

(defun part-2 ()
  (get-input)
  (loop for incorrect in (remove-if #'correct-order-p *updates*)
        for correct = (find-correct-order incorrect)
        sum (nth (floor (length correct) 2) correct)))
