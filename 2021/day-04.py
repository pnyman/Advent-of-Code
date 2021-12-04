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
        for row in board:
            marked = 0
            for square in row:
                if square[1]:
                    marked += 1
            if marked == 5:
                winners.append(board)
        for col in zip(*board):
            marked = 0
            for square in col:
                if square[1]:
                    marked += 1
            if marked == 5:
                winners.append(board)
    return winners


def compute_result(number, board):
    score = 0
    for row in board:
        for square in row:
            if not square[1]:
                score += square[0]
    return number * score


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
        winners = check_boards()
        if winners:
            for winner in winners:
                remove_board(winner)
            last_winner = [number, winners[-1]]
    return compute_result(last_winner[0], last_winner[1])


print(part1()) # 87456
print(part2()) # 15561
