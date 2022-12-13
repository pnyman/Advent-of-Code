(ql:quickload :uiop)

(defun bisect (line)
  (let ((mid (/ (length line) 2)))
    (list (subseq line 0 mid)
          (subseq line mid))))

(defun common-elt (strings)
  (car (intersection (coerce (car strings) 'list)
                     (coerce (cadr strings) 'list))))

(defun common-elt-3 (a b c)
  (car (intersection (intersection (coerce a 'list)
                                   (coerce b 'list))
                     (coerce c 'list))))

(defun value (char)
  (let ((val (char-int char)))
    (if (<= 65 val 90)
        (- val 38)
        (- val 96))))

(defun solve-03-1 (input)
  (loop for line in input
        sum (value (common-elt (bisect line)))))

(defun solve-03-2 (input)
  (loop for (a b c) on input by 'cdddr
        sum (value (common-elt-3 a b c))))

(let ((input (uiop:read-file-lines "input/day-03-input.txt")))
  (print (solve-03-1 input))
  (print (solve-03-2 input)))
