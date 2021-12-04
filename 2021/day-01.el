(defun input ()
  (with-temp-buffer
    (insert-file-contents "input/day-01-input.txt")
    (loop for elt in (split-string (buffer-string) "\n" t)
          collect (string-to-number elt))))

(defun solve (input window)
  (length
   (loop for i below (- (length input) window)
         when (< (nth i input)
                 (nth (+ i window) input))
         collect i)))


(defun solve (input window)
  (loop for i below (- (length input) window)
        count (< (nth i input)
                 (nth (+ i window) input))))


(solve (input) 1) ; 1711
(solve (input) 3) ; 1743

(loop for (a b) on '(1 2 3 4) by #'cddr collect (cons a b))
