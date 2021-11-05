#lang racket

(define data
  (string-split (file->string "input/day-08-input.txt") "\n"))


(define (part1 input (index 0) (accumulator 0) (visited (mutable-seteq)))
    (cond [(> index (sub1 (length input))) (list #t accumulator)]
          [(set-member? visited index) (list #f accumulator)]
          [else (set-add! visited index)
                (match-define (list operation argument)
                  (string-split (list-ref input index)))
                (match operation
                  ["acc"
                   (part1 input (add1 index) (+ accumulator (string->number argument)) visited)]
                  ["jmp"
                   (part1 input (+ index (string->number argument)) accumulator visited)]
                  ["nop"
                   (part1 input (add1 index) accumulator visited)])]))


(define (part2 input (start 0))
  (define clone input)
  (define (inner i)
    (match-define (list operation argument)
      (string-split (list-ref input i)))
    (match operation
      ["jmp"
       (set! clone (list-set clone i (string-join (list "nop" argument))))
       (set! start (add1 i))]
      ["nop"
       (set! clone (list-set clone i (string-join (list "jmp" argument))))
       (set! start (add1 i))]
      [else (inner (add1 i))]))
  (inner start)
  (define result (part1 clone))
  (if (list-ref result 0)
      (list-ref result 1)
      (part2 input start)))


(second (part1 data))
(part2 data)
