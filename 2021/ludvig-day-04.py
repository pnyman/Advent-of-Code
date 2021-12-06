def make_boards(data):
    numbers = list(map(int, data[0].split(',')))
    boards, board = [], []
    n = len(data[2].split())

    for i in range(2, len(data)):
        if data[i] == '':
            boards.append(board)
            board = []
        else:
            row = list(map(int, data[i].split()))
            board.append(row)

    return numbers, boards, n


def result(i, board, wins):
    return i * (sum([sum(num for num in row) for row in board]) - wins)


def bingo(numbers, boards, n):
    # rows, cols = [[0]*n for i in boards], [[0]*n for i in boards]
    rows = [[0]*n for i in boards]
    cols = rows.copy()
    # wins, banned_boards = [0 for i in boards], [0 for i in boards]
    wins = [0 for i in boards]
    banned_boards = wins.copy()
    n_boards = len(boards)

    for i in numbers:
        for j in range(len(boards)):
            for k in range(n):
                for h in range(n):
                    if boards[j][k][h] == i:
                        rows[j][k] += 1
                        cols[j][h] += 1
                        wins[j] += i

                        if rows[j][k] == n or cols[j][h] == n:
                            n_boards -= banned_boards[j] == 0
                            banned_boards[j] += banned_boards[j] == 0
                            if n_boards == 0:
                                return result(i, boards[j], wins[j])


data = [line.strip() for line in open('input/day-04-input.txt')]
print(bingo(*make_boards(data)))
