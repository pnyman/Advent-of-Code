import os

def get_data():
    input_file = os.path.join(os.path.dirname(__file__), "input/day-06-input.txt")
    data = [line.split(':')[1].strip() for line in open(input_file, "r")]
    return [x.split() for x in data]


def solve_01(times, dists):
    times = [int(x) for x in times]
    dists = [int(x) for x in dists]
    ways = 1

    for i, time in enumerate(times):
        wins = 0
        for hold in range(time):
            wins += hold * (time - hold) > dists[i]
        ways *= wins

    return ways


def solve_02(times, dists):
    time = int(''.join([str(x) for x in times]))
    dist = int(''.join([str(x) for x in dists]))
    wins = 0

    for hold in range(time):
        wins += hold * (time - hold) > dist

    return wins
            

if __name__ == '__main__':
    import time
    startTime = time.time()

    times, dists = get_data()
    print(solve_01(times, dists))
    print(solve_02(times, dists))

    print('Time: ' + str(time.time() - startTime))
