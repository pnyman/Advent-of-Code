#|
A, X - rock
B, Y - paper
C, Z - scissors
|#

(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :alexandria)

(defun scores-1 (round)
  (alexandria:switch (round :test #'string=)
    ("A X" 4) ("A Y" 8) ("A Z" 3)
    ("B X" 1) ("B Y" 5) ("B Z" 9)
    ("C X" 7) ("C Y" 2) ("C Z" 6)))

(defun scores-2 (round)
  (alexandria:switch (round :test #'string=)
    ("A X" 3) ("A Y" 4) ("A Z" 8)
    ("B X" 1) ("B Y" 5) ("B Z" 9)
    ("C X" 2) ("C Y" 6) ("C Z" 7)))

(defun solve-02 (input scores)
  (loop for round in input
        summing (funcall scores round)))

(let ((input (uiop:read-file-lines "input/day-02-input.txt")))
  (print (solve-02 input #'scores-1))
  (print (solve-02 input #'scores-2)))
