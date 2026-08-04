(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(use-package :arrow-macros)

(defpackage AoC-2015-09
  (:use :cl))

(in-package :AoC-2015-09)

(defun get-input ()
  (uiop:read-file-lines "input/day-09.txt"))

(defun permutations (items)
  (loop for item in items
        for other-items = (remove item items)
        for other-items-permutations = (permutations other-items)
        append (if other-items-permutations
                   (mapcar #'(lambda (l)
                               (cons item l))
                           other-items-permutations)
                   (list (list item)))))

(defun add-distance (ht start destination distance)
  (let ((inner (or (gethash start ht)
                   (setf (gethash start ht) (make-hash-table :test #'equal)))))
    (setf (gethash destination inner) (parse-integer distance))))

(defun get-distance (ht start destination)
  (gethash destination (gethash start ht)))

(defun solve (input)
  (let ((ht (make-hash-table :test #'equal))
        (places nil))
    (loop for line in input
          for (start to destination eq distance) = (str:split " " line)
          do (pushnew start places :test #'string=)
             (pushnew destination places :test #'string=)
             (add-distance ht start destination distance)
             (add-distance ht destination start distance))
    (loop for perm in (permutations places)
          for dist = (reduce #'+ (mapcar (lambda (x y)
                                           (get-distance ht x y))
                                         (butlast perm) (cdr perm)))
          minimize dist into min-dist
          maximize dist into max-dist
          finally (return (cons min-dist max-dist)))))
