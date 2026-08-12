(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(use-package :arrow-macros)

(defpackage AoC-2015-11
  (:use :cl))

(in-package :AoC-2015-11)

(defparameter *input* "vzbxkghb")

(defun rotate-password (pw)
  (let* ((len (length pw))
         (foo (loop for c in pw
                    for n downfrom (1- len)
                    sum (* (- c 97) (expt 26 n)))))
    (incf foo)
    (reverse (loop repeat len
                   collect (+ (mod foo 26) 97)
                   do (setf foo (floor foo 26))))))

(defun rule-1 (pw)
  (loop for i below (- (length pw) 2)
          thereis (= (+ 2 (nth i pw))
                     (+ 1 (nth (+ i 1) pw))
                     (nth (+ i 2) pw))))

(defun rule-2 (pw)
  (loop for n in pw
        never (or (= n 105)
                  (= n 108)
                  (= n 111))))

(defun rule-3 (pw)
  (let ((hits nil))
    (loop for i below (1- (length pw))
          when (= (nth i pw) (nth (1+ i) pw))
            do (pushnew (nth i pw) hits)
            thereis (= (length hits) 2))))

(defun solve (input) ; -> vzbxxyzz
  (let ((pw (mapcar #'char-code (coerce input 'list))))
    (setf pw (rotate-password pw))
    (loop until (and (rule-1 pw)
                     (rule-2 pw)
                     (rule-3 pw))
          do (setf pw (rotate-password pw))
          finally (return (coerce (mapcar #'code-char pw) 'string)))))
