data = [line.strip() for line in open('input/day-05-example.txt')]

def sort_coordinates(data):

    pairs = []
    x1coords = []
    x2coords = []
    y1coords = []
    y2coords = []

    for i in range(len(data)):
        pairs.append(data[i].split(' -> '))
    for i in range(len(pairs)):
        temp1 = pairs[i][0].split(',')
        temp2 = pairs[i][1].split(',')
        x1coords.append(int(temp1[0]))
        x2coords.append(int(temp2[0]))
        y1coords.append(int(temp1[1]))
        y2coords.append(int(temp2[1]))

    return x1coords, x2coords, y1coords, y2coords


def count_double(x1,x2,y1,y2):
    mega_list = [ [0]*10 for i in range(10) ]

    for i in range(len(x1)):
        if x1[i] == x2[i]:
            if y1[i]>y2[i]:
                for j in range(y1[i]-y2[i]+1):
                    mega_list[x1[i]][y2[i]+j] += 1
            if y2[i]>y1[i]:
                for j in range(y2[i]-y1[i]+1):
                    mega_list[x1[i]][y1[i]+j] += 1

        if y1[i] == y2[i]:
            if x1[i]>x2[i]:
                for j in range(x1[i]-x2[i]+1):
                    mega_list[x2[i]+j][y1[i]] += 1
            if x2[i]>x1[i]:
                for j in range(x2[i]-x1[i]+1):
                    mega_list[x1[i]+j][y1[i]] += 1

    # print(mega_list)
    megasum = 0
    for k in range(len(mega_list)):
        for h in range(len(mega_list)):
            if mega_list[k][h] > 1:
                megasum += 1
    return megasum

print(count_double(*sort_coordinates(data)))
