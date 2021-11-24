(ql:quickload "uiop")

(defun input ()
  (mapcar #'parse-integer (uiop:read-file-lines "input/day-10-input.txt")))

(defun part-1 (input)
  (let ((jolt 0) (diff-1 0) (diff-3 1))
    (loop while (< jolt (reduce #'max input))
          do (loop for x from (+ jolt 1) to (+ jolt 3)
                   when (member x input)
                     do (cond ((= 1 (- x jolt)) (incf diff-1))
                              ((= 3 (- x jolt)) (incf diff-3)))
                        (setf jolt x)
                        (return)))
    (* diff-1 diff-3)))

(defun part-2 (input)
  (let ((run 1)
        (arrangements 1)
        (sorted (concatenate 'list '(0)
                             (sort (copy-seq input) #'<)
                             (list (reduce #'max input)))))
    (loop for i from 1 below (length sorted)
          do (if (= 1 (- (nth i sorted) (nth (1- i) sorted)))
                 (incf run)
                 (progn (setf arrangements
                              (* arrangements
                                 (case run (5 7) (4 4) (3 2) (otherwise 1))))
                        (setf run 1))))
    arrangements))

(print (part-1 (input))) ;; 2475
(print (part-2 (input))) ;; 442136281481216
