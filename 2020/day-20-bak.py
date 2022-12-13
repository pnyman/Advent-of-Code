class Tile:
    def __init__(self, tile, key):
        self.tile = tile
        self.key = key
        self.lineup = 0
        self.corner = False

def rotate(tile):
    return list(zip(*tile[::-1]))

def flip(tile):
    return [x[::-1] for x in tile]

tiles = []
for t in open('input/day-20-example.txt').read().split('\n\n'):
    lines = t.strip().split('\n')
    key = int(lines[0].replace('Tile ', '').replace(':', ''))
    tile = [list(x) for x in lines[1:]]

    tiles.append(Tile(tile, key))
    tiles.append(Tile(rotate(tiles[-1].tile), key))
    tiles.append(Tile(rotate(tiles[-1].tile), key))
    tiles.append(Tile(rotate(tiles[-1].tile), key))

    tiles.append(Tile(flip(tile), key))
    tiles.append(Tile(rotate(tiles[-1].tile), key))
    tiles.append(Tile(rotate(tiles[-1].tile), key))
    tiles.append(Tile(rotate(tiles[-1].tile), key))

def lines_up(edge1, edge2):
    return ''.join((edge1)) == ''.join((edge2))

def matching(tile1, tile2):
    return (lines_up(tile1[0], tile2[-1]) or
     lines_up(tile1[-1], tile2[0]) or
     lines_up(rotate(tile1)[0], rotate(tile2)[-1]) or
     lines_up(rotate(tile1)[-1], rotate(tile2)[0]))

def count_lineups():
    for tile1 in tiles:
        for tile2 in tiles:
            if tile1.key == tile2.key: continue
            if matching(tile1.tile, tile2.tile):
                tile1.lineup += 1
                tile2.lineup += 1

count_lineups()

for tile in tiles:
    print(tile.lineup)






# print(rotate([[1,2,3],[4,5,6],[7,8,9]]))
# print(flip([[1,2,3],[4,5,6],[7,8,9]]))


# 1 2 3
# 4 5 6
# 7 8 9

# rotation
# 7 4 1
# 8 5 2
# 9 6 3

# vertikal flik, rad 1 och 3 blir olika
# 3 2 1
# 6 5 4
# 9 8 7

# horisontell flip, kolumn 1 och 3 blir olika
# 7 8 9
# 4 5 6
# 1 2 3
