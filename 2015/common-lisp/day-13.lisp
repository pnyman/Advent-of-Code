(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(use-package :arrow-macros)

(defpackage AoC-2015-13
  (:use :cl))

(in-package :AoC-2015-13)

;;; part 1

(defun get-input ()
  (uiop:read-file-lines "../input/day-13.txt"))

(defun get-test-input ()
  (uiop:read-file-lines "../input/day-13-test.txt"))

(defun parse-input (input)
  (loop for line in input
        for data = (str:words line)
        for happiness = (parse-integer (nth 3 data))
        collect (list :person (read-from-string (nth 0 data))
                      :neighbour (read-from-string (remove #\. (nth 10 data)))
                      :happiness (if (string= (nth 2 data) "gain")
                                     happiness
                                     (- happiness)))))

(defun permutations (items)
  (loop for item in items
        for other-items = (remove item items)
        for other-items-permutations = (permutations other-items)
        append (if other-items-permutations
                   (mapcar #'(lambda (l)
                               (cons item l))
                           other-items-permutations)
                   (list (list item)))))

(defun add-happiness (ht person neighbour happiness)
  (let ((inner (or (gethash person ht)
                   (setf (gethash person ht) (make-hash-table)))))
    (setf (gethash neighbour inner) happiness)))

(defun get-happiness (ht person neighbour)
  (gethash neighbour (gethash person ht)))

(defun add-self (data)
  (let ((people nil))
    (loop for item in data do
      (pushnew (getf item :person) people)
      (pushnew (getf item :neighbour) people))
    (append data
            (loop for p in people
                  append (list (list :person 'self :neighbour p :happiness 0)
                               (list :person p :neighbour 'self :happiness 0))))))

(defun solve (input &key (part-2 nil))
  (let ((ht (make-hash-table))
        (people nil)
        (data (parse-input input)))
    (when part-2 (setf data (add-self data)))
    (loop for item in data
          do (pushnew (getf item :person) people)
             (pushnew (getf item :neighbour) people)
             (add-happiness ht
                            (getf item :person)
                            (getf item :neighbour)
                            (getf item :happiness)))
    (loop for perm in (permutations people)
          for len = (length perm)
          for happiness
            = (loop for i below len
                    for p1 = (nth i perm)
                    for p2 = (nth (mod (1+ i) len) perm)
                    sum (+ (get-happiness ht p1 p2)
                           (get-happiness ht p2 p1)))
          maximize happiness)))
