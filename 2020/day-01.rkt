#lang racket

(define nums (map string->number (file->lines "input/day-01-input.txt")))

(for*/first ((i nums)
             (j nums)
             #:when (= 2020 (+ i j)))
  (* i j))
;; 927684

(for*/first ((i nums)
             (j nums)
             (k nums)
             #:when (= 2020 (+ i j k)))
  (* i j k))
;; 292093004
