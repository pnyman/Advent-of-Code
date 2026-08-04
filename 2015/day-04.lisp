(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(use-package :arrow-macros)

(ql:quickload :md5)

(defpackage AoC-2015-04
  (:use :cl))

(in-package :AoC-2015-04)

;;; part 1

(defun bytes-to-hex-string (bytes)
  (string-downcase
   (with-output-to-string (s)
     (loop for byte across bytes
           do (format s "~2,'0X" byte)))))

(defun solve-1 ()
  (let ((input "ckczppom"))
    (loop for n from 0
          for md5 = (bytes-to-hex-string (md5:md5sum-string (format nil "~a~a" input n)))
          when (string= (subseq md5 0 5) "00000")
            return n)))

;;; part 1 snabbare:

(defun md5-has-five-leading-zeros-p (bytes)
  (and (= (aref bytes 0) 0)
       (= (aref bytes 1) 0)
       (< (aref bytes 2) 16)))

(defun solve-1 ()
  (let ((input "ckczppom"))
    (loop for n from 0
          for md5 = (md5:md5sum-string (concatenate 'string input (write-to-string n)))
          when (md5-has-five-leading-zeros-p md5)
            return n)))

;;; part 2

(defun md5-has-six-leading-zeros-p (bytes)
  (and (= (aref bytes 0) 0)
       (= (aref bytes 1) 0)
       (= (aref bytes 2) 0)))

(defun solve-2 ()
  (let ((input "ckczppom"))
    (loop for n from 0
          for md5 = (md5:md5sum-string (concatenate 'string input (write-to-string n)))
          when (md5-has-six-leading-zeros-p md5)
            return n)))
