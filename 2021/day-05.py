SEGMENTS = []
with open('input/day-05-input.txt') as f:
    for line in f:
        SEGMENTS.append([[int(x) for x in y.split(',')]
                         for y in line.strip().split(' -> ')])


def add_point(points, x, y):
    p = ','.join((str(x), str(y)))
    if p in points:
        points[p] += 1
    else:
        points[p] = 1


def part1():
    points = {}

    for a, b in SEGMENTS:
        if a[0] == b[0]:
            p = min(a[1], b[1])
            q = max(a[1], b[1]) + 1
            for i in range(p, q):
                add_point(points, a[0], i)

        elif a[1] == b[1]:
            p = min(a[0], b[0])
            q = max(a[0], b[0]) + 1
            for i in range(p, q):
                add_point(points, i, a[1])

    return sum(x > 1 for x in list(points.values())), points

#---- Part 2 -------------------------------

def is_diagonal(a, b):
    return abs(a[0] - b[0]) == abs(a[1] - b[1])


def get_diagonal_points(a, b):
    x1, y1, x2, y2 = a[0], a[1], b[0], b[1]
    if x1 > x2:
        x1, y1, x2, y2 = x2, y2, x1, y1
    slope = (y2 - y1) // (x2 - x1)
    result = []

    for i, j in zip(range(x1, x2), range(y1, y2, slope)):
        result.append([i, j])
    result.append([x2, y2])  # add end point

    return result


def part2():
    points = part1()[1]
    for a, b in SEGMENTS:
        if is_diagonal(a, b):
            for p in get_diagonal_points(a, b):
                add_point(points, p[0], p[1])
    return sum(x > 1 for x in list(points.values()))


print(part1()[0]) # 4421
print(part2()) # 18674
