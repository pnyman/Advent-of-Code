import os
import numpy as np
input_file = os.path.join(os.path.dirname(__file__), "input/day-02-input.txt")
data = [x.strip() for x in open(input_file,"r")]


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
    balls = [0, 0, 0]
    maximum = [12, 13, 14]
    c = ['r','g','b']
    i = 0

    while i < len(x)-2:
        if x[i].isdigit():
            number, i = findNum(x, i)
            for j, colour in enumerate(c):
                # print(j)
                if x[i] == colour:
                    if balls[j] < number:
                        balls[j] = number  
                    break
            
        else:
            i += 1
        
        valid = 0
        print(i, balls)
        for j, b in enumerate(balls):
            if b <= maximum[j]:
                valid += 1
        # if valid == 3:
        #     break
            # return np.prod(balls)
        # else:
        #     return np.prod(balls)

    # return np.prod(balls)

valid_games = 0
ftotal = 0
for i, line in enumerate(data):
    findTotals(line)
    # print(a)
    # print(b)
    # valid_games += a
    # ftotal += b

print(valid_games)
print(ftotal)
