data = [int(x) for x in
        [line.strip().split(',') for line in
         open('input/day-07-input.txt')][0]]

#==== Part 1 ============
cost = min([sum(abs(x-y) for y in data) for x in range(max(data)+1)])
print(cost) # 352254

#==== Part 2 ============
def triangle(nr):
    return int(nr * (nr + 1) / 2)

cost = min([sum(triangle(abs(x-y)) for y in data) for x in range(max(data)+1)])
print(cost) # 99053143


def crabfuel(poslist):
    def totsum(): return sum((n**2 + abs(n)) // 2 for n in poslist)
    current, last = 0, 1
    while current < last:
        last = totsum()
        poslist = [x-1 for x in poslist]
        current = totsum()
    return last

# print(crabfuel(data))

def crabfuel2(poslist, step=0):
    ll = len(poslist)
    cost = sum((n**2 + abs(n))//2 for n in poslist)
    normsum = sum(n for n in poslist)
    last = cost
    while cost <= last:
        last = cost
        cost -= normsum - step*ll - len([i for i in poslist if i <= step])
        step += 1
    return last

print(crabfuel2(data))
