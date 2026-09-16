(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(ql:quickload :cl-ppcre)

(defpackage AoC-2016-08
  (:use :cl)
  (:use :arrow-macros))

(in-package :AoC-2016-08)

(defun get-input ()
  (->> "../input/day-08.txt"
    (uiop:read-file-lines)
    (mapcar (lambda (x) (str:words x)))
    (mapcar (lambda (x)
              (let ((action (read-from-string (first x))))
                (if (eq action 'rect)
                    (let ((colrow (mapcar #'parse-integer (str:split "x" (second x)))))
                      (list :action action
                            :col (first colrow)
                            :row (second colrow)))
                    (list :action action
                          :axis (read-from-string (second x))
                          :nr (parse-integer (second (str:split "=" (third x))))
                          :amount (parse-integer (fifth x)))))))))

(defun 2d-array-to-list (array)
  (loop for i below (array-dimension array 0)
        collect (loop for j below (array-dimension array 1)
                      collect (aref array i j))))

(defun transpose (list-of-lists)
  (apply #'mapcar #'list list-of-lists))

(defun rotate (screen axis nr amount)
  (let* ((screen (copy-list (if (eq axis 'row)
                                screen
                                (transpose screen))))
         (tmp (nth nr screen)))
    (loop repeat amount do
      (setf tmp (butlast (push (first (last tmp)) tmp))))
    (setf (nth nr screen) tmp)
    (if (eq axis 'row)
        screen
        (transpose screen))))

(defun insert-spaces (row &optional (n 5))
  (with-output-to-string (s)
    (loop for bit in row
          for i from 1
          do (if (= bit 0)
                 (write-char #\Space s)
                 (princ bit s))
             (when (and (zerop (mod i n)) (< i (length row)))
               (write-char #\Space s)))))

;; 123
;; AFBUPZBJPS
(defun solve (input)
  (let ((screen (2d-array-to-list (make-array '(6 50)))))
    (dolist (instruction input)
      (if (eq (getf instruction :action) 'rect)
          (loop for row below (getf instruction :row) do
            (loop for col below (getf instruction :col) do
              (setf (nth col (nth row screen)) 1)))
          (setf screen (rotate screen
                               (getf instruction :axis)
                               (getf instruction :nr)
                               (getf instruction :amount)))))
    (format t "~{~A~%~}" (mapcar #'insert-spaces screen))
    (loop for row in screen
          sum (loop for col in row
                    count (= col 1)))))
