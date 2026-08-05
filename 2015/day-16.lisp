(ql:quickload :uiop)
(ql:quickload :str)
(ql:quickload :arrow-macros)
(use-package :arrow-macros)

(defpackage AoC-2015-16
  (:use :cl))

(in-package :AoC-2015-16)

;;; prepare

(defparameter *clues*
  (list :children 3
        :cats 7
        :samoyeds 2
        :pomeranians 3
        :akitas 0
        :vizslas 0
        :goldfish 5
        :trees 3
        :cars 2
        :perfumes 1))

(defun make-kw (str)
  (-<> str
    (remove-if-not #'alphanumericp <>)
    string-upcase
    (intern :keyword)))

(defun get-input ()
  (uiop:read-file-lines "input/day-16.txt"))

(defun parse-input (input)
  (loop for line in input
        collect (loop for (key val) on (str:words line) by #'cddr
                      append (list (make-kw key)
                                   (parse-integer val :junk-allowed t)))))

;;; part 1

(defun test-aunt-1 (aunt)
  (loop for (key val) on aunt by #'cddr
        always (or (eq key :sue)
                   (= val (getf *clues* key)))))

(defun solve-1 (input)
  (let ((data (parse-input input)))
    (loop for aunt in data
          when (test-aunt-1 aunt)
            return aunt)))

;;; part 2

(defun test-aunt-2 (aunt)
  (loop for (key val) on aunt by #'cddr
        always (or (eq key :sue)
                   (cond ((or (eq key :cats)
                              (eq key :trees))
                          (> val (getf *clues* key)))
                         ((or (eq key :pomeranians)
                              (eq key :goldfish))
                          (< val (getf *clues* key)))
                         (t (= val (getf *clues* key)))))))

(defun solve-2 (input)
  (let ((data (parse-input input)))
    (loop for aunt in data
          when (test-aunt-2 aunt)
            return aunt)))
