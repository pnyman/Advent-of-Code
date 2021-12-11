from itertools import product

input = [[int(x) for x in row] for row in
         [line.strip() for line in open('input/day-09-input.txt')]]

size = [len(input) - 1, len(input[0]) - 1]
def neighbours(cell):
    for c in product(*(range(n-1, n+2) for n in cell)):
        if c != cell and all(0 <= i <= bound for i, bound in zip(c, size)) \
           and (c[0] == cell[0] or c[1] == cell[1]):
            yield c

result = 0
for r, row in enumerate(input):
    for c, col in enumerate(row):
        if all(col < input[i][j] for i, j in neighbours((r, c))):
            result +=  col+1

print(result)

from pathfinding.core.grid import Grid
from pathfinding.finder.a_star import AStarFinder

matrix = []
remaining_points = []
for r, row in enumerate(input):
    tmp = []
    for c, col in enumerate(row):
        if col != 9: remaining_points.append((r,c))
        tmp.append(0 if col == 9 else 1)
    matrix.append(tmp)

basins = []
while remaining_points:
    basin = []
    grid = Grid(matrix=matrix)
    start = (remaining_points[0][0], remaining_points[0][1])
    basin.append(start)
    start = grid.node(start[1], start[0])
    for p in remaining_points[1:]:
        grid = Grid(matrix=matrix)
        end = grid.node(p[1], p[0])
        finder = AStarFinder()
        path, runs = finder.find_path(start, end, grid)
        if len(path) > 0: basin.append(p)
    remaining_points = [x for x in remaining_points if not x in basin]
    basins.append(basin)

basins.sort(key=len, reverse=True)
print(len(basins[0]) * len(basins[1]) * len(basin[2])) # 1235430
# print(len(basins[0]) * len(basins[1])) # 1235430

# började 23:31
# färdig 03:16

# 11766
# 105

# 11766 * 105 = 1235430

# grid = Grid(matrix=matrix)
# start = grid.node(2,1)
# end = grid.node(4,2)
# finder = AStarFinder()
# path, runs = finder.find_path(start, end, grid)

# for m in matrix: print(m)

# print('operations:', runs, 'path length:', len(path))
# print(grid.grid_str(path=path, start=start, end=end))
