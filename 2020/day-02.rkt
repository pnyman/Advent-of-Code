#lang racket

(define count-substring
  (compose length regexp-match*))

(let ([input (file->lines "day-02-input.txt")]
      [ctr 0])
  (for ([i input])
    (let* ([matches (cdr (regexp-match #rx"([0-9]+)-([0-9]+) ([a-z]): ([a-z]+)" i))]
           [min (string->number (list-ref matches 0))]
           [max (string->number (list-ref matches 1))]
           [letter (list-ref matches 2)]
           [pw (list-ref matches 3)]
           [count (count-substring letter pw)])
      (when (<= min count max)
        (set! ctr (add1 ctr)))))
  ctr)

(let ([input (file->lines "day-02-input.txt")]
      [ctr 0])
  (for ([i input])
    (let* ([matches (cdr (regexp-match #rx"([0-9]+)-([0-9]+) ([a-z]): ([a-z]+)" i))]
           [min (string->number (list-ref matches 0))]
           [max (string->number (list-ref matches 1))]
           [letter (list-ref matches 2)]
           [pw (list-ref matches 3)]
           [count 0])
      (for ([m (list min max)])
        (when (equal? letter (substring pw (sub1 m) m))
          (set! count (add1 count))))
      (when (= 1 count)
        (set! ctr (add1 ctr)))))
  ctr)

;; (match-define (list min max letter pw)
;;   (cdr (regexp-match #rx"([0-9]+)-([0-9]+) ([a-z]): ([a-z]+)" i)))
;; (println (list min max letter pw))
