set fp [open ../input/day-02.txt r]
set sum1 0
set sum2 0
while {[gets $fp line] >= 0} {
    scan $line "%dx%dx%d" l w h
    set a [expr {$l * $w}]
    set b [expr {$w * $h}]
    set c [expr {$h * $l}]
    incr sum1 [expr {2 * ($a + $b + $c) + min($a, $b, $c)}]
    set m [expr {$l + $w + $h - max($l, $w, $h)}]
    incr sum2 [expr {2 * $m + $l * $h * $w}]
}
close $fp
puts "Part 1: $sum1"
puts "Part 2: $sum2"
