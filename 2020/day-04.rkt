#lang racket

(define input
  (string-split (file->string "input/day-04-input.txt") #px"\r\n\r\n"))

(define passports
  (for/fold ([acc '()])
            ([line input])
    (cons (for/fold ([ht (hash)])
                    ([entry (string-split line)])
            (match-define (list key val)
              (string-split entry ":"))
            (hash-set ht key val))
          acc)))

(define (valid1? passport)
  (for/and ([key '("byr" "ecl" "eyr" "hcl" "hgt" "iyr" "pid")])
    (hash-ref passport key #f)))

(define (valid-height? hgt)
  (define matched (regexp-match #px"^(\\d+)(cm|in)$" hgt))
  (cond [matched (match-define (list _ val kind) matched)
                 (if (equal? kind "cm")
                     (<= 150 (string->number val) 193)
                     (<= 59 (string->number val) 76))]
         [else #f]))

(define (valid2? passport)
  (if (not (valid1? passport))
      #f
      (for/and ([key (hash-keys passport)])
        (define value (hash-ref passport key))
        (match key
          ("byr" (<= 1920 (string->number value) 2002))
          ("iyr" (<= 2010 (string->number value) 2020))
          ("eyr" (<= 2020 (string->number value) 2030))
          ("ecl" (member value '("amb" "blu" "brn" "gry" "grn" "hzl" "oth")))
          ("hgt" (valid-height? value))
          ("hcl" (regexp-match #px"^#[0-9a-f]{6}$" value))
          ("pid" (regexp-match #px"^[0-9]{9}$" value))
          ("cid" #t)))))

(count valid1? passports)
(count valid2? passports)

;; (define (passports (entries input) (ppts '()))
;;   (if (null? entries) ppts
;;       (let ([ht (make-hash)])
;;         (for ([entry (string-split (first entries))])
;;           (match-define (list key val)
;;             (string-split entry ":"))
;;           (hash-set! ht key val))
;;         (passports (rest entries) (append ppts (list ht))))))
