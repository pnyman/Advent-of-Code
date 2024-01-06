(ql:quickload :uiop)

(defpackage 2023-day-3
  (:use :cl))

(in-package :2023-day-3)

(defun get-input ()
  "Make a list of lists."
  (mapcar (lambda (x) (coerce x 'list))
          (uiop:read-file-lines "input/day-03-input.txt")))


(defun get-number-coords (data)
  "Get the coordinates and values of all numbers."
  (let ((numbers nil)
        (temp (list nil nil)))
    (loop for r below (length data) do
      (loop for c below (length (nth 0 data))
            for char = (nth c (nth r data)) do
              (block continue
                (when (digit-char-p char)
                  (push char (first temp))
                  (push (list r c) (second temp))
                  (return-from continue))
                (when (first temp)
                  (setf (first temp)
                        (parse-integer (concatenate 'string (reverse (first temp)))))
                  (push temp numbers)
                  (setf temp (list nil nil))))))
    numbers))


(defun get-gears (data)
  "Find the coordinates for all gears (stars)."
  (let ((gears nil))
    (loop for r below (length data) do
      (loop for c below (length (nth 0 data)) do
        (when (char= #\* (nth c (nth r data)))
          (push (list r c) gears))))
    gears))


(defun make-deltas (coords)
  (destructuring-bind (r c) coords
    (list (list r (1- c))
          (list r (1+ c))
          (list (1- r) c)
          (list (1+ r) c)
          (list (1- r) (1- c))
          (list (1+ r) (1- c))
          (list (1- r) (1+ c))
          (list (1+ r) (1+ c)))))


(defun adjacent-symbol-p (data coords)
  "Check if any of the coords have an adjacent symbol."
  (loop for rc in coords do
    (loop for delta in (make-deltas rc) do
      (ignore-errors
       (let ((char (nth (second delta) (nth (first delta) data))))
         (when (not (or (digit-char-p char)
                        (char= char #\.)))
           (return-from adjacent-symbol-p t)))))))


(defun adjacent-numbers (gear numbers)
  "Check if there is exactly 2 numbers adjacent to the gear."
  (let ((hits nil))
    (loop for number in numbers do
      (loop for delta in (make-deltas gear)
            when (member delta (second number) :test 'equal)
              do (push (first number) hits)))
    (setf hits (remove-duplicates hits))
    (when (= 2 (length hits)) hits)))


(defun solve-1 ()
  (let ((data (get-input)))
    (loop for number in (get-number-coords data)
          when (adjacent-symbol-p data (second number))
            sum (first number) into result
          finally (return result))))


(defun solve-2 ()
  (let* ((data (get-input))
         (numbers (get-number-coords data))
         (gears (get-gears data)))
    (loop for gear in gears
          for adjacent = (adjacent-numbers gear numbers)
          when adjacent
            sum (reduce #'* adjacent) into result
          finally (return result))))
