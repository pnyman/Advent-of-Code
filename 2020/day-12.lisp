(ql:quickload "uiop")

(defun input ()
  (loop for s in (uiop:read-file-lines "input/day-12-input.txt")
        collect (cons (char (subseq s 0 1) 0)
                      (parse-integer (subseq s 1)))))

(defparameter *east* 0)
(defparameter *south* 90)
(defparameter *west* 180)
(defparameter *north* 270)

(defstruct ship
  (bearing *east*)
  (x 0)
  (y 0))

(defun execute-sequence (sequence)
  (let ((ship (make-ship)))
    (loop for s in sequence
          do (destructuring-bind (instruction . value) s
               (case instruction
                 (#\N (decf (ship-y ship) value))
                 (#\S (incf (ship-y ship) value))
                 (#\W (decf (ship-x ship) value))
                 (#\E (incf (ship-x ship) value))
                 (#\R (setf (ship-bearing ship)
                            (mod (+ (ship-bearing ship) value) 360)))
                 (#\L (setf (ship-bearing ship)
                            (mod (- (ship-bearing ship) value) 360)))
                 (#\F (case (ship-bearing ship)
                        (180 (decf (ship-x ship) value))
                        (0 (incf (ship-x ship) value))
                        (270 (decf (ship-y ship) value))
                        (90 (incf (ship-y ship) value)))))))
    (+ (abs (ship-x ship)) (abs (ship-y ship)))))

(execute-sequence (input)) ; 1007
