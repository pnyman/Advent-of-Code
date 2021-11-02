#lang racket

(define input
  (string-split (file->string "input/day-06-input.txt") "\n\n"))

(for/fold ([answer1 0]
           [answer2 0])
          ([line input])
  (let ([questions (make-hash)]
        [persons (string-split line "\n")])
    (for* ([p persons]
           [c (string->list p)])
      (hash-set! questions c (add1 (hash-ref! questions c 0))))
    (values (+ answer1 (hash-count questions))
            (+ answer2 (for/fold ([acc 0])
                                 ([v (hash-values questions)])
                         (if (= v (length persons)) (add1 acc) acc))))))
