(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(use-package :arrow-macros)

(defpackage AoC-2015-14
  (:use :cl)
  (:use :arrow-macros))

(in-package :AoC-2015-14)

(defun get-input ()
  (uiop:read-file-lines "input/day-14.txt"))

(defun get-test-input ()
  (uiop:read-file-lines "input/day-14-test.txt"))

(defun parse-input (input)
  (loop for line in input
        for data = (str:split " " line)
        collect (list :name (read-from-string (nth 0 data))
                      :speed (parse-integer (nth 3 data))
                      :flight (parse-integer (nth 6 data))
                      :rest (parse-integer (nth 13 data))
                      :distance 0
                      :points 0)))

;;; part 1

(defun distance-traveled (reindeer max-time)
  (let ((time 0) (dist 0))
    (loop while (<= time max-time) do
      (incf dist (* (getf reindeer :speed)
                    (min (getf reindeer :flight) (- max-time time))))
      (incf time (+ (getf reindeer :flight)
                    (getf reindeer :rest))))
    dist))

(defun solve-1 (input &optional (max-time 2503))
  (let ((data (parse-input input)))
    (loop for reindeer in data
          maximizing (distance-traveled reindeer max-time))))

;;; part 2

(defun advance (reindeer time)
  (let ((flight (getf reindeer :flight))
        (rest (getf reindeer :rest)))
    (when (<= 1 (mod time (+ flight rest)) flight)
      (incf (getf reindeer :distance) (getf reindeer :speed)))))

(defun award-point (data)
  (let ((max-dist
          (reduce #'max data :key (lambda (r) (getf r :distance)))))
    (dolist (reindeer data)
      (when (= (getf reindeer :distance) max-dist)
        (incf (getf reindeer :points))))))

(defun solve-2 (input &optional (max-time 2503))
  (let ((data (parse-input input)))
    (loop for time from 1 to max-time do
      (dolist (reindeer data)
        (advance reindeer time))
      (award-point data))
    (-> data
        (sort #'> :key (lambda (x) (getf x :points)))
        first
        (getf :points))))
