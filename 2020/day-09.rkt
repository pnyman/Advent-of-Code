#lang racket

(define input
  (for/list
      ([s (string-split (file->string "input/day-09-input.txt") "\n")])
    (string->number s)))

(define preamble 25)

(define (part1 data)
  (if (for*/first
          ([i (in-range 0 (sub1 preamble))]
           [j (in-range (add1 i) preamble)]
           #:when (= (list-ref data preamble)
                     (+ (list-ref data i) (list-ref data j))))
        #t)
      (part1 (rest data))
      (list-ref data preamble)))


(part1 input)
