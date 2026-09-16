(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(use-package :arrow-macros)

(defpackage AoC-2016-04
  (:use :cl))

(in-package :AoC-2016-04)

(defun get-input ()
  (-<>> "../input/day-04.txt"
    (uiop:read-file-lines <>)
    (mapcar (lambda (x) (substitute #\- #\[ x)))
    (mapcar (lambda (x) (remove #\] x)))
    (mapcar (lambda (x) (str:rsplit "-" x :limit 3)))
    (loop for (a b c) in <>
          collect (list (remove #\- a) (parse-integer b) c))))

(defun calculate-checksum (s)
  (-<> (copy-seq s)
    (sort <> (lambda (x y)
               (let ((a (count x <>)) (b (count y <>)))
                 (if (/= a b) (> a b) (char< x y)))))
    (remove-duplicates)
    (subseq 0 5)))

(defun real-room-p (room)
  (string= (calculate-checksum (first room)) (third room)))

(defun rotate (text key)
  (let ((a (char-code #\a))
        (m (mod key 26)))
    (-> (loop for ch across text
              for b = (char-code ch)
              collect (code-char (+ (mod (+ (- b a) m) 26) a)))
        (coerce 'string))))

(defun solve-1 (input)
  (loop for room in input
        when (real-room-p room)
          sum (second room)))

(defun solve-2 (input)
  (loop for room in input
        when (and (real-room-p room)
                  (search "north" (rotate (first room) (second room))))
          return (second room)))
