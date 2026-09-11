set fh [open ../input/day-01.txt r]

proc solve_1 {fh} {
    seek $fh 0
    set floor 0
    while { ![eof $fh] } {
        set x [read $fh 1]
        if { $x == "(" } {
            incr floor 1
        } elseif { $x == ")" } {
            incr floor -1
        }
    }
    return $floor;
}

proc solve_2 {fh} {
    seek $fh 0
    set floor 0
    set pos 0
    while { ![eof $fh] } {
        set x [read $fh 1]
        incr pos
        if { $x == "(" } {
            incr floor 1
        } elseif { $x == ")" } {
            incr floor -1
        }
        if { $floor == -1 } {
            return $pos
        }
    }
}

puts "Part 1:  [solve_1 $fh]"
puts "Part 2: [solve_2 $fh]"

close $fh
