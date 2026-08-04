(use judge)

(def test-input (string/trimr (slurp "input/day-01-input-test.txt")))
(def real-input (string/trimr (slurp "input/day-01-input.txt")))

## part one #################################################

(def test-input-part-1
  ```
1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet
```)

(def peg
  ~{:main (split "\n" (group :line))
    :line (some (+ (number :d) 1))})

(test (peg/match peg test-input-part-1)
  @[@[1 2] @[3 8] @[1 2 3 4 5] @[7]])

(defn solve [input]
  (sum (seq [line :in (peg/match peg input)
             :when (not (empty? line))]
         (+ (* 10 (first line)) (last line)))))

(test (solve test-input-part-1) 142)
(test (solve real-input) 53334)

## part two #################################################

(def peg
  ~{:main (split "\n" (group :line))
    :line (some (+ :number 1))
    :number (+ (number :d)
               (if (+ (/ "one" 1) (/ "two" 2) (/ "three" 3)
                      (/ "four" 4) (/ "five" 5) (/ "six" 6)
                      (/ "seven" 7) (/ "eight" 8) (/ "nine" 9)
                      (/ "zero" 0))
                 1))})

(test (peg/match peg "oneight") @[@[1 8]])

(defn solve [input]
  (sum (seq [line :in (peg/match peg input)
             :when (not (empty? line))]
         (+ (* 10 (first line)) (last line)))))

(test (solve test-input) 281)
(test (solve real-input) 52834)


# (print (length test-input))
# (print test-input)
# (print (peg/match peg test-input))
# (pp (string/split "\n" test-input))
