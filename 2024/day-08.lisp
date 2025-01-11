(ql:quickload :uiop)
(ql:quickload :serapeum)
(serapeum:toggle-pretty-print-hash-table)

(defpackage 2024-day-8 (:use :cl))
(in-package :2024-day-8)

(defun get-input ()
  (let ((lines (uiop:read-file-lines "input/day-08-input.txt"))
        (map (make-hash-table :test 'equal)))
    (loop for line in lines
          for real from 0 do
            (loop for c in (coerce line 'list)
                  for imag from 0
                  for position = (complex real imag)
                  do (setf (gethash position map) c)))
    map))

(defun collate-frequencies (map)
  (let ((frequencies (make-hash-table)))
    (maphash (lambda (key val)
               (when (not (eql val #\.))
                 (if (gethash val frequencies)
                     (setf (gethash val frequencies) (cons key (gethash val frequencies)))
                     (setf (gethash val frequencies) (list key)))))
             map)
    frequencies))

(defun direction (p1 p2)
  (complex (- (realpart p2) (realpart p1))
           (- (imagpart p2) (imagpart p1))))

(defun antinodes (p1 p2 map)
  (let ((node1 (- (* 2 p1) p2))
        (node2 (- (* 2 p2) p1))
        (nodes nil))
    (when (gethash node1 map)
      (push node1 nodes))
    (when (gethash node2 map)
      (push node2 nodes))
    nodes))

(defun antinodes-2 (p1 p2 map)
  (let ((dir (direction p1 p2))
        (nodes nil))
    (loop while (gethash p1 map) do
      (push p1 nodes)
      (incf p1 dir))
    (loop while (gethash p2 map) do
      (push p2 nodes)
      (decf p2 dir))
    (remove-duplicates nodes)))

(defun solve (&optional (part-2 nil))
  (let* ((map (get-input))
         (frequencies (collate-frequencies map))
         (result nil))
    (loop for key being the hash-key of frequencies
          for nodes = (gethash key frequencies)
          for len = (length nodes) do
            (loop for i from 0 below (1- len) do
              (loop for j from (1+ i) below len
                    for n1 = (nth i nodes)
                    for n2 = (nth j nodes)
                    do (setf result (append result
                                            (antinodes n1 n2 map)
                                            (when part-2
                                              (antinodes-2 n1 n2 map)))))))
    (length (remove-duplicates result))))
