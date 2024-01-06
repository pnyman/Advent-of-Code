(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(ql:quickload :cl-ppcre)
(ql:quickload :alexandria)
(use-package :str)
(use-package :arrow-macros)

(defpackage 2023-day-5
  (:use :cl))

(in-package :2023-day-5)

(defun get-input ()
  (let* ((input (cl-ppcre:split
                 "\\n\\s*\\n"
                 (uiop:read-file-string "input/day-05-input.txt")))
         (seeds (->> (split-omit-nulls " " (second (split ":" (first input))))
                  (mapcar #'parse-integer)))
         (maps (loop for block in (rest input)
                     collect
                     (->> (rest (split-omit-nulls #\Newline block))
                       (mapcar (lambda (x) (split-omit-nulls " " x)))
                       (mapcar (lambda (x) (mapcar #'parse-integer x)))))))
    (values seeds maps)))


(defun solve-1 ()
  (multiple-value-bind (seeds maps) (get-input)
    (loop for map in maps do
      (loop for seed in seeds
            for i below (length seeds) do
              (loop for (a b c) in map 
                    when (and (<= b seed) (< seed (+ b c)))
                      do (setf (nth i seeds) (+ (- seed b) a)))))
    (apply #'min seeds)))


(defun solve-2 ()
  (multiple-value-bind (ranges maps) (get-input)
    (let ((seeds (loop for i below (length ranges) by 2
                       collect (list (nth i ranges) (+ (nth i ranges) (nth (1+ i) ranges))))))
      (loop for map in maps do
        (loop for seed in seeds 
              for i from 0
              for (start end) = seed do
                (loop named inner for (a b c) in map
                      for overlap-start = (max start b)
                      for overlap-end = (min end (+ b c)) do
                        (when (< overlap-start overlap-end)
                          (setf (nth i seeds) (list (+ (- overlap-start b) a)
                                                    (+ (- overlap-end b) a)))
                          (when (> overlap-start start) 
                            (nconc seeds (list (list start b))))
                          (when (< overlap-end end)
                            (nconc seeds (list (list (+ b c) end))))
                          (return-from inner)))))
      (first (sort (alexandria:flatten seeds) #'<)))))
