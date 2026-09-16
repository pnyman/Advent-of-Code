(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :md5)
(ql:quickload :arrow-macros)
(use-package :arrow-macros)

(defpackage AoC-2016-05
  (:use :cl))

(in-package :AoC-2016-05)

(defun make-checksum (str num)
  (-<> (concatenate 'string str (write-to-string num))
    (md5:md5sum-string)
    (coerce 'list)
    (format nil "~{~(~2,'0x~)~}" <>)))

(defun solve-1 (&optional (input "ugkcyxxp"))
  (let ((i -1))
    (-> (loop repeat 8
              collect
              (loop for h = (make-checksum input (incf i))
                    when (str:starts-with-p "00000" h)
                      return (char h 5)))
        (coerce 'string))))

(defun solve-2 (&optional (input "ugkcyxxp"))
  (let ((password (make-array 8))
        (i -1))
    (loop while (member 0 (coerce password 'list)) do
      (loop for h = (make-checksum input (incf i))
            for p = (digit-char-p (char h 5))
            until (and (str:starts-with-p "00000" h)
                       p (< p 8)
                       (eq (aref password p) 0))
            finally (setf (aref password p) (char h 6))))
    (coerce password 'string)))
