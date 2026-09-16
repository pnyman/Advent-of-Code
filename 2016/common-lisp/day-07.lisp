(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(ql:quickload :cl-ppcre)

(defpackage AoC-2016-07
  (:use :cl)
  (:use :arrow-macros))

(in-package :AoC-2016-07)

(defun get-input ()
  (->> "../input/day-07.txt"
    (uiop:read-file-lines)
    (mapcar (lambda (x) (str:split "\\[|\\]" x :regex t)))))

(defun has-abba-p (parts)
  (let ((outside nil) (inside nil))
    (loop for part in parts
          for i from 0 do
            (when (cl-ppcre:register-groups-bind (a b)
                      ("(.)(.)\\2\\1" part)
                    (string/= a b))
              (if (evenp i)
                  (setf outside t)
                  (setf inside t))))
    (and outside (not inside))))

(defun find-abas (str)
  (loop for i below (- (length str) 2)
        when (and (eq (char str i) (char str (+ i 2)))
                  (not (eq (char str i) (char str (1+ i) ))))
          collect (subseq str i (+ i 2))))

(defun make-bab (aba)
  (coerce (list (char aba 1) (char aba 0) (char aba 1)) 'string))

(defun supports-ssl-p (parts)
  (loop for part in parts for i from 0 when (evenp i) do
    (loop for aba in (find-abas part)  for bab = (make-bab aba) do
      (loop for part in parts for j from 0
            when (and (oddp j)
                      (str:containsp bab part))
              do (return-from supports-ssl-p t)))))

(defun solve-1 (input)
  (length (remove-if-not #'has-abba-p input)))

(defun solve-2 (input)
  (length (remove-if-not #'supports-ssl-p input)))
