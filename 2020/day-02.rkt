#lang racket

(define count-substring
  (compose length regexp-match*))

(define (parse-line line)
  (match-define (list from to letter pw)
    (cdr (regexp-match #rx"([0-9]+)-([0-9]+) ([a-z]): ([a-z]+)" line)))
  (values (string->number from) (string->number to) letter pw))

(define (valid1? line)
  (let-values ([(from to letter pw) (parse-line line)])
    (<= from (count-substring letter pw) to)))

(count valid1? (file->lines "input/day-02-input.txt"))

(define (valid2? line)
  (let-values ([(ind1 ind2 letter pw) (parse-line line)])
    (xor (equal? letter (substring pw (sub1 ind1) ind1))
         (equal? letter (substring pw (sub1 ind2) ind2)))))

(count valid2? (file->lines "input/day-02-input.txt"))
