import math 
import os

def get_data():
    input_file = os.path.join(os.path.dirname(__file__), "input/day-02-input.txt")
    games = {}

    for line in open(input_file, "r"):
        game = line.strip().split(':')
        game_number = int(game[0].split()[1])
        games[game_number] = []

        for reveal in game[1].split(';'):
            temp = {'red': 0, 'green': 0, 'blue': 0}
            for cubes in reveal.split(','):
                number, colour = cubes.split()
                temp[colour] = int(number)
            games[game_number].append(temp)

    return games


def solve_01():
    games = get_data()
    bag = {'red': 12, 'green': 13, 'blue': 14}
    result = 0

    for game_number in games:
        include = True
        for reveal in games[game_number]:
            for colour in bag:
                if reveal[colour] > bag[colour]:
                    include = False
        if include:
            result += game_number

    return result


def solve_02():
    games = get_data()
    result = 0

    for game_number in games:
        bag = {'red': 0, 'green': 0, 'blue': 0}
        for reveal in games[game_number]:
            for colour in bag:
                bag[colour] = max([reveal[colour], bag[colour]])
        result += math.prod(bag.values())

    return result


if __name__ == '__main__':
    print(solve_01())
    print(solve_02())
