def day_08_1(grid):
    """
    Varje träd ser ut som [1, False]. Om vi ser ett träd, ändra till True.
    """
    for row in grid:
        highest = -1
        for tree in row:
            if tree[0] > highest:
                highest = tree[0]
                tree[1] = True
        highest = -1
        for tree in reversed(row):
            if tree[0] > highest:
                highest = tree[0]
                tree[1] = True


def day_08_2(grid):
    from functools import reduce
    colsize = len(grid) - 1
    rowsize = len(grid[0]) - 1
    scores = []
    for r, row in enumerate(grid):
        for c, tree in enumerate(row):
            score = [0,0,0,0]
            ## north
            for d in range(1, rowsize):
                if r-d < 0: break
                elif grid[r-d][c][0] >= tree[0]:
                    score[0] += 1
                    break
                else: score[0] += 1
            ## south
            for d in range(1, rowsize):
                if r+d > rowsize: break
                elif grid[r+d][c][0] >= tree[0]:
                    score[1] += 1
                    break
                else: score[1] += 1
            ## west
            for d in range(1, colsize):
                if c-d < 0: break
                elif grid[r][c-d][0] >= tree[0]:
                    score[2] += 1
                    break
                else: score[2] += 1
            ## east
            for d in range(1, colsize):
                if c+d > colsize: break
                elif grid[r][c+d][0] >= tree[0]:
                    score[3] += 1
                    break
                else: score[3] += 1
            scores.append(reduce((lambda x, y: x * y), score))
    return max(scores)


grid = []
for line in open("input/day-08-input.txt", "r"):
    grid.append([[int(x), False] for x in list(line.strip())])

day_08_1(grid)
day_08_1(list(map(list, zip(*grid)))) # transponering
print(len([j for sub in grid for j in sub if j[1]])) # bara de som har True

print(day_08_2(grid))
