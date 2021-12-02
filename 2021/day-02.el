(defun input ()
  (with-temp-buffer
    (insert-file-contents "input/day-02-input.txt")
    (loop for line in (split-string (buffer-string) "\n" t)
          collect (funcall
                   (lambda (x) (list (car x) (string-to-number (cadr x))))
                   (split-string line " " t)))))

(defun solve-1 (input)
  (let ((hor 0) (dep 0))
    (dolist (elt input)
      (pcase (car elt)
        ("forward" (incf hor (cadr elt)))
        ("down" (incf dep (cadr elt)))
        ("up" (decf dep (cadr elt)))))
    (* hor dep)))

(defun solve-2 (input)
  (let ((hor 0) (dep 0) (aim 0))
    (dolist (elt input)
      (pcase (car elt)
        ("forward"
         (incf hor (cadr elt))
         (incf dep (* aim (cadr elt))))
        ("down" (incf aim (cadr elt)))
        ("up" (decf aim (cadr elt)))))
    (* hor dep)))

(solve-1 (input)) ; 1762050
(solve-2 (input)) ; 1855892637
