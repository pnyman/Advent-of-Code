(ql:quickload :uiop)
(ql:quickload :arrow-macros)
(ql:quickload :iterate)
(ql:quickload :str)

(defpackage 2025-day-2
  (:use :cl :arrow-macros :iterate))

(in-package :2025-day-2)

(defparameter *input* "input/day-02-input.txt")

(defun get-input ()
  (iter (for token in (str:split "," (uiop:read-file-line *input*)))
        (collect (mapcar #'parse-integer (str:split "-" token)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun part-1 ()                        ; 28846518423
  (iter (with result = 0)
        (for (start end) in (get-input))
        (iter (for num from start to end)
              (for s = (write-to-string num))
              (for half = (/ (length s) 2))
              (and (evenp (length s))
                   (string= (subseq s 0 half) (subseq s half))
                   (incf result num)))
        (finally (return result))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun unique-factors (num)
  (iter (with acc = nil)
        (with f = 1)
        (while (> num 1))
        (incf f)
        (iter (while (zerop (mod num f)))
              (pushnew f acc)
              (setf num (/ num f)))
        (finally (return acc))))

(defun invalidp (num)
  (iter (with s = (write-to-string num))
        (with len = (length s))
        (for f in (unique-factors len))
        (iter (with step = (/ len f))
              (for i from 0 below len by step)
              (adjoining (subseq s i (+ i step)) into acc :test #'string=)
              (finally (when (= 1 (length acc))
                         (return-from invalidp t))))))

(defun part-2 ()                        ; 31578210022
  (iter (with result = 0)
        (for (start end) in (get-input))
        (iter (for num from start to end)
              (when (invalidp num) (incf result num)))
        (finally (return result))))
