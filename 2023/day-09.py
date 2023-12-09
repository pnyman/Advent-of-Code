import math
import os

def get_data():
    input_file = os.path.join(os.path.dirname(__file__), "input/day-09-input.txt")
    data = [[int(i.strip()) for i in line.split()] for line in open(input_file, "r")]
    return data


def get_next_value_01(history, part):
    sequences = [history]

    while not all(n == 0 for n in sequences[-1]):
        temp = []
        for i in range(1, len(sequences[-1])):
            temp.append(sequences[-1][i] - sequences[-1][i-1])
        sequences.append(temp)

    if part == 1:
        for i in reversed(range(len(sequences) - 1)):
            sequences[i].append(sequences[i][-1] + sequences[i+1][-1])
        return sequences[0][-1]

    elif part == 2:
        for i in reversed(range(len(sequences) - 1)):
            sequences[i].insert(0, sequences[i][0] - sequences[i+1][0])
        return sequences[0][0]


def solve():
    values_01 = []
    for history in get_data():
        values_01.append(get_next_value_01(history, 1))

    values_02 = []
    for history in get_data():
        values_02.append(get_next_value_01(history, 2))

    return sum(values_01), sum(values_02)


if __name__ == '__main__':
    import time
    startTime = time.time()
    print(solve())
    print('Time: ' + str(time.time() - startTime))
