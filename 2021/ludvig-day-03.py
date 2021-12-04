data = [line.strip() for line in open('input/day-03-input.txt')]

def sort(data, x):
    listx0, listx1 = [], []
    [(listx0, listx1)[d[x] == '1'].append(d) for d in data]
    return [listx0, listx1] if len(listx0) > len(listx1) else [listx1, listx0]

def reduce_solver(data, n, x=0):
    if len(data) == 1:
        return int(data[0], 2)
    return reduce_solver(sort(data, x)[n], n, x + 1)

print(reduce_solver(data, 1) * reduce_solver(data, 0)) # 6822109


# def reduce_solver(data, n, x=0):
#     while len(data) > 1:
#         data = sort(data, x)[n]
#         x += 1
#     return int(data[0], 2)
