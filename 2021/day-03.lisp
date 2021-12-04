(ql:quickload :uiop)

(defun input ()
  (uiop:read-file-lines "input/day-03-input.txt"))

(defun divide-list (data x)
  (let ((l0 '()) (l1 '()))
    (dolist (d data)
      (if (string= "0" (subseq d x (1+ x)))
          (push d l0)
          (push d l1)))
    (if (> (length l0) (length l1))
        (list l0 l1)
        (list l1 l0))))

(defun reduce-solver (data n &optional (x 0))
  (if (= 1 (length data))
      (parse-integer (nth 0 data) :radix 2)
      (reduce-solver (nth n (divide-list data x)) n (1+ x))))

(let ((data (input)))
  (print (* (reduce-solver data 1) (reduce-solver data 0))))
