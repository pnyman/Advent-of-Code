(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(use-package :arrow-macros)

(defpackage 2023-day-8
  (:use :cl))

(in-package :2023-day-8)

(defun get-input ()
  (let* ((input (uiop:read-file-lines "input/day-08-input.txt"))
         (instructions (mapcar (lambda (x) (if (eq x #\L) 0 1))
                               (coerce (first input) 'list)))
         (nodes (make-hash-table :test 'equal)))
    (loop for line in (rest (rest input))
          for (k v) = (str:split "=" line)
          for val = (->> (str:split "," v)
                      (mapcar (lambda (x) (str:trim x)))
                      (mapcar (lambda (x) (str:replace-all "(" "" x )))
                      (mapcar (lambda (x) (str:replace-all ")" "" x ))))
          do (setf (gethash (str:trim k) nodes) val))
    (values instructions nodes)))

(defun solve-1 ()
  (let ((steps 0)
        (node "AAA"))
    (multiple-value-bind (instructions nodes) (get-input)
      (loop
        (loop for lr in instructions do
          (incf steps)
          (setf node (nth lr (gethash node nodes)))
          (when (equal node "ZZZ")
            (return-from solve-1 steps)))))))

(defun count-steps (instructions nodes node)
  (let ((steps 0))
    (loop
      (loop for lr in instructions do
        (incf steps)
        (setf node (nth lr (gethash node nodes)))
        (when (str:ends-with? "Z" node)
          (return-from count-steps steps))))))

(defun solve-2 ()
  (multiple-value-bind (instructions nodes) (get-input)
    (apply 'lcm
           (loop for node being the hash-keys in nodes
                 when (str:ends-with? "Z" node)
                   collect (count-steps instructions nodes node)))))
