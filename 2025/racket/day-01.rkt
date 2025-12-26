#lang racket
(require threading)

(define input "../input/day-01-input.txt")

(define (get-input)
  (map (λ~> (string-replace "L" "-")
            (string-replace "R" "")
            (string->number))
       (file->lines input)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (part-1)                        ; 1135
  (for/fold ([arrow 50]
             [zeroes 0]
             #:result zeroes)
            ([value (get-input)])
    (let ([arrow (modulo (+ arrow value) 100)])
      (values arrow
              (if (zero? arrow)
                  (add1 zeroes)
                  zeroes)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (passes start step)
  (let ([end (+ start step)])
    (cond [(positive? step) (floor (/ end 100))]
          [(negative? step) (- (floor (/ (sub1 start) 100))
                               (floor (/ (sub1 end) 100)))]
          [else 0])))

(define (part-2)                        ; 6558
  (for/fold ([arrow 50]
             [clicks 0]
             #:result clicks)
            ([value (get-input)])
    (values (modulo (+ arrow value) 100)
            (+ clicks (passes arrow value)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (day-1)
  (for/fold ([arrow 50]
             [zeroes 0]
             [clicks 0]
             #:result (list zeroes clicks))
            ([value (get-input)])
    (let ([new-arrow (modulo (+ arrow value) 100)])
      (values new-arrow
              (if (zero? new-arrow)
                  (add1 zeroes)
                  zeroes)
              (+ clicks (passes arrow value))))))
