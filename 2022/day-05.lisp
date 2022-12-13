(ql:quickload :uiop)

(defun get-input-05 ()
  (let ((input (uiop:read-file-lines "input/day-05-input.txt"))
        (crates-list nil)
        (procedure nil)
        (nr-of-rows))
    (loop for line in input do
      (when (plusp (length line))
        (cond ((find #\[ line)
               (push line crates-list))
              ((string= (subseq line 0 1) "m")
               (push (make-instructions line) procedure))
              ((string= (subseq line 1 2) "1")
               (setf nr-of-rows (digit-char-p (uiop:last-char line)))))))
    (let ((crates (loop for i below nr-of-rows
                        collect '())))
      (loop for c in crates-list do
        (loop for pos in (position-of-crates c)
              for row = (/ pos 4) do
                (push (subseq c (1+ pos) (+ 2 pos)) (nth row crates))))
      (values crates (reverse procedure)))))

(defun position-of-crates (string)
  (loop for i = 0 then (1+ j)
        as j = (position #\[ string :start i)
        when j
          collect j
        while j))

(defun make-instructions (string)
  (loop for w in (str:words string)
        for i from 0
        when (oddp i)
          collect (parse-integer w)))

(defun print-answer (crates)
  (format t "~{~a~}" (loop for c in crates collect (nth 0 c))))

;; HNSNMTLHQ
(defun solve-05-1 ()
  (multiple-value-bind (crates procedure) (get-input-05)
    (loop for p in procedure
          for amount = (nth 0 p)
          for source = (1- (nth 1 p))
          for dest = (1- (nth 2 p)) do
            (dotimes (i amount)
              (push (pop (nth source crates))
                    (nth dest crates))))
    (print-answer crates)))

;; RNLFDJMCT
(defun solve-05-2 ()
  (multiple-value-bind (crates procedure) (get-input-05)
    (loop for p in procedure
          for amount = (nth 0 p)
          for source = (1- (nth 1 p))
          for dest = (1- (nth 2 p)) do
            (setf (nth dest crates)
                  (concatenate 'list
                               (subseq (nth source crates) 0 amount)
                               (nth dest crates)))
            (setf (nth source crates)
                  (subseq (nth source crates) amount)))
    (print-answer crates)))
