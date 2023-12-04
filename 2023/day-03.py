import os

def make_number(digits, coords, symbols, row_length):
    d = {}
    d['value'] = int(''.join(digits))
    d['adjacent_symbols'] = check_adjacent_symbols(coords, symbols, row_length)
    d['is_part_number'] = len(d['adjacent_symbols']) > 0
    return d


def check_adjacent_symbols(coords, symbols, row_length):
    temp = {}
    for n in coords:
        for p in (n + 1, n - 1, 
                  n + row_length, n + row_length + 1, n + row_length - 1, 
                  n - row_length, n - row_length + 1, n - row_length - 1):
            if p in symbols:
                temp[p] = True
    return temp


def get_data():
    input_file = os.path.join(os.path.dirname(__file__), "input/day-03-input-big.txt")
    data = [line.strip() for line in open(input_file, "r")]
    row_length = len(data[0])
    data_string = ''.join(data)

    symbols = {}
    for i, char in enumerate(data_string):
        if not (char.isdigit() or char == '.'):
            symbols[i] = True

    numbers, digits, coords = [], [], []
    for i, char in enumerate(data_string):
        if char.isdigit():
            digits.append(char)
            coords.append(i)
        elif digits:
            numbers.append(make_number(digits, coords, symbols, row_length))
            digits, coords = [], []

    return numbers, symbols


def solve_1(numbers):
    return sum([n['value'] for n in numbers if n['is_part_number']])


def solve_2(numbers, symbols):
    sum = 0

    for s in symbols:
        found = []
        t = 0
        for n in numbers:
            if s in n['adjacent_symbols']:
                found.append(n['value'])
                t += 1
            if t == 2:
                sum += found[0] * found[1]
                found.clear()
                t = 0
                break

    return sum
                

if __name__ == '__main__':

    import time
    startTime = time.time()
    numbers, symbols = get_data()
    print('Time 1: ' + str(time.time() - startTime))

    startTime = time.time()
    print(solve_1(numbers))
    print('Time 2: ' + str(time.time() - startTime))

    startTime = time.time()
    print(solve_2(numbers, symbols))
    print('Time 3: ' + str(time.time() - startTime))

