(ql:quickload :uiop)
(ql:quickload :cl-ppcre)
(ql:quickload :alexandria)

(defclass queue ()
  ((q
    :initarg q
    :accessor q
    :initform '())))

(defgeneric enqueue (elt p)
  (:documentation "Puts elt last in the queue."))

(defgeneric dequeue (p)
  (:documentation "Removes the first element from the queue and returns it."))

(defgeneric empty? (p)
  (:documentation "Checks if the queue is empty."))

(defmethod enqueue (elt (p queue))
  (setf (slot-value p 'q) (reverse (cons elt (reverse (slot-value p 'q))))))

(defmethod dequeue ((p queue))
  (let ((elt (first (slot-value p 'q))))
    (setf (slot-value p 'q) (rest (slot-value p 'q)))
    elt))

(defmethod empty? ((p queue))
  (null (slot-value p 'q)))

(defclass stack ()
  ((s
    :initarg s
    :accessor s
    :initform '())))

(defgeneric stack-push (elt p)
  (:documentation "Puts an element on top of the stack"))

(defgeneric stack-pop (p)
  (:documentation "Removes the top element from the stack and returns it."))

(defmethod stack-push (elt (p stack))
  (setf (slot-value p 's) (cons elt (slot-value p 's))))

(defmethod stack-pop (p)
  (let ((elt (first (slot-value p 's))))
    (setf (slot-value p 's) (rest (slot-value p 's)))
    elt))

(defmethod empty? ((p stack))
  (null (slot-value p 's)))

(defparameter operators '(= + - * / ^))


(defun input ()
  (loop for line in (uiop:read-file-lines "input/day-18-example.txt")
        collect (remove " " (cl-ppcre:split "" line) :test #'equal)))


(defun input ()
  (loop for line in (uiop:read-file-lines "input/day-18-example.txt")
        collect (loop for c across line
                      when (char/= #\space c)
                        collect (cond ((char= #\+ c) #'+)
                                      ((char= #\* c) #'*)
                                      ((digit-char-p c) (digit-char-p c))
                                      (t c)))))




(defun solve (expr &optional acc)
  (format t "~a ~a~%" acc expr)
  (if (null expr)
      acc
      (let ((token (car expr)))
        (cond ((numberp token) (solve (rest expr) token))
              ((functionp token) (apply token (list (solve (rest expr) acc) acc)))
              ((char= #\( token)
               (let ((openp 1))
                 (loop for x in (rest expr)
                       for i from 1 do
                         (cond ((and (characterp x)
                                     (char= x #\()) (incf openp))
                               ((and (characterp x)
                                     (char= x #\))) (decf openp)))
                         (when (zerop openp)
                           (return (solve (subseq expr 1 i) acc))))))))))


1 + 2 * 3

;; (solve (1 + 2 * 3))
;; (solve (+ 2 * 3) 1)
;; (apply +
;;        (solve (2 * 3) 1)  (solve (* 3) 2)
;;                           (apply *
;;                                  (solve (3) 2) (solve () 3)
;;                                                3
;;                                  2)
;;
;;        1)
