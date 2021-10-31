#lang racket

(define input (file->lines "input/day-05-input.txt"))

(define (to-bit c)
  (match c
    ((or #\F #\L) #\0)
    ((or #\B #\R) #\1)))

(define (find-seat str)
  (string->number (list->string (map to-bit (string->list str))) 2))

(define seats
  (for/list ([line input])
    (find-seat line)))

(define max-id (apply max seats))

max-id

(for/last ([x (in-range max-id)]
           #:when (not (member x seats)))
  x)
