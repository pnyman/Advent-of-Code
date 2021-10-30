#lang racket

(struct position (x y) #:mutable)

(define (advance pos dx dy cols)
  (set-position-x! pos (modulo (+ (position-x pos) dx) cols))
  (set-position-y! pos (+ (position-y pos) dy)))

(define (tree? input pos)
  (equal? "#"
          (substring (list-ref input (position-y pos))
                     (position-x pos)
                     (add1 (position-x pos)))))

(let* ([input (file->lines "day-03-input.txt")]
       [rows (length input)]
       [cols (string-length (list-ref input 0))]
       [pos (position 0 0)]
       [ctr 0])
  (for ([_ input]
        #:break (> (position-y pos) rows))
    (when (tree? input pos)
      (set! ctr (add1 ctr)))
    (advance pos 3 1 cols))
  ctr)


(let* ([input (file->lines "day-03-input.txt")]
       [rows (length input)]
       [cols (string-length (list-ref input 0))]
       [total 1])
  (for ([c '((1 1) (3 1) (5 1) (7 1) (1 2))])
    (let ([pos (position 0 0)]
          [ctr 0])
      (for ([_ input]
            #:break (> (position-y pos) rows))
        (when (tree? input pos)
          (set! ctr (add1 ctr)))
        (advance pos (first c) (second c) cols))
      (set! total (* total ctr))))
  total)
