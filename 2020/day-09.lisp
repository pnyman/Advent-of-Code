(ql:quickload "uiop")

(defparameter input
  (mapcar #'parse-integer (uiop:read-file-lines "input/day-09-input.txt")))

(defparameter preamble 25)

(defun part1 (data)
  (if (loop named outer for i below (1- preamble)
            do (loop for j from (1+ i) below preamble
                     when (= (nth preamble data)
                             (+ (nth i data) (nth j data)))
                       do (return-from outer t)))
      (part1 (cdr data))
      (nth preamble data)))

(defun part2 (goal &optional (start 0))
  (loop do
    (loop for i from start below (length input)
          for val = (nth i input)
          for sum = val then (+ sum val)
          collect val into vals
          do (cond ((> sum goal) (incf start) (return))
                   ((= sum goal) (return-from part2
                                   (+ (reduce #'min vals)
                                      (reduce #'max vals))))))))

(print (part1 input))         ; 400480901
(print (part2 (part1 input))) ; 67587168
