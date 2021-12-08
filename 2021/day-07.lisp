(ql:quickload :uiop)

(defun input ()
  (mapcar #'parse-integer
          (uiop:split-string
           (nth 0 (uiop:read-file-lines "input/day-07-input.txt"))
           :separator ",")))

(let ((data (input)))
  (loop for x to (reduce #'max data)
        minimize
        (loop for y in data
              sum (abs (- x y)) into sums
              finally (return sums))))

(defun triangle (n)
  (/ (* n (+ n 1)) 2))

(let ((data (input)))
  (loop for x to (reduce #'max data)
        minimize
        (loop for y in data
              sum (triangle (abs (- x y))) into sums
              finally (return sums))))
