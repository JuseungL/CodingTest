import sys

loc = sys.stdin.readline()

x = int(ord(loc[0]) - ord("a") + 1)
y = int(loc[1])
"""
    가능한 케이스
    (2,1)
    (2,-1)
    (-2,1)
    (-2,-1)
    (1.2)
    (1,-2)
    (-1,2)
    (-1,-2)
"""

answer = 0
if 0 < x + 2 < 9 and 0 < y + 1 < 9:
    answer += 1
if 0 < x + 2 < 9 and 0 < y - 1 < 9:
    answer += 1
if 0 < x - 2 < 9 and 0 < y + 1 < 9:
    answer += 1
if 0 < x - 2 < 9 and 0 < y - 1 < 9:
    answer += 1
if 0 < x + 1 < 9 and 0 < y + 2 < 9:
    answer += 1
if 0 < x + 1 < 9 and 0 < y - 2 < 9:
    answer += 1
if 0 < x - 1 < 9 and 0 < y + 2 < 9:
    answer += 1
if 0 < x - 1 < 9 and 0 < y - 2 < 9:
    answer += 1

print(answer)
