#lang racket
(require threading)

(define input (for/fold ([acc '()])
                        ([line (~> "input/day-07-input.txt"
                                   (file->string)
                                   (string-replace #rx"bags|\\." "")
                                   (string-split "\n"))])
                (cons (string-split line "contain")
                      acc)))

(define (clean s)
  (~> s
      (string-trim #:left? #t #:right? #t #:repeat? #t)
      (string-replace " " "-")))

(define (make-node line)
  (cons (clean (first line))
        (list (for/fold ([acc '()])
                        ([bag (string-split (last line) ",")])
                (cons (~> bag
                          (string-replace #rx"[0-9]+" "")
                          (clean))
                      acc)))))

(define bags
  (for/fold ([acc (hash)])
            ([line input])
    (match-define (list key val) (make-node line))
        (hash-set acc key val)))

(define bagset (mutable-set))

(define (find-shiny-gold (child "shiny-gold"))
  (for ([bag (hash-keys bags)])
    (when (member child (hash-ref bags bag))
      (find-shiny-gold bag)
      (set-add! bagset bag))))

(find-shiny-gold)
(length (set->list bagset))

(define (has-shiny-gold? bag)
  (define content (hash-ref bags bag #f))
  (if (not content) #f
      (or (member "shiny-gold" content)
          (ormap has-shiny-gold? content))))

(count has-shiny-gold? (hash-keys bags))

;; 109 < x < 551
;; != 120
;; != 135

;; (define input (string-split
;;                (string-replace
;;                 "dotted silver bags contain 2 dotted orange bags, 3 bright fuchsia bags, 5 bright tomato bags, 3 faded turquoise bags."
;;                 #rx"bags|\\." "")
;;                "contain"))



;; (define foo (string-replace
;;              (string-trim #:left? #t #:right? #t #:repeat? #t (first input))
;;              " " "-"))
;; (define bar
;;   (for/fold ([acc '()])
;;             ([bag (string-split (last input) ",")])
;;     (cons
;;      (string-replace
;;       (string-trim #:left? #t #:right? #t #:repeat? #t
;;                    (string-replace bag #rx"[0-9]+" ""))
;;       " " "-")
;;      acc)))



;; (string-replace
;;  (string-trim #:left? #t #:right? #t #:repeat? #t (first line))
;;  " " "-")


;; (string-replace (string-trim #:left? #t #:right? #t #:repeat? #t
;;                              (string-replace bag #rx"[0-9]+" ""))
;;                 " " "-")



;; (string-split
;;  (string-replace input #rx"bags|\\." "")
;;  "contain")
