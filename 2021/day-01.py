nums = [int(line.strip()) for line in open('input/day-01-input.txt')]

def solve(nums, skip):
    return len([i for i in range(len(nums) - skip) if nums[i] < nums[i+skip]])

print(solve(nums, 1))
print(solve(nums, 3))
