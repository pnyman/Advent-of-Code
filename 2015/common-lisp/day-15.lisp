(ql:quickload :str)
(ql:quickload :arrow-macros)
(use-package :arrow-macros)
(ql:quickload :screamer)
(screamer:define-screamer-package :AoC-15)
(in-package :AoC-15)

(defun get-input ()
  (-> "input/day-15.txt"
      uiop:read-file-lines
      parse-input))

(defun get-test-input ()
  (-> "input/day-15-test.txt"
      uiop:read-file-lines
      parse-input))

(defun parse-input (input)
  (loop for line in input
        for s = (str:words line)
        collect
        (loop for i from 2 to 10 by 2
              collect (-<> (nth i s)
                        (remove #\, <>)
                        parse-integer))))

(defun amounts-summing-to (n k)
  "Genererar icke-deterministiskt K icke-negativa heltal som summerar till N."
  (if (= k 1)
      (list n)
      (let ((x (an-integer-between 0 n)))
        (cons x (amounts-summing-to (- n x) (1- k))))))

(defun score (amounts ingredients)
  (let ((totals (list 0 0 0 0)))
    (loop for amt in amounts
          for ing in ingredients
          do (loop for i from 0 below 4
                   for prop in (subseq ing 0 4)  ; capacity durability flavor texture
                   do (incf (nth i totals) (* amt prop))))
    (reduce #'* (mapcar (lambda (x) (max x 0)) totals))))

(defun solve-1 (ingredients)
  (let ((best 0))
    (for-effects
      (let* ((amounts (amounts-summing-to 100 (length ingredients)))
             (s (score amounts ingredients)))
        (when (> s best) (setf best s))))
    best))

(defun solve-2 (ingredients)
  (let ((best 0))
    (for-effects
      (let* ((amounts (amounts-summing-to 100 (length ingredients)))
             (calories (reduce #'+ (mapcar #'* amounts (mapcar #'fifth ingredients)))))
        (when (= calories 500)
          (let ((s (score amounts ingredients)))
            (when (> s best) (setf best s))))))
    best))
