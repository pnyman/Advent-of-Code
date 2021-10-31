#lang racket

(define input (file->lines "input/day-03-input.txt"))

(define (rows down)
  (for/list ((line input)
             (row (in-naturals))
             #:when (zero? (modulo row down)))
    (string->list line)))

(define (trees right (down 1))
  (for/fold ((acc 0))
            ((row (rows down))
             (col (in-range 0 +inf.0 right)))
    (if (equal? #\# (list-ref row (modulo col (length row))))
        (add1 acc)
        acc)))

;; (define (trees right (down 1))
;;   (for/fold ((acc 0)
;;              (col 0)
;;              #:result acc)
;;             ((row (rows down)))
;;     (if (equal? #\# (list-ref row (modulo col (length row))))
;;         (values (add1 acc) (+ col right))
;;         (values acc (+ col right)))))

(trees 3)
;; 209

(* (trees 1) (trees 3) (trees 5) (trees 7) (trees 1 2))
;; 1574890240
