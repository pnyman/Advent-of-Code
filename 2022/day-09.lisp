(ql:quickload :uiop)

(defun parse-input (d)
  (values (subseq d 0 1) (parse-integer (subseq d 2))))

(defun move (origin direction)
  (cond
    ((string= direction "R") (list (1+ (car origin)) (cadr origin)))
    ((string= direction "L") (list (1- (car origin)) (cadr origin)))
    ((string= direction "U") (list (car origin) (1+ (cadr origin))))
    (t (list (car origin) (1- (cadr origin))))))

(defun distant-p (a b)
  (<= 2 (sqrt (+ (expt (abs (- (first a) (first b))) 2)
                 (expt (abs (- (second a) (second b))) 2)))))

(defun solve-09-1 (data &optional (head '(0 0)) (tail '((0 0))))
  (when (null data)
    (return-from solve-09-1 (length (remove-duplicates tail :test #'equal))))
  (multiple-value-bind (direction distance) (parse-input (car data))
    (dotimes (n distance)
      (let ((new-head (move head direction)))
        (when (distant-p (car tail) new-head)
          (setf tail (cons head tail)))
        (setf head new-head)))
    (solve-09-1 (rest data) head tail)))


(defun solve-09-2 (data &optional
                          (head (loop for n to 8 collect '(0 0)))
                          (tail '((0 0))))
  (when (null data)
    (return-from solve-09-2 (length (remove-duplicates tail :test #'equal))))
  (multiple-value-bind (direction distance) (parse-input (car data))
    (dotimes (n distance)
      (let ((new-head (move (first head) direction)))
        (loop for h in (rest head) do
          (when (distant-p h new-head)
            (setf h head)))
        (setf (first head) new-head)))
    (solve-09-1 (rest data) head tail)))


(let ((input (uiop:read-file-lines "input/day-09-input.txt")))
  (print (solve-09-1 input)))
