import sys

N, M = map(int, sys.stdin.readline().split())
ricecakes = list(map(int, sys.stdin.readline().split()))


def binary_search(arr, target, start, end):
    if start > end:
        return None
    temp = 0
    mid = (start + end) // 2
    print(mid)
    for a in arr:
        if mid < a:
            temp += a - mid
    if temp == target:
        return mid
    elif temp > target:
        return binary_search(arr, target, start, mid - 1)
    else:
        return binary_search(arr, target, mid + 1, end)


answer = binary_search(ricecakes, M, 0, max(ricecakes) - 1)
print(answer)
