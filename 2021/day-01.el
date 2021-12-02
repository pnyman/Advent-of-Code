(defun input ()
  (with-temp-buffer
    (insert-file-contents "input/day-01-input.txt")
    (loop for elt in (split-string (buffer-string) "\n" t)
          collect (string-to-number elt))))

(defun solve (input skip)
  (length
   (loop for i below (- (length input) skip)
         when (< (nth i input)
                 (nth (+ i skip) input))
         collect i)))

(solve (input) 1) ; 1711
(solve (input) 3) ; 1743

(loop for (a b) on '(1 2 3 4) by #'cddr collect (cons a b))
