input = [line.strip() for line in open('input/day-10-input.txt')]
brackets = {'(': ')', '[': ']','{': '}', '<': '>'}

#==== Part 1 ===================

def part1(line):
    stack = []
    for x in list(line):
        if x in brackets:
            stack.append(x)
        else:
            if x != brackets[stack.pop()]:
                return x

score = 0
points = {')': 3, ']': 57, '}': 1197, '>': 25137}

for line in input:
    illegal = part1(line)
    if illegal:
        score += points[illegal]

print(score) # 166191

#==== Part 2 ===================

def part2(line):
    stack = []
    for x in list(line):
        if x in brackets:
            stack.append(x)
        else:
            if x != brackets[stack.pop()]:
                return False
    return stack

scores = []
points = {'(': 1, '[': 2, '{': 3, '<': 4}

for line in input:
    score = 0
    incomplete = part2(line)
    if incomplete:
        for i in incomplete[::-1]:
            score *= 5
            score += points[i]
        scores.append(score)

print(sorted(scores)[(len(scores)-1)//2]) # 1152088313
