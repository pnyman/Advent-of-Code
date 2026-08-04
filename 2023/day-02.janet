(use judge)

(def test-input (string/trimr (slurp "input/day-02-input-test.txt")))
(def real-input (string/trimr (slurp "input/day-02-input.txt")))

(def peg
  ~{
    :main (split "\n" :game)
    :game (/ (* "Game " (number :d+) ": " :rounds) ,|{:id $0 :rounds $&})
    :rounds (split "; " (/ :round ,|(struct ;(reverse $&))))
    :round (split ", " :reading)
    :reading (* (number :d+) " " :color)
    :color (/ ':w+ ,keyword)
    })

(test (peg/match peg test-input)
  @[{:id 1
     :rounds [{:blue 3 :red 4}
              {:blue 6 :green 2 :red 1}
              {:green 2}]}
    {:id 2
     :rounds [{:blue 1 :green 2}
              {:blue 4 :green 3 :red 1}
              {:blue 1 :green 1}]}
    {:id 3
     :rounds [{:blue 6 :green 8 :red 20}
              {:blue 5 :green 13 :red 4}
              {:green 5 :red 1}]}
    {:id 4
     :rounds [{:blue 6 :green 1 :red 3}
              {:green 3 :red 6}
              {:blue 15 :green 3 :red 14}]}
    {:id 5
     :rounds [{:blue 1 :green 3 :red 6}
              {:blue 2 :green 2 :red 1}]}])
