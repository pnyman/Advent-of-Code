(ql:quickload :alexandria)
(ql:quickload :uiop)
(ql:quickload :split-sequence)
(ql:quickload :cl-ppcre)

(defun input ()
  (split-sequence:split-sequence
   ""
   (uiop:read-file-lines "input/day-16-example.txt")
   :test #'equal
   :remove-empty-subseqs t))

(defun make-fields (input)
  (let* ((fields '()))
    (loop for f in (car input)
          for key = (read-from-string (car (cl-ppcre:split ":" f)))
          for numbers = (get-field-numbers f)
          do (push (cons key (list numbers)) fields))
    fields))

(defun get-field-numbers (field)
  (let ((numbers '())
        (intervals (cl-ppcre:all-matches-as-strings "\\d+-\\d+" field)))
    (loop for interval in intervals
          do (push (make-field-numbers interval) numbers))
    (alexandria:flatten numbers)))

(defun make-field-numbers (interval)
  (let ((s (cl-ppcre:split "-" interval)))
    (loop for n from (parse-integer (first s)) to (parse-integer (second s))
          collect n)))

(defun nearby-tickets (input)
  (loop for x in (rest (car (last input)))
        collect (mapcar #'parse-integer (cl-ppcre:split "," x))))

(defun part1 (input)
  (let ((field-numbers (remove-duplicates
                        (alexandria:flatten
                         (loop for f in (make-fields input)
                               collect (cadr f)))))
        (sum 0))
    (dolist (ticket (nearby-tickets input))
      (dolist (n ticket)
        (when (not (member n field-numbers))
          (incf sum n))))
    sum))

(part1 (input))  ; > 23122


(defun valid-tickets (input fields)
  (let ((field-numbers (remove-duplicates
                        (alexandria:flatten
                         (loop for f in fields
                               collect (cadr f)))))
        (tickets (nearby-tickets input)))
    (dolist (ticket tickets)
      (dolist (n ticket)
        (when (not (member n field-numbers))
          (setf tickets (remove ticket tickets :test #'equal)))))
    tickets))


(defun part2 (input)
  (let* ((fields (make-fields input))
         (tickets (valid-tickets input fields)))
    tickets))
