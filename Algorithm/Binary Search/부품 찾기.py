import sys

N = int(sys.stdin.readline().rstrip())
parts = list(map(int, sys.stdin.readline().rstrip().split()))

M = int(sys.stdin.readline().rstrip())
lookingfor = list(map(int, sys.stdin.readline().rstrip().split()))


# binary search 그대로 쓰기. 외우는게 좋을 듯
def binary_search(arr, target, start, end):
    if start > end:
        return None
    mid = (start + end) // 2

    if arr[mid] == target:
        return mid
    elif arr[mid] > target:
        return binary_search(arr, target, start, mid - 1)
    else:
        return binary_search(arr, target, mid + 1, end)


answer = []
for p in lookingfor:
    if binary_search(parts, p, 0, N - 1) == None:
        print("no", end=" ")
    else:
        print("yes", end=" ")
