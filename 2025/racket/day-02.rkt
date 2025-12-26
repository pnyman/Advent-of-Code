#lang racket
(require threading)

(define *input* "../input/day-02-test.txt")

(define (get-input)
  (for/list ([token (string-split (file->string *input*) ",")])
    (map (λ~> (string-trim) (string->number))
         (string-split token "-"))))



;; (defun part-1 ()                        ; 28846518423
;;   (iter (with result = 0)
;;         (for (start end) in (get-input))
;;         (iter (for num from start to end)
;;               (for s = (write-to-string num))
;;               (for half = (/ (length s) 2))
;;               (and (evenp (length s))
;;                    (string= (subseq s 0 half) (subseq s half))
;;                    (incf result num)))
;;         (finally (return result))))
