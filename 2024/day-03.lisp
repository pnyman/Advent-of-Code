(ql:quickload :uiop)
(ql:quickload "cl-ppcre")
(ql:quickload :arrow-macros)

(defpackage 2024-day-3
  (:use :cl :arrow-macros))
(in-package :2024-day-3)

(defun get-input ()
  (uiop:read-file-string "input/day-03-input.txt"))

(defun part-1 ()
  (let* ((pattern (ppcre:create-scanner "mul\\((\\d+),(\\d+)\\)"))
         (input (ppcre:all-matches-as-strings pattern (get-input))))
    (reduce #'+
            (loop for match in input
                  collect
                  (ppcre:register-groups-bind ((#'parse-integer a b))
                      (pattern match)
                    (* a b))))))


(defun part-1 ()
  (let ((pattern (ppcre:create-scanner "mul\\((\\d+),(\\d+)\\)")))
    (-> (get-input)
      (->> (ppcre:all-matches-as-strings pattern)
        (mapcar (lambda (match)
                  (ppcre:register-groups-bind ((#'parse-integer a b))
                      (pattern match)
                    (* a b))))
        (reduce #'+)))))


(defun part-2 ()
  (let* ((pattern (ppcre:create-scanner "mul\\((\\d+),(\\d+)\\)|(do\\(\\))|(don't\\(\\))"))
         (input (ppcre:all-matches-as-strings pattern (get-input)))
         (enabled t)
         (sum 0))
    (loop for match in input do
      (ppcre:register-groups-bind ((#'parse-integer a b) on off)
          (pattern match)
        (cond (on (setf enabled t))
              (off (setf enabled nil))
              (t (when enabled (incf sum (* a b)))))))
    sum))


(defun part-2 ()
  (let* ((pattern (ppcre:create-scanner "mul\\((\\d+),(\\d+)\\)|(do\\(\\))|(don't\\(\\))"))
         (enabled t))
    (-> (get-input)
      (->> (ppcre:all-matches-as-strings pattern)
        (mapcar (lambda (match)
                  (ppcre:register-groups-bind ((#'parse-integer a b) on off)
                      (pattern match)
                    (cond (on (setf enabled t))
                          (off (setf enabled nil))
                          (t (when enabled (* a b)))))))
        (reduce #'+)))))
