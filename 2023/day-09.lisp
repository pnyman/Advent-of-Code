(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(use-package :arrow-macros)

(defpackage 2023-day-9
  (:use :cl))

(in-package :2023-day-9)

(defun get-input ()
  (->> (uiop:read-file-lines "input/day-09-input-test.txt")
    (mapcar (lambda (x) (mapcar 'parse-integer (str:words x))))))

(defun get-input ()
  (mapcar (lambda (x) (mapcar 'parse-integer (str:words x)))
          (uiop:read-file-lines "input/day-09-input.txt")))


(defun get-next-value (history part)
  (let ((sequences (list history)))
    (loop for seq = (first (last sequences))
          while (notevery 'zerop seq) do
            (nconc sequences (list (loop for i from 1 below (length seq)
                                         collect (- (nth i seq)
                                                    (nth (1- i) seq))))))

    (when (= 1 part)
      (loop for i from (- (length sequences) 2) downto 0
            for val = (+ (first (last (nth i sequences)))
                         (first (last (nth (1+ i) sequences))))
            do (nconc (nth i sequences) (list val)))
      (return-from get-next-value (first (last (first sequences)))))

    (when (= 2 part)
      (loop for i from (- (length sequences) 2) downto 0
            for val = (- (first (nth i sequences))
                         (first (nth (1+ i) sequences)))
            do (push val (nth i sequences)))
      (first (first sequences)))))


(defun solve-1 ()
  (reduce #'+ (loop for history in (get-input)
                    collect (get-next-value history 1))))


(defun solve-2 ()
  (reduce #'+ (loop for history in (get-input)
                    collect (get-next-value history 2))))
