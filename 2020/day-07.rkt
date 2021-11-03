#lang racket
(require threading)

(define input (for/fold ([acc '()])
                        ([line (~> "input/day-07-input.txt"
                                   (file->string)
                                   (string-replace #rx"bags?|\\." "")
                                   (string-split "\n"))])
                (cons (string-split line "contain")
                      acc)))

(define (trim s)
  (string-trim s #:left? #t #:right? #t #:repeat? #t))

(define (make-node line)
  (cons (trim (first line))
        (list (for/fold ([acc '()])
                        ([bag (string-split (last line) ",")])
                (cons (~> bag
                          (string-replace #rx"[0-9]+" "")
                          (trim))
                      acc)))))

(define bags
  (for/fold ([acc (hash)])
            ([line input])
    (match-define (list key val) (make-node line))
        (hash-set acc key val)))

;; metod 1
(define bagset (mutable-set))

(define (find-shiny-gold (child "shiny gold"))
  (for ([bag (hash-keys bags)]
        #:when (member child (hash-ref bags bag)))
    (find-shiny-gold bag)
    (set-add! bagset bag)))

(find-shiny-gold)
(length (set->list bagset))

;; metod 2
(define (has-shiny-gold? bag)
  (define content (hash-ref bags bag #f))
  (if (not content) #f
      (or (member "shiny gold" content)
          (ormap has-shiny-gold? content))))

(count has-shiny-gold? (hash-keys bags))

;; 252
