(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(use-package :arrow-macros)
(ql:quickload :screamer)
(screamer:define-screamer-package :AoC-2015-17)
(in-package :AoC-2015-17)

(defun get-input ()
  (mapcar #'parse-integer
          (uiop:read-file-lines "input/day-17.txt")))

(defun fill-containers (containers target)
  (cond
    ((zerop target) 0)
    ((null containers) (fail))
    (t (let ((c (first containers)))
         (if (> c target)
             (fill-containers (rest containers) target)
             (either
               (1+ (fill-containers (rest containers) (- target c)))
               (fill-containers (rest containers) target)))))))

(defun solve (containers target)
  (let ((sizes nil))
    (for-effects
      (push (fill-containers containers target) sizes))
    (values (length sizes) sizes)))

(defun solve-1 (containers &optional (target 150))
  (nth-value 0 (solve containers target)))

(defun solve-2 (containers &optional (target 150))
  (let* ((sizes (nth-value 1 (solve containers target)))
         (min-size (reduce #'min sizes)))
    (count min-size sizes)))
