(ql:quickload :uiop)
(ql:quickload :arrow-macros)
(ql:quickload :iterate)
(ql:quickload :str)

(defpackage 2025-day-6
  (:use :cl :arrow-macros :iterate))
(in-package :2025-day-6)

(defparameter *input* "../input/day-06-input.txt")

(defun get-input ()
  (apply #'mapcar #'list
         (iter (for line in (uiop:read-file-lines *input*))
               (collect (str:split " " line :omit-nulls t)))))

(defun column-widths ()
  (iter (for line in (get-input))
        (collect (->> line (mapcar #'length) (apply #'max)))))

(defun get-input-with-padding ()
  (apply #'mapcar #'list
         (iter (with widths = (column-widths))
               (for line in (uiop:read-file-lines *input*))
               (collect
                   (iter (with len = (length line))
                         (with i = 0)
                         (for w in widths)
                         (for end = (+ i w))
                         ;; Since my Emacs removes whitespace at the end of lines:
                         (when (< len end)
                           (let ((padding (make-string (- end len) :initial-element #\Space)))
                             (setf line (concatenate 'string line padding))))
                         (collect (subseq line i end) into acc)
                         (incf i (1+ w))
                         (finally (return acc)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 6891729672676
(defun part-1 (&optional input)
  (iter (for problem in (or input (get-input)))
        (for op = (str:trim (car (last problem))))
        (sum (->> (butlast problem)
               (mapcar (lambda (x) (parse-integer x :junk-allowed t)))
               (apply (cond ((string= op "+") #'+)
                            ((string= op "*") #'*))))
             into result)
        (finally (return result))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun transpose-str-columns (lst)
  (let* ((data (butlast lst))
         (last (car (last lst)))
         (maxlen (apply #'max (mapcar #'length data))))
    (append
     (loop for i below maxlen
           for str = (loop for s in data
                           when (< i (length s))
                             collect (char s i))
           collect (coerce str 'string))
     (list last))))

;; 9770311947567
(defun part-2 ()
  (iter (for line in (get-input-with-padding))
        (collect (transpose-str-columns line) into acc)
        (finally (return (part-1 acc)))))
