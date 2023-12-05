import os

def solve_01():
    input_file = os.path.join(os.path.dirname(__file__), "input/day-05-input.txt")
    data = [line.strip() for line in open(input_file, "r")]
    seeds = [int(x) for x in data[0].split(':')[1].strip().split(' ')]

    maps = []
    for i, line in enumerate(data[2:]):
        if line == '' or i == len(data) - 3: # if empty line or end
            for j, seed in enumerate(seeds):
                seeds[j] = update_seed(seed, maps)
            maps.clear()
            continue
        elif not line[0].isdigit():
            continue
        maps.append([int(x) for x in line.split(' ')])

    print(min(seeds))


def update_seed(seed, maps):
    for m in maps:
        if m[1] <= seed <= m[1] + m[2] - 1:
            return m[0] - m[1] + seed
    return seed
            

import time
startTime = time.time()
solve_01()
print('Time: ' + str(time.time() - startTime))
