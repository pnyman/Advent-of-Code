(ql:quickload :uiop)

(defun get-input ()
  (uiop:read-file-lines "input/day-01-input.txt"))

(defun calories-per-elf (input)
  (let ((data nil)
        (calories 0))
    (loop for x in input
          do (if (equal x "")
                 (progn (push calories data)
                        (setq calories 0))
                 (incf calories (parse-integer x))))
    data))

(let ((data (sort (calories-per-elf (get-input)) #'>)))
  ;; part 1
  (print (car data))
  ;; part 2
  (print (reduce #'+ (subseq data 0 3))))
