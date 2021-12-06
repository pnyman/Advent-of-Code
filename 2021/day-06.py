data = [int(x) for x in
        [line.strip().split(',') for line in open('input/day-06-input.txt')][0]]

fish = [0]*10
for d in data:
    fish[d] += 1

def simulator(fish):
    for _ in range(256):
        for age, val in enumerate(fish):
            if age == 0:
                fish[9] += val
                fish[7] += val
                fish[0] = 0
            else:
                fish[age-1] += val
                fish[age] = 0
    return sum(fish)

print(simulator(fish))

#=== Ludvigs lösning, mycket bättre!

fish = [0]*9
for d in data:
    fish[d] += 1

def fishincrease(info):
    for k in range(256):
        info[7] += info[0]
        info.append(info[0])
        info = info[1:]
    return sum(info)

print(fishincrease(fish))
