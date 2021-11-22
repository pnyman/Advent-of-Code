(ql:quickload :alexandria)
(ql:quickload :uiop)
(ql:quickload :split-sequence)
(ql:quickload :cl-ppcre)

(defun input ()
  (let ((initial-state '()))
    (loop for line in (uiop:read-file-lines "input/day-17-example.txt")
          for x below 3
          do (loop for c across line
                   for y below 3
                   when (char= c #\#)
                     do (push (list x y 0) initial-state)))
    initial-state))

(defun get-active-neighours (cubes x y z)
  (let ((active 0))
    (loop for dx from -1 to 1 do
      (loop for dy from -1 to 1 do
        (loop for dz from -1 to 1 do
          (when (and (not (= 0 dx dy dz))
                     (member (list (+ x dx) (+ y dy) (+ z dz)) cubes :test #'equal))
            (incf active)))))
    active))

(defun input ()
  (let ((initial-state (make-array '(3 3))))
    (loop for line in (uiop:read-file-lines "input/day-17-example.txt")
          for i below 3
          do (loop for c across line
                   for j below 3
                   do (setf (aref initial-state i j) c)))
    initial-state))

(defun active? (cubes row col)
  (char= #\# (aref cubes row col)))

(defun count-active-neighbours (cubes row col)
  (let ((active 0))
    (destructuring-bind (rows cols) (array-dimensions cubes)
      (when (and (> row 0)
                 (active? cubes (1- row) col))
        (incf active))
      (when (and (< row (1- rows))
                 (active? cubes (1+ row) col))
        (incf active))
      (when (and (> col 0)
                 (active? cubes row (1- col)))
        (incf active))
      (when (and (< col (1- cols))
                 (active? cubes row (1+ col)))
        (incf active)))
    active))

(defun flip-state (cubes)
  "- If a cube is active and exactly 2 or 3 of its neighbors are also active,
     the cube remains active. Otherwise, the cube becomes inactive.
   - If a cube is inactive but exactly 3 of its neighbors are active,
     the cube becomes active. Otherwise, the cube remains inactive."
  (let ((turn-active '())
        (turn-inactive '()))

    (destructuring-bind (rows cols) (array-dimensions cubes)
      (loop for row below rows do
        (loop for col below cols do
          (let ((active-neighbours (count-active-neighbours cubes row col)))
            (cond ((and (active? cubes row col)
                        (not (<= 2 active-neighbours 3)))
                   (push (list row col) turn-inactive))
                  ((and (not (active? cubes row col))
                        (= 3 active-neighbours))
                   (push (list row col) turn-active)))))))

    (loop for coords in turn-active
          do (destructuring-bind (row col) coords
               (setf (aref cubes row col) #\#)))

    (loop for coords in turn-inactive
          do (destructuring-bind (row col) coords
               (setf (aref cubes row col) #\.)))

    turn-inactive))
