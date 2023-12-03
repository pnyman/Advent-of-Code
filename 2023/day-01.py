from num2words import num2words
numbers = {num2words(x): x for x in range(1, 10)}


def maybe_number(x):
    if x.isdigit():
        return int(x)
    if x in numbers:
        return numbers[x]
    return False


def first_last_digit(s):
    acc = []

    for i in range(len(s) - 1):
        for j in range(i+1, len(s)):
            acc.append(maybe_number(s[i:j]))

    acc = [x for x in acc if x]
    return(10 * acc[0] + acc[-1])


def solve():
    sum = 0
    for line in open("input/day-01-input.txt", "r"):
        sum += first_last_digit(line)
    return sum


if __name__ == '__main__':
    print(solve())
