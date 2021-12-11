from itertools import product

data = [[int(x) for x in row] for row in
        [line.strip() for line in open('input/day-11-input.txt')]]

size = [len(data) - 1, len(data[0]) - 1]
def neighbours(cell):
    for c in product(*(range(n-1, n+2) for n in cell)):
        if c != cell and all(0 <= i <= bound for i, bound in zip(c, size)):
            yield c

def solve(data):
    flashing = True
    flashed = []
    data = [[x+1 for x in row] for row in data]
    while flashing:
        flashing = False
        for r, row in enumerate(data):
            for c, col in enumerate(row):
                if col > 9 and (r,c) not in flashed:
                    flashing = True
                    flashed.append((r,c))
                    for i,j in neighbours((r,c)):
                        data[i][j] += 1
    for r,c in flashed:
        data[r][c] = 0
    return data, flashed

def part1(data):
    flashes = 0
    for step in range(100):
        data, flashed = solve(data)
        flashes += len(flashed)
    return flashes

def part2(data):
    step = 0
    while True:
        step += 1
        data, flashed = solve(data)
        if len(flashed) == 100:
            return step

print(part1(data)) # 1588
print(part2(data)) # 517
