import math
import os

def get_data():
    input_file = os.path.join(os.path.dirname(__file__), "input/day-08-input.txt")
    data = [line.strip() for line in open(input_file, "r")]
    
    instructions = [int(x) for x in data[0].replace('L', '0').replace('R', '1')]

    nodes = {}
    for line in data[2:]:
        kv = line.split('=')
        k = kv[0].strip()
        v = [x.strip() for x in kv[1].replace('(', '').replace(')', '').split(',')]
        nodes[k] = v

    return instructions, nodes


def solve_1(instructions, nodes):
    steps = 0
    node = 'AAA'
    while True:
        for lr in instructions:
            steps += 1
            node = nodes[node][lr]
            if node == 'ZZZ':
                return steps
        

def count_steps(instructions, nodes, node):
    steps = 0
    while True:
        for lr in instructions:
            steps += 1
            node = nodes[node][lr]
            if node.endswith('Z'):
                return steps


def solve_2(instructions, nodes):
    acc = []
    for node in [node for node in nodes.keys() if node.endswith('A')]:
        acc.append(count_steps(instructions, nodes, node))
    return math.lcm(*acc)


if __name__ == '__main__':
    import time
    startTime = time.time()

    instructions, nodes, = get_data()
    print(solve_1(instructions, nodes))
    print(solve_2(instructions, nodes))

    print('Time: ' + str(time.time() - startTime))
