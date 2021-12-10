input = [[line.split(), y.split()] for (line, y) in
         [line.strip().split('|')
          for line in open('input/day-08-input.txt')]]

lengths = [0]*10
for line in input:
    for y in line[1]:
        lengths[len(y)] += 1

result = lengths[2] + lengths[3] + lengths[4] + lengths[7]
print(result)

#==== Part 2 ===============

def make_translation_key(pattern):
    tmp = {}
    for p in pattern:
        le = len(p)
        if le == 2: tmp[1] = p
        elif le == 4: tmp[4] = p
        elif le == 3: tmp[7] = p
        elif le == 7: tmp[8] = p

    for p in pattern:
        if len(p) != 6: continue
        if set(tmp[4]).issubset(set(p)): tmp[9] = p
        elif set(tmp[1]).issubset(set(p)): tmp[0] = p
        else: tmp[6] = p

    e = list(set(tmp[8]).difference(tmp[9]))
    for p in pattern:
        if len(p) != 5: continue
        if set(tmp[1]).issubset(set(p)): tmp[3] = p
        elif set(e).issubset(set(p)): tmp[2] = p
        else: tmp[5] = p

    key = {}
    for k, v in tmp.items():
        key[''.join((sorted(list(v))))] = k

    return key

def translate(key, value):
    result = ''
    for v in value:
        result += str(key[''.join((sorted(list(v))))])
    return int(result)

values = []
for pattern, value in input:
    key = make_translation_key(pattern)
    values.append(translate(key, value))
print(sum(values))
