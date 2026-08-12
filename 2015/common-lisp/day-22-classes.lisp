(defclass spell () ())

(defmethod dec-duration ((spell spell))
  (decf (duration spell)))

(defmethod incur-cost ((spell spell) player)
  (decf (getf player :mana) (cost spell)))

(defmethod expiredp ((spell spell))
  (zerop (duration spell)))

;; magic-missile
(defclass magic-missile (spell)
  ((cost :reader cost :initform 53)
   (duration :accessor duration :initform 1)))

(defmethod effect ((spell magic-missile) player)
  (incf (getf player :damage) 4)
  (incur-cost spell player)
  (dec-duration spell))

(defmethod cancel ((spell magic-missile) player)
  (when (zerop (duration spell))
    (decf (getf player :damage) 4)))

;; drain
(defclass drain (spell)
  ((cost :reader cost :initform 73)
   (duration :accessor duration :initform 1)))

(defmethod effect ((spell drain) player)
  (incf (getf player :hp) 2)
  (incf (getf player :damage) 2)
  (incur-cost spell player)
  (dec-duration spell))

(defmethod cancel ((spell drain) player)
  (when (zerop (duration spell))
    (decf (getf player :damage) 2)))

;; shield
(defclass shield (spell)
  ((cost :reader cost :initform 113)
   (duration :accessor duration :initform 6)))

(defmethod effect ((spell shield) player)
  (incf (getf player :armor) 7)
  (incur-cost spell player)
  (dec-duration spell))

(defmethod cancel ((spell shield) player)
  (when (zerop (duration spell))
    (decf (getf player :armor) 7)))

;; poison
(defclass poison (spell)
  ((cost :reader cost :initform 173)
   (duration :accessor duration :initform 6)))

(defmethod effect ((spell poison) player)
  (incf (getf player :damage) 3)
  (incur-cost spell player)
  (dec-duration spell))

(defmethod cancel ((spell poison) player)
  (when (zerop (duration spell))
    (decf (getf player :damage) 3)))

;; recharge
(defclass recharge (spell)
  ((cost :reader cost :initform 229)
   (duration :accessor duration :initform 5)))

(defmethod effect ((spell recharge) player)
  (incf (getf player :mana) 101)
  (incur-cost spell player)
  (dec-duration spell))

(defmethod cancel ((spell recharge) player)
  (declare (ignore spell player))
  nil)
