import os

class Number:
    def __init__(self, digits, coords, symbols, row_length):
        self.value = int(''.join(digits))
        self.coords = coords
        self.symbols = symbols
        self.row_length = row_length
        self.adjacent_symbols = self.check_adjacent_symbols()
        self.is_part_number = len(self.adjacent_symbols) > 0

    def __str__(self):
        return f'{self.value} {self.coords} {self.is_part_number}'

    def check_adjacent_symbols(self):
        temp = []
        for n in self.coords:
            for p in (n + 1, n - 1, 
                      n + self.row_length, n + self.row_length + 1, n + self.row_length - 1, 
                      n - self.row_length, n - self.row_length + 1, n - self.row_length - 1):
                if p in self.symbols:
                    temp.append(p)
        return set(temp)


def get_data():
    input_file = os.path.join(os.path.dirname(__file__), "input/day-03-input.txt")
    data = [line.strip() for line in open(input_file, "r")]
    row_length = len(data[0])
    data_string = ''.join(data)

    symbols = []
    for i, char in enumerate(data_string):
        if not (char.isdigit() or char == '.'):
            symbols.append(i)

    numbers, digits, coords = [], [], []
    for i, char in enumerate(data_string):
        if char.isdigit():
            digits.append(char)
            coords.append(i)
        elif digits:
            numbers.append(Number(digits, coords, symbols, row_length))
            digits, coords = [], []

    return numbers, symbols


def solve_1(numbers):
    return sum([n.value for n in numbers if n.is_part_number])


def solve_2(numbers, symbols):
    sum = 0

    for s in symbols:
        found = []
        for n in numbers:
            if s in n.adjacent_symbols:
                found.append(n.value)
            if len(found) == 2:
                sum += found[0] * found[1]
                found = []
                break

    return sum
                

if __name__ == '__main__':
    numbers, symbols = get_data()
    print(solve_1(numbers))
    print(solve_2(numbers, symbols))
