(ql:quickload :arrow-macros)

(defpackage AoC-2015-22
  (:use :cl)
  (:use :arrow-macros))

(in-package :AoC-2015-22)

(defparameter *spells*
  (list (list :name "Magic Missile"
              :cost 53
              :duration 1
              :effect (lambda (x)
                        (incf (getf x :damage) 4)))
        (list :name "Drain"
              :cost 73
              :duration 1
              :effect #'drain)
        (list :name "Shield"
              :cost 113
              :duration 6
              :effect #'shield)
        (list :name "Poison"
              :cost 173
              :duration 6
              :effect #'poison)
        (list :name "Recharge"
              :cost 229
              :duration 5
              :effect #'recharge)))

(defun missile  (player) (incf (getf player :damage) 4))
(defun drain    (player) (incf (getf player :damage) 2) (incf (getf player :hp 2)))
(defun shield   (player) (incf (getf player :armor) 7))
(defun poison   (player) (incf (getf player :damage) 3))
(defun recharge (player) (incf (getf player :mana) 101))

(defun attack (attacker defender)
  (decf (getf defender :hp)
        (max 1 (- (getf attacker :damage)
                  (getf defender :armor)))))

(defun win-battle-p (player boss)
  (loop while (and (plusp (getf player :hp))
                   (plusp (getf boss :hp)))
        do (attack player boss)
           (attack boss player)
        finally
           (return (plusp (getf player :hp)))))
