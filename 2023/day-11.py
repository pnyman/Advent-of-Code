import os

def get_data():
    input_file = os.path.join(os.path.dirname(__file__), "input/day-11-input.txt")
    data = [[x for x in line.strip()] for line in open(input_file, "r")]
    return data


def get_coords(data):
    coords = []
    for y, row in enumerate(data):
        for x, tile in enumerate(row):
            if tile == '#':
                coords.append([y, x])
    return coords


def find_empty(coords):
    y_empty = []
    x_empty = []

    ycoords = list(set([c[0] for c in coords]))
    xcoords = list(set([c[1] for c in coords]))
    
    for i in range(1, len(ycoords)):
        y_gap = ycoords[i] - ycoords[i-1]
        for j in range(1, y_gap):
            y_empty.append(ycoords[i-1] + j)

    for i in range(1, len(xcoords)):
        x_gap = xcoords[i] - xcoords[i-1]
        for j in range(1, x_gap):
            x_empty.append(xcoords[i-1] + j)

    return y_empty, x_empty


def expand_universe(y_empty, x_empty, coords, amount):
    for y in y_empty[::-1]:
        for c in coords:
            if c[0] > y:
                c[0] += amount
    for x in x_empty[::-1]:
        for c in coords:
            if c[1] > x:
                c[1] += amount


def solve(coords):
    sum = 0
    for i in range(len(coords) - 1):
        for j in range(i + 1, len(coords)):
            sum += abs(coords[i][0] - coords[j][0]) + abs(coords[i][1] - coords[j][1])
    return sum


if __name__ == '__main__':
    import time
    startTime = time.time()

    data = get_data()

    coords = get_coords(data)
    y_empty, x_empty = find_empty(coords)
    expand_universe(y_empty, x_empty, coords, 1)
    print(solve(coords))

    coords = get_coords(data)
    y_empty, x_empty = find_empty(coords)
    expand_universe(y_empty, x_empty, coords, 999999)
    print(solve(coords))

    print('Time: ' + str(time.time() - startTime))

