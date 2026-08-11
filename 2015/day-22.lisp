(ql:quickload :arrow-macros)

(defpackage AoC-2015-22
  (:use :cl)
  (:use :arrow-macros))

(in-package :AoC-2015-22)

(defparameter *spells*
  (list (list :name 'missile  :cost  53 :duration 1)
        (list :name 'drain    :cost  73 :duration 1)
        (list :name 'shield   :cost 113 :duration 6)
        (list :name 'poison   :cost 173 :duration 6)
        (list :name 'recharge :cost 229 :duration 5)))

(defun find-spell (name)
  (find name *spells* :key (lambda (s) (getf s :name))))

(defun copy-game-state (game-state)
  (list :player-hp (getf game-state :player-hp)
        :mana (getf game-state :mana)
        :boss-hp (getf game-state :boss-hp)
        :boss-damage (getf game-state :boss-damage)
        :active-spells (mapcar #'copy-list (getf game-state :active-spells))))

(defun spell-active-p (spell-name game-state)
  (find spell-name (getf game-state :active-spells)
        :key (lambda (a) (getf (getf a :spell) :name))))

(defun current-armor (game-state)
  (if (spell-active-p 'shield game-state) 7 0))

(defun cast-spell (game-state spell-name)
  "Kastar SPELL-NAME. Returnerar ett NYTT game-state."
  (let* ((spell (find-spell spell-name))
         (new-state (copy-game-state game-state)))
    (decf (getf new-state :mana) (getf spell :cost))
    (case spell-name
      (missile (decf (getf new-state :boss-hp) 4))
      (drain (decf (getf new-state :boss-hp) 2)
       (incf (getf new-state :player-hp) 2))
      ((shield poison recharge)
       (push (list :spell spell :remaining (getf spell :duration))
             (getf new-state :active-spells))))
    new-state))

(defun apply-ongoing-effects (game-state)
  "Applicerar effekten av ALLA just nu aktiva besvärjelser,
minskar deras duration, och tar bort de som gått ut.
Returnerar ett NYTT game-state."
  (let ((new-state (copy-game-state game-state)))
    (when (spell-active-p 'poison new-state)
      (decf (getf new-state :boss-hp) 3))
    (when (spell-active-p 'recharge new-state)
      (incf (getf new-state :mana) 101))
    (dolist (active (getf new-state :active-spells))
      (decf (getf active :remaining)))
    (setf (getf new-state :active-spells)
          (remove-if (lambda (a) (zerop (getf a :remaining)))
                     (getf new-state :active-spells)))
    new-state))

(defun boss-attacks (game-state)
  (let ((new-state (copy-game-state game-state))
        (damage (max 1 (- (getf game-state :boss-damage)
                          (current-armor game-state)))))
    (decf (getf new-state :player-hp) damage)
    new-state))

(defun castable-spells (game-state)
  "Besvärjelser man har råd med OCH som inte redan är aktiva (duration>1)."
  (remove-if (lambda (spell)
               (or (> (getf spell :cost) (getf game-state :mana))
                   (and (> (getf spell :duration) 1)
                        (spell-active-p (getf spell :name) game-state))))
             *spells*))

(defun player-turn (game-state spell-name)
  (let ((state (apply-ongoing-effects game-state)))
    (if (<= (getf state :boss-hp) 0)
        state
        (cast-spell state spell-name))))

(defun boss-turn (game-state)
  (let ((state (apply-ongoing-effects game-state)))
    (if (<= (getf state :boss-hp) 0)
        state
        (boss-attacks state))))
