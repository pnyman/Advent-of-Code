with open('input/day-04-input.txt') as f:
    NUMBERS = [int(x) for x in f.readline().strip().split(',')]
    BOARDS = []
    while True:
        if f.readline() == '':
            break
        board = []
        for _ in range(5):
            board.append([[int(x), False] for x in f.readline().strip().split()])
        BOARDS.append(board)


def mark_boards(number):
    for board in BOARDS:
        for row in board:
            for square in row:
                if square[0] == number:
                    square[1] = True


def check_boards():
    winners = []
    for board in BOARDS:
        for row in board + list(zip(*board)):
            if sum(square[1] for square in row) == 5:
                winners.append(board)
    return winners


def compute_result(number, board):
    return number * sum([sum(s[0] for s in row if not s[1]) for row in board])


def part1():
    for number in NUMBERS:
        mark_boards(number)
        winners = check_boards()
        if winners:
            return compute_result(number, winners[0])


def remove_board(board):
    for i in range(len(BOARDS)):
        if board == BOARDS[i]:
            BOARDS.pop(i)
            break


def part2():
    last_winner = []
    for number in NUMBERS:
        mark_boards(number)
        for winner in check_boards():
            remove_board(winner)
            last_winner = [number, winner]
    return compute_result(last_winner[0], last_winner[1])


print(part1()) # 87456
print(part2()) # 15561
