(ql:quickload "uiop")

(defun input ()
  (loop for s in (uiop:read-file-lines "input/day-12-input.txt")
        collect (cons (char (subseq s 0 1) 0)
                      (parse-integer (subseq s 1)))))

;; (defparameter *east* 0)
;; (defparameter *south* 90)
;; (defparameter *west* 180)
;; (defparameter *north* 270)

(defstruct ship
  (bearing 0)
  (x 0)
  (y 0))

(defstruct waypoint
  (x 10)
  (y -1))

(defun rotate (wp degrees)
  (let* ((radians (* degrees (/ pi 180)))
         (s (sin radians))
         (c (cos radians))
         (x-new (- (* (waypoint-x wp) c)
                    (* (waypoint-y wp) s)))
         (y-new (+ (* (waypoint-x wp) s)
                    (* (waypoint-y wp) c))))
    (setf (waypoint-x wp) (round x-new))
    (setf (waypoint-y wp) (round y-new)))
  wp)

(defun part-1 (sequence)
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

(defun part-2 (sequence)
  (let ((ship (make-ship))
        (wp (make-waypoint)))
    (loop for s in sequence
          do (destructuring-bind (instruction . value) s
               (case instruction
                 (#\N (decf (waypoint-y wp) value))
                 (#\S (incf (waypoint-y wp) value))
                 (#\W (decf (waypoint-x wp) value))
                 (#\E (incf (waypoint-x wp) value))
                 (#\R (setf wp (rotate wp value)))
                 (#\L (setf wp (rotate wp (* -1 value))))
                 (#\F (loop repeat value
                            do (incf (ship-x ship) (waypoint-x wp))
                               (incf (ship-y ship) (waypoint-y wp)))))))
    (+ (abs (ship-x ship)) (abs (ship-y ship)))))


(part-1 (input)) ; 1007
(part-2 (input)) ; 41212
