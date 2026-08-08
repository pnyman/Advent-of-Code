(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :serapeum)
(ql:quickload :arrow-macros)
(use-package :arrow-macros)

(defpackage AoC-2015-19
  (:use :cl)
  (:use :arrow-macros)
  (:import-from :serapeum #:string-replace #:string-replace-all #:string-count))

(in-package :AoC-2015-19)

(defparameter *test*
  '("e => H"
    "e => O"
    "H => HO"
    "H => OH"
    "O => HH"
    ""
    "HOH"))

(defun get-input ()
  (uiop:read-file-lines "input/day-19.txt"))

(defun parse-input (input)
  (let ((rules)   (molecule))
    (loop for line in input do
      (cond ((str:emptyp line) nil)
            ((search "=>" line)
             (let ((rule (str:words line)))
               (push (list (first rule) (third rule)) rules)))
            (t (setf molecule line))))
    (list rules molecule)))

;;; patr 1

(defun generate (str old new)
  (loop for start = 0 then (1+ m)
        for m = (search old str :start2 start)
        while m
        collect (string-replace old str new :start start)))

(defun solve-1 (input)
  (let* ((data (parse-input input))
         (rules (nth 0 data))
         (molecule (nth 1 data)))
    (-<> rules
      (mapcan (lambda (x) (generate molecule (first x) (second x))) <>)
      (remove-duplicates :test 'equal)
      length)))

;;; part 2

;; https://www.reddit.com/r/adventofcode/comments/3xflz8/day_19_solutions/cy4etju/

;; (solve-2 (nth 1 (parse-input (get-input))))
(defparameter *m* (nth 1 (parse-input (get-input))))

(defun solve-2 (molecule)
  (- (length (remove-if-not #'upper-case-p molecule))
     (string-count "Rn" molecule)
     (string-count "Ar" molecule)
     (* 2 (string-count "Y" molecule))
     1))
