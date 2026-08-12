(ql:quickload :arrow-macros)

(defpackage AoC-2015-21
  (:use :cl)
  (:use :arrow-macros))

(in-package :AoC-2015-21)

(defparameter *weapons*
  '((4  8)
    (5 10)
    (6 25)
    (7 40)
    (8 74)))

(defparameter *armor*
  '((1  13)
    (2  31)
    (3  53)
    (4  75)
    (5 102)))

(defparameter *rings*
  '((1  25)
    (2  50)
    (3 100)
    (-1 20)    ; armor values are negative
    (-2 40)    ; to distinguish them
    (-3 80)))

(defun ring-choices ()
  "Alla sätt att välja 0, 1 eller 2 UNIKA ringar."
  (append
   (list nil)                                    ; 0 ringar
   (mapcar #'list *rings*)                       ; 1 ring
   (loop for (r1 . rest) on *rings*
         append (loop for r2 in rest
                      collect (list r1 r2)))))   ; 2 unika ringar

(defun gear-sets ()
  (loop for w in *weapons*
        append
        (loop for a in (cons nil *armor*)
              append
              (loop for rs in (ring-choices)
                    collect (gear-stats w a rs)))))

(defun gear-stats (w a rs)
  (list :cost (+ (second w)
                 (if a (second a) 0)
                 (->> rs
                   (mapcar #'second)
                   (reduce #'+)))
        :damage (+ (first w)
                   (->> rs
                     (mapcar #'first)
                     (remove-if-not #'plusp)
                     (reduce #'+)))
        :armor (+ (if a (first a) 0)
                  (-<>> rs
                    (mapcar #'first)
                    (remove-if #'plusp)
                    (reduce #'+)
                    (abs <>)))))

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

(defun solve ()
  (loop for gear in (gear-sets)
        for cost = (getf gear :cost)
        for player = (list :hp 100
                           :damage (getf gear :damage)
                           :armor (getf gear :armor))
        for boss = (list :hp 109 :damage 8 :armor 2)
        if (win-battle-p player boss)
          minimize cost into a
        else
          maximize cost into b
        finally
           (format t "min: ~A, max: ~A" a b)))
