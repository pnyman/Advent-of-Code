import os

def get_input():
    input_file = os.path.join(os.path.dirname(__file__), 'input/day-05-input.txt')
    seeds, *blocks = open(input_file).read().split('\n\n')
    seeds = list(map(int, seeds.split(':')[1].split()))
    maps = [[list(map(int, line.split()))
             for line in block.splitlines()[1:]]
            for block in blocks]
    return seeds, maps


def solve_1():
    seeds, maps = get_input()
    for map in maps:
        for i, seed in enumerate(seeds):
            for a, b, c in map:
                if b <= seed < b + c:
                   seeds[i] = seed - b + a
    return min(seeds)


def solve_2():
    seeds, maps = get_input()
    seeds = [
        (seeds[i], seeds[i] + seeds[i + 1])
        for i in range(0, len(seeds), 2)
    ]
    for map in maps:
        for i, seed in enumerate(seeds):
            start, end = seed
            for a, b, c in map:
                overlap_start = max(start, b)
                overlap_end = min(end, b + c)
                if overlap_start < overlap_end:
                    seeds[i] = (overlap_start - b + a, overlap_end - b + a)
                    if overlap_start > start:
                        seeds.append((start, b))
                    if overlap_end < end:
                        seeds.append((b + c, end))
                    break
    return min(seeds)[0]


if __name__ == '__main__':
    import time
    startTime = time.time()
    print(solve_1())
    print(solve_2())
    print('Time: ' + str(time.time() - startTime))
