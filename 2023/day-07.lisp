(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :serapeum)
(use-package :str)
(use-package :serapeum)

(defpackage 2023-day-7
  (:use :cl))

(in-package :2023-day-7)

(defun get-input (part)
  (let ((input (uiop:read-file-lines "input/day-07-input.txt"))
        (cards (dict "A" 14 "K" 13 "Q" 12 "J" (if (= part 1) 11 1) "T" 10)))
    (loop for line in input
          for (a b) = (str:words line)
          for hand = (mapcar (lambda (x)
                               (or (gethash (string x) cards)
                                   (digit-char-p x)))
                             (coerce a 'list))
          collect (list hand (parse-integer b)))))

(defun count-occurrences (lst &optional (result nil))
  "Return a list of frequencies of each element in lst."
  (if (null lst)
      result
      (count-occurrences (remove (first lst) lst)
                         (cons (count (first lst) lst) result))))

(defun sort-games (games)
  (flet ((to-string (hand)
           (format nil "~{~A~}" (mapcar (lambda (x) (code-char (+ 64 x))) hand))))
    (sort games (lambda (a b)
                  (cond ((= (first a) (first b))
                         (string< (to-string (second a)) (to-string (second b))))
                        (t (< (first a) (first b))))))))

(defun solve (part)
  (let ((games (loop for (hand bet) in (get-input part)
                     for freqs = (count-occurrences hand)
                     for J = (count 1 hand)
                     for type = (cond ((member 5 freqs) 6)
                                      ((member 4 freqs) (if (plusp J) 6 5))
                                      ((and (member 3 freqs) (member 2 freqs))
                                       (if (plusp J) 6 4))
                                      ((member 3 freqs) (if (plusp J) 5 3))
                                      ((= 2 (count 2 freqs))
                                       (cond ((= 1 J) 4)
                                             ((= 2 J) 5)
                                             (t 2)))
                                      ((member 2 freqs) (if (plusp J) 3 1))
                                      ((plusp J) 1)
                                      (t 0))
                     collect (list type hand bet))))
    (loop for game in (sort-games games)
          for i from 1
          sum (* i (third game)))))
