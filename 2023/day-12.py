import re
import os

def get_data():
    input_file = os.path.join(os.path.dirname(__file__), "input/day-12-input-test.txt")
    return [parseLine(l) for l in open(input_file, "r")]


def parseLine(line):
    lhs, rhs = re.sub(r"\.+", "." , line).split()
    nums = eval(rhs)
    return (lhs, nums)

    
def solve(line, sizes, part2 = False):
    if part2 == True:
        line = "?".join([line]*5)
        sizes *= 5

    memo = {}

    def f(line_idx, sizes_idx, blocksize): # return how many solutions there are from this position
        if (line_idx, sizes_idx, blocksize) in memo:
            return memo[(line_idx, sizes_idx, blocksize)] # already solved it
        
        if line_idx == len(line): # at the end of the line, return 1 if this is a posible configuration or 0 otherwise
            return int(
                (sizes_idx == len(sizes) and blocksize == 0) or # no current block, and finished all numbers
                (sizes_idx == len(sizes) - 1 and blocksize == sizes[-1]) # one last block, and currently in a block of that size
            )

        ans = 0

        if line[line_idx] in ".?": # treat it like a .
            if blocksize == 0:
                ans += f(line_idx + 1, sizes_idx, 0) # just keep moving forward
            else: # we have a current block
                if sizes_idx == len(sizes):
                    return 0 # more springs than input asks for, so not a solution
                if blocksize == sizes[sizes_idx]: # If we currently have a continguous spring of the required size
                    ans += f(line_idx + 1, sizes_idx + 1, 0) # Move forward and count this block

        if line[line_idx] in "#?": # treat it like a #
            ans += f(line_idx + 1, sizes_idx, blocksize + 1) # no choice but to continue current block

        memo[(line_idx, sizes_idx, blocksize)] = ans # save to memo
        return ans

    return f(0, 0, 0)


def main(data):
    return sum(solve(*l) for l in data), sum(solve(*l, part2 = True) for l in data)


if __name__ == '__main__':
    import time
    startTime = time.time()
    print(main(get_data()))
    print('Time: ' + str(time.time() - startTime))
