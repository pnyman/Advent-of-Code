(ql:quickload :uiop)
(ql:quickload :str)

(defpackage 2024-day-7 (:use :cl))
(in-package :2024-day-7)

(defun get-input ()
  (let ((lines (uiop:read-file-lines "input/day-07-input.txt")))
    (loop for line in lines
          collect
          (loop for c in (str:split " " line)
                collect
                (parse-integer c :junk-allowed t)))))

(defun evaluates-p (equation f)
  (let ((operators (funcall f (- (length equation) 2)))
        (goal (car equation))
        (terms (cdr equation)))
    (loop for ops in operators do
      (let ((stack terms))
        (loop for op in ops
              for a = (first stack)
              for b = (second stack)
              for tail = (rest (rest stack))
              do (setf stack (cons (funcall op a b) tail)))
        (when (= (car stack) goal)
          (return-from evaluates-p t)))))
  nil)

;;;;;;;;;;;;;;; part 1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun combinations (n)
  (if (= n 0)
      '(())
      (mapcan (lambda (prefix)
                (mapcar (lambda (op)
                          (cons op prefix))
                        '(+ *)))
              (combinations (1- n)))))

(defun part-1 ()
  (loop for equation in (get-input)
        when (evaluates-p equation #'combinations)
          sum (car equation)))

;;;;;;;;;;;;;;; part 2 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun || (a b)
  (parse-integer
   (format nil "~a~a" (write-to-string a) (write-to-string b))))

(defun combinations-2 (n)
  (if (= n 0)
      '(())
      (mapcan (lambda (prefix)
                (mapcar (lambda (op)
                          (cons op prefix))
                        '(+ * ||)))
              (combinations-2 (1- n)))))

(defun part-2 ()
  (loop for equation in (get-input)
        when (evaluates-p equation #'combinations-2)
          sum (car equation)))
