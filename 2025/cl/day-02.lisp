(ql:quickload :uiop)
(ql:quickload :arrow-macros)
(ql:quickload :iterate)
(ql:quickload :str)

(defpackage 2025-day-2
  (:use :cl :arrow-macros :iterate))

(in-package :2025-day-2)

(defparameter *input* "../input/day-02-input.txt")

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

(defun invalidp (num)
  (iter (with len = (1+ (truncate (log num 10))))
        (for f from 2 to len)
        (when (zerop (mod len f))
          (for pow = (expt 10 (/ len f)))
          (for acc = (* (mod num pow) (/ (1- (expt pow f)) (1- pow))))
          (when (= acc num)
            (return-from invalidp t)))))

(defun part-2 ()                        ; 31578210022
  (iter (with result = 0)
        (for (start end) in (get-input))
        (iter (for num from start to end)
              (when (invalidp num) (incf result num)))
        (finally (return result))))
