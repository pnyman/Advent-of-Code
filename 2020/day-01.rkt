#lang racket

(let* ([input (file->lines "day-01-input.txt")]
       [len (length input)])
  ;; part 1
  (for*/first ([i (in-range (- len 1))]
               [j (in-range (+ i 1) len)]
               #:when (= 2020 (+ (string->number (list-ref input i))
                                 (string->number (list-ref input j)))))
    (println (* (string->number (list-ref input i))
                (string->number (list-ref input j)))))
  ;; part 2
  (for*/first ([i (in-range (- len 2))]
               [j (in-range (+ i 1) (- len 1))]
               [k (in-range (+ j 1) len)]
               #:when (= 2020 (+ (string->number (list-ref input i))
                                 (string->number (list-ref input j))
                                 (string->number (list-ref input k)))))
        (println (* (string->number (list-ref input i))
                    (string->number (list-ref input j))
                    (string->number (list-ref input k))))))
