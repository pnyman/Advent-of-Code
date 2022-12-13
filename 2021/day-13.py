data = []
folds = []
a = data
with open('input/day-13-input.txt') as f:
    for line in f.readlines():
        line = line.strip()
        if line == '':
            a = folds
            continue
        a.append(line.split(','))

data = [(int(x[1]), int(x[0])) for x in data]
folds = [x[0] for x in folds]

rmax, cmax = (max(data, key=lambda c: c[0])[0], max(data, key=lambda c: c[1])[1])
paper = ['0'*(cmax+1) for _ in range(rmax+1)]

for r, c in data:
    paper[r] = '1'.join((paper[r][:c], paper[r][c+1:]))

#==== Part 1 =============================================

def foldx(line, fold):
    width = len(line) - fold
    return '{0:b}'.format(int(line[:fold], 2) | int(line[fold:][::-1], 2)).zfill(width)

fold = int(folds[0].split('=')[1])
folded = []
for line in paper:
    folded.append(foldx(line, fold))

result = sum(f.count('1') for f in folded)
print(result) # 827

#==== Part 2 =============================================

for fold in folds:
    folded = []
    f = int(fold.split('=')[1])

    if 'x' in fold:
        for line in paper:
            fld = foldx(line, f)
            folded.append(fld)
    else:
        for z in zip(paper[:f], paper[f:][::-1]):
            folded.append('{0:b}'.format(int(z[0], 2) | int(z[1], 2))
                          .zfill(len(paper[0])))

    paper = [line for line in folded]

paper = [line.replace('1', '#').replace('0', '.') for line in paper]

for line in paper:
    print(line)


print(foldx('0000011100', 5))
