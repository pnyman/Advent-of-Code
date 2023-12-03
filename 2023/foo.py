data = [line.strip() for line in open(r"input/day-02-input-test.txt")]

def findNum(round, i):
    num = []
    biggo = 0

    while round[i].isdigit():
            num.append(round[i])
            i+=1
    for e, d in enumerate(num[::-1]):
        biggo += int(d)*10**e

    return biggo, i+1

def findTotals(x):
    print(x)
    totals = [0, 0, 0]
    c = ['r','g','b']
    i = 0

    while True:
        if i < len(x)-2:
            if x[i].isdigit():
                number, colourindex = findNum(x, i)
                i = colourindex
                for j, colour in enumerate(c):
                    if x[i] == colour:
                        totals[j] += number
                        break
            else:
                i += 1

        else:
            print(totals)
            return totals

games = 0
for i, line in enumerate(data):
    cubes = findTotals(line) 
    total = 0
    for j, num in enumerate([12,13,14]):
        if cubes[j] <= num:
            total += 1
    if total == 3:
        games += i+1

print(games)

