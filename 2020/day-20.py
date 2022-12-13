class Tile:
    def __init__(self, key, tile):
        self.key = key
        self.tile = tile
        self.aligned = []

def make_tiles():
    tiles = []
    for t in open('input/day-20-example.txt').read().split('\n\n'):
        lines = t.strip().split('\n')
        key = int(lines[0].replace('Tile ', '').replace(':', ''))
        tile = [list(x) for x in lines[1:]]
        codes = []
        for x in [tile[0], tile[-1],
                  [row[0] for row in tile],
                  [row[-1] for row in tile]]:
            for n in make_numbers(x):
                codes.append(n)
        tiles.append(Tile(key, codes))
    return tiles

def make_numbers(edge):
    binary = ''
    for x in edge:
        binary += '0' if x == '.' else '1'
    return int(binary, 2), int(binary[::-1], 2)

def have_common_elements(a, b):
    return not set(a).isdisjoint(b)

for t in make_tiles():
    print(f'{t.key}: {t.tile}')


# tiles är 10x10

# 1951: [710, 564, 841, 498] 2311: [210, 231, 498, 89]  3079: [702, 184, 616, 264]
# 2729: [85, 710, 271, 576]  1427: [948, 210, 576, 234] 2473: [542, 234, 966, 116]
# 2971: [161, 85, 456, 565]  1489: [848, 948, 565, 18]  1171: [966, 24, 902, 288]
