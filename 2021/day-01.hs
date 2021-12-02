module Main where

solve :: [String] -> [String]
solve list = list

convert :: Read a => String -> [a]
convert = map read . words

main = do
    contents <- readFile "input/day-01-example.txt"
    let list = lines contents
    let intervals = map convert list :: [Int]
    intervals
