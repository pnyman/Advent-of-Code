(ql:quickload :uiop)

(defun solve-06 (input &optional (start 0) (chunk 4))
  (loop for i from start
        for j = (+ i chunk)
        for x = (remove-duplicates (subseq input i j) :test #'char=)
        when (= chunk (length x))
          do (return-from solve-06 j)))

(let* ((input (uiop:read-file-line "input/day-06-input.txt"))
       (sol-1 (solve-06 input)))
  (print sol-1)
  (print (solve-06 input sol-1 14)))
