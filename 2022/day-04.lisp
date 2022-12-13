(ql:quickload :uiop)

(defun make-values (line)
  (let* ((x (str:split "," line))
         (1st (str:split "-" (first x)))
         (2nd (str:split "-" (second x))))
    (list (parse-integer (first 1st))
          (parse-integer (second 1st))
          (parse-integer (first 2nd))
          (parse-integer (second 2nd)))))

(defun solve-04-1 (input)
  (length (loop for line in input
                for (a b c d) = (make-values line)
                when (or (and (>= a c) (<= b d))
                         (and (>= c a) (<= d b)))
                  collect line)))

(defun solve-04-2 (input)
  (length (loop for line in input
                for (a b c d) = (make-values line)
                when (or (<= c a d)
                         (<= c b d)
                         (<= a c b)
                         (<= a d b))
                  collect line)))

(let ((input (uiop:read-file-lines "input/day-04-input.txt")))
  (print (solve-04-1 input))
  (print (solve-04-2 input)))
