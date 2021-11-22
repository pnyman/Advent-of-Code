(ql:quickload :uiop)

(defun input ()
  (let ((initial-state '()))
    (loop for line in (uiop:read-file-lines "input/day-17-input.txt")
          for x below 8
          do (loop for c across line
                   for y below 8
                   when (char= c #\#)
                     do (push (list x y 0) initial-state)))
    initial-state))

(defun find-bounds (cubes)
  (let ((result '()))
    (dotimes (i 3)
      (push (1- (reduce #'min (mapcar (lambda (x) (nth i x)) cubes))) result)
      (push (1+ (reduce #'max (mapcar (lambda (x) (nth i x)) cubes))) result))
    (reverse result)))

(defun count-active-neighbours (cubes x y z)
  (let ((active 0))
    (loop for dx from -1 to 1 do
      (loop for dy from -1 to 1 do
        (loop for dz from -1 to 1 do
          (when (and (not (= 0 dx dy dz))
                     (member (list (+ x dx) (+ y dy) (+ z dz)) cubes :test #'equal))
            (incf active)))))
    active))

(defun flip-state (cubes)
  "- If a cube is active and exactly 2 or 3 of its neighbors are also active,
     the cube remains active. Otherwise, the cube becomes inactive.
   - If a cube is inactive but exactly 3 of its neighbors are active,
     the cube becomes active. Otherwise, the cube remains inactive."
  (let ((new-state '()))
    (destructuring-bind (x-min x-max y-min y-max z-min z-max) (find-bounds cubes)
      (loop for x from x-min to x-max do
        (loop for y from y-min to y-max do
          (loop for z from z-min to z-max do
            (let ((active-neighbours (count-active-neighbours cubes x y z)))
              (when (or (and (member (list x y z) cubes :test #'equal)
                             (<= 2 active-neighbours 3))
                        (and (not (member (list x y z) cubes :test #'equal))
                             (= 3 active-neighbours)))
                (push (list x y z) new-state)))))))
    new-state))


(defun solve ()
  (let ((cubes (input)))
    (dotimes (i 6)
      (setf cubes (flip-state cubes)))
    (length cubes)))
;;;; 276

;;;; ========== Part 2 ================================

(defun input-2 ()
  (let ((initial-state '()))
    (loop for line in (uiop:read-file-lines "input/day-17-input.txt")
          for x below 8
          do (loop for c across line
                   for y below 8
                   when (char= c #\#)
                     do (push (list x y 0 0) initial-state)))
    initial-state))

(defun find-bounds-2 (cubes)
  (let ((result '()))
    (dotimes (i 4)
      (push (1- (reduce #'min (mapcar (lambda (x) (nth i x)) cubes))) result)
      (push (1+ (reduce #'max (mapcar (lambda (x) (nth i x)) cubes))) result))
    (reverse result)))

(defun count-active-neighbours-2 (cubes x y z w)
  (let ((active 0))
    (loop for dx from -1 to 1 do
      (loop for dy from -1 to 1 do
        (loop for dz from -1 to 1 do
          (loop for dw from -1 to 1 do
            (when (and (not (= 0 dx dy dz dw))
                       (member (list (+ x dx) (+ y dy) (+ z dz) (+ w dw))
                               cubes :test #'equal))
              (incf active))))))
    active))

(defun flip-state-2 (cubes)
  "- If a cube is active and exactly 2 or 3 of its neighbors are also active,
     the cube remains active. Otherwise, the cube becomes inactive.
   - If a cube is inactive but exactly 3 of its neighbors are active,
     the cube becomes active. Otherwise, the cube remains inactive."
  (let ((new-state '()))
    (destructuring-bind (x-min x-max y-min y-max z-min z-max w-min w-max)
        (find-bounds-2 cubes)
      (loop for x from x-min to x-max do
        (loop for y from y-min to y-max do
          (loop for z from z-min to z-max do
            (loop for w from w-min to w-max do
              (let ((active-neighbours (count-active-neighbours-2 cubes x y z w)))
                (when (or (and (member (list x y z w) cubes :test #'equal)
                               (<= 2 active-neighbours 3))
                          (and (not (member (list x y z w) cubes :test #'equal))
                               (= 3 active-neighbours)))
                  (push (list x y z w) new-state))))))))
    new-state))

(defun solve-2 ()
  (let ((cubes (input-2)))
    (dotimes (i 6)
      (setf cubes (flip-state-2 cubes)))
    (length cubes)))
;; 2136
