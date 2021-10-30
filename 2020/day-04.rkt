#lang racket

(let ([input (file->lines "day-04-input.txt")]
      [ht (make-hash)]
      [passports '()]
      [valid 0])

  ;; hack med append för att den sista skall lägas till passports
  (for ([line (append input '(""))])
    (if (equal? "" line)
        (begin (set! passports (append passports (list ht)))
               (set! ht (make-hash)))
        (for ([entry (string-split line)])
          (match-define (list key val)
            (string-split entry ":"))
          (hash-set! ht key val))))

  ;; (set! passports (append passports (list ht)))

  (for ([p passports])
    (when (for/and ([key '("byr" "ecl" "eyr" "hcl" "hgt" "iyr" "pid")])
            (hash-ref p key #f))
      (set! valid (add1 valid))))

  valid)
