(ql:quickload :uiop)

(defpackage 2024-day-9 (:use :cl))
(in-package :2024-day-9)


(defstruct diskblock
  position
  value
  id)


(defun get-input ()
  (let* ((contents (uiop:read-file-string "input/day-09-test.txt"))
         (input (loop for c in (coerce contents 'list)
                      for d = (digit-char-p c)
                      when d collect d))
         (val -1))
    (loop for elt in input
          for i from 0
          for value = (if (zerop (mod i 2)) (incf val) nil)
          ;; do (if (zerop (mod i 2)) (setf value (1+ value)))
          when (plusp elt)
            append (loop for n from 1 to elt
                         collect (make-diskblock :position i
                                                 :value value
                                                 :id i)))))


2333133121414131402


(defun compact ()
  (let ((blocks (get-input)))
    (loop for block in (reverse blocks)
          when (diskblock-id block)
            do (loop for b in blocks
                     do (when (not (diskblock-id b))
                          (setf (diskblock-value b) (diskblock-value block))
                          (setf (diskblock-id b) (diskblock-id block))
                          (setf (diskblock-id block) nil)
                          (return))
                     ))
    blocks))


(defun part-1 ()
  (loop for b in (compact)
        when (diskblock-id b)
          sum (* (diskblock-position b) (diskblock-id b))))











;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun get-input ()
  (let* ((contents (uiop:read-file-string "input/day-09-testinput.txt"))
         (input (loop for c in (coerce contents 'list)
                      for d = (digit-char-p c)
                      when d collect d)))
    (loop for i from 0 below (length input) by 2
          append (loop for x from 1 to (nth i input) collect (/ i 2))
          when (< i (1- (length input)))
            append (loop for x from 1 to (nth (1+ i) input) collect #\.))))

;; 20 sekunder
(defun compact (disk-map &optional (end (length disk-map)))
  (if (not (find #\. disk-map :end end))
      (subseq disk-map 0 end)
      (let ((pos (position #\. disk-map :end end))
            (last-char (nth (1- end) disk-map)))
        (setf (nth pos disk-map) last-char)
        (compact disk-map (1- end)))))


(defun foo (diskmap)
  (let ((high (length diskmap)))
    (loop for i from 0 to (1- (length diskmap))
          for c = (nth i diskmap)
          when (eq c #\.)
            do (rotatef (nth i diskmap) (nth (decf high) diskmap))
               (setf (nth (- high i) diskmap) #\+)))
  diskmap)


  (defun foo (diskmap)
    (let ((high (length diskmap)))
      (loop for i from 0 below (/ (1+ high) 2)
            for j = (- high i)
            do (when (eq (nth i diskmap) #\.)
                 (rotatef (nth i diskmap) (nth j diskmap)))))
    diskmap)




(defun part-1 ()
  (loop for n in (compact (get-input))
        for i from 0
        sum (* n i)))

2333133121414131402

00...111...2...333.44.5555.6666.777.888899
0099811188827773336446555566..............

(00)(...)(111)(...)(2)(...)(333)(.)(44)(.)(5555)(.)(6666)(.)(777)(.)(8888)(99)
