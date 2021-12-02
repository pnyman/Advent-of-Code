data = [[com, int(x)] for (com, x) in
        [line.strip().split(' ') for line in open('input/day-02-input.txt')]]

def solve_1(data):
    hor = dep = 0
    for com, x in data:
        if com == 'forward':
            hor += x
        elif com == 'down':
            dep += x
        elif com == 'up':
            dep -= x
    return hor * dep

def solve_2(data):
    hor = dep = aim = 0
    for com, x in data:
        if com == 'forward':
            hor += x
            dep += aim * x
        elif com == 'down':
            aim += x
        elif com == 'up':
            aim -= x
    return hor * dep

print(solve_1(data)) # 1762050
print(solve_2(data)) # 1855892637
