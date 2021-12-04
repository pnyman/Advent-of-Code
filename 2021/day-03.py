# Make a set of the list so that the duplicate elements are deleted.
# Then find the highest count of occurrences of each element in the set and thus,
# we find the maximum out of it.
def most_frequent(List):
    return max(set(List), key = List.count)

def least_frequent(List):
    return min(set(List), key = List.count)

def get_data():
    return [[int(x) for x in list(line.strip())]
            for line in open('input/day-03-example.txt')]

data = get_data()
gamma = ''
epsilon = ''
for row in zip(*data):
    s = sum(row)
    if s > len(row)/2:
        gamma += '1'
        epsilon += '0'
    else:
        gamma += '0'
        epsilon += '1'

print(int(gamma, 2) * int(epsilon, 2))

#--- Del 2 ------------------

def solve(kind='ox'):
    if kind == 'ox':
        foo = 1
        bar = 0
    else:
        foo = 0
        bar = 1

    data = get_data()
    i = 0
    while True:
        cols = list(zip(*data))
        if len(cols[0]) == 1:
            break
        col = cols[i]
        if sum(col) >= len(col)/2:
            data = [row for row in data if row[i] == foo ]
        else:
            data = [row for row in data if row[i] == bar]
        i += 1

    return int(''.join([str(x) for x in data[0]]), 2)

print(solve('ox') * solve('co2'))
