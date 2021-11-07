(ql:quickload "uiop")
(ql:quickload "alexandria")

(defun input ()
  (let ((temp (loop for line in (uiop:read-file-lines "input/day-11-input.txt")
                    collect (loop for char across line collect char))))
    (make-array (list (length temp) (length (first temp)))
                :initial-contents temp)))


(defun change-seat-part-1 (grid this-row this-col)
  (let ((rows (1- (array-dimension grid 0)))
        (cols (1- (array-dimension grid 1)))
        (seat (aref grid this-row this-col))
        (adjacent-occupied 0))
    (loop for pos in '((-1 -1) (-1 0) (-1 1)
                       (0 -1) (0 1)
                       (1 -1) (1 0) (1 1))
          for row = (+ this-row (first pos))
          for col = (+ this-col (second pos))
          when (and (and (<= 0 row rows) (<= 0 col cols))
                    (char= #\# (aref grid row col)))
            do (incf adjacent-occupied))
    (cond ((and (char= seat #\L) (zerop adjacent-occupied)) #\#)
          ((and (char= seat #\#) (>= adjacent-occupied 4)) #\L)
          (t seat))))


(defun change-seat-part-2 (grid this-row this-col)
  (let ((rows (1- (array-dimension grid 0)))
        (cols (1- (array-dimension grid 1)))
        (seat (aref grid this-row this-col))
        (adjacent-occupied 0))
    (loop for pos in '((-1 -1) (-1 0) (-1 1)
                       (0 -1) (0 1)
                       (1 -1) (1 0) (1 1))
          do (loop for dy = (first pos)
                   for dx = (second pos)
                   for row = (+ this-row dy) then (+ row dy)
                   for col = (+ this-col dx) then (+ col dx)
                   while (and (<= 0 row rows) (<= 0 col cols))
                   when (char= #\L (aref grid row col))
                     do (return)
                   when (char= #\# (aref grid row col))
                     do (incf adjacent-occupied)
                        (return)))
    (cond ((and (char= seat #\L) (zerop adjacent-occupied)) #\#)
          ((and (char= seat #\#) (>= adjacent-occupied 5)) #\L)
          (t seat))))


(defun count-occupied-seats (grid)
  (let ((rows (array-dimension grid 0))
        (cols (array-dimension grid 1))
        (sum 0))
    (loop for r below rows
          do (loop for c below cols
                   when (eq (aref grid r c) #\#)
                     do (incf sum)))
    sum))


(defun solution (fn &optional (present (input)) (past nil))
  (if (equalp present past)
      (count-occupied-seats present)
      (let ((past (alexandria:copy-array present)))
        (loop for r below (array-dimension present 0)
              do (loop for c below (array-dimension present 1)
                       do (setf (aref present r c)
                                (funcall fn past r c))))
        (solution fn present past))))

(solution 'change-seat-part-1) ; 2494
(solution 'change-seat-part-2) ; 2306
