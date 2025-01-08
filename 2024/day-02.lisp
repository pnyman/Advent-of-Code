(ql:quickload :uiop)
(ql:quickload :str)
;; (ql:quickload :arrow-macros)

(defpackage 2024-day-2
  (:use :cl))
(in-package :2024-day-2)

(defun remove-nth (index items)
  (loop for item in items
        as i from 0
        unless (= index i) collect item))

(defun get-input ()
  (loop for line in (uiop:read-file-lines "input/day-02-input.txt")
        collect (mapcar (lambda (x) (parse-integer x)) (str:words line))))

(defun safe-p (report)
  (let ((sorted (sort (copy-seq report)
                      (if (< (first report) (first (last report))) #'< #'>))))
    (and (equal report sorted)
         (loop for i below (1- (length sorted))
               for diff = (abs (- (nth i sorted) (nth (1+ i) sorted)))
               always (<= 1 diff 3)))))

(defun part-1 ()
  (count-if #'safe-p (get-input)))

(defun part-2 ()
  (loop for r in (get-input)
        when (or (safe-p r)
                 (loop for i below (length r)
                         thereis (safe-p (remove-nth i r))))
          sum 1))
