import sys

N = int(sys.stdin.readline())
scores = [list(map(str, sys.stdin.readline().rstrip().split())) for _ in range(N)]
scores.sort(key=lambda x: x[1])

for score in scores:
    print(score[0], end=" ")
