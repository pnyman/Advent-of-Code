input = [[x.split(), y.split()] for (x, y) in
         [line.strip().split('|')
          for line in open('input/day-08-example.txt')]]

# print(input)

numbers = { 0: 6, 1: 2, 3: 5, 4: 4, 5: 5, 6: 6, 7: 3, 8: 7, 9: 6 }
segments = { 2: 1, 3: 7, 4: 4, 5: [2, 3, 5], 6: [0, 6, 9], 7: 8 }

digits_map = {
    'abcefg': '0',
    'cf': '1',
    'acdeg': '2',
    'acdfg': '3',
    'bcdf': '4',
    'abdfg': '5',
    'abdefg': '6',
    'acf': '7',
    'abcdefg': '8',
    'abcdfg': '9'
}

# cfbegad

def make_translation_key(lst):
    lst.sort(key=len)

    ## segmentet för a finns i 7 men inte 1
    a = list(set(lst[1]).difference(lst[0]))[0]
    ## segmenten för b och d finns i 4 men inte i 1
    bd = list(set(lst[2]).difference(lst[0]))
    ## segmenten för c och f finns i 1
    cf = list(lst[0])
    ## segmenten för e och g finns bara i 8
    eg = list(set(lst[3]).difference(lst[1]).difference(lst[2]).difference(lst[0]))



    key = {a[0]: 'a', a[1]: 'b', a[2]: 'c',
           a[3]: 'd', a[4]: 'e', a[5]: 'f', a[6]: 'g'}
    return key

def translate(key, digits):
    print(key)
    result = ''
    for digit in digits:
        temp = ''
        print(digit)
        for char in digit:
            temp += key[char]
            print(temp)
        result += digits_map[temp]
    return int(result)

lengths = [0]*10
for x in input:
    for y in x[1]:
        lengths[len(y)] += 1

result = lengths[2] + lengths[3] + lengths[4] + lengths[7]
print(result)


values = []
for x in input:
    onefourseveneight = []
    for y in x[0]:
        if 2 <= len(y) <= 4 or len(y) == 7:
            onefourseveneight.append(y)
        key = make_translation_key(onefourseveneight)
    values.append(translate(key, x[0]))

print(sum(values))
