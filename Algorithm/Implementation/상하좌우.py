import sys

N = int(sys.stdin.readline())
# int -> list(),map(),int,rstrip()넣어야지돼
# 문자 담으려면 그냥 list,map안해도돼
directions = sys.stdin.readline().rstrip().split()
x = 1
y = 1
print(directions)
for d in directions:
    if d == "R":
        if y < N:
            y += 1
        print(x, y)
    if d == "L":
        if y > 1:
            y -= 1
        print(x, y)
    if d == "D":
        if x < N:
            x += 1
        print(x, y)
    if d == "U":
        if x > 0:
            x -= 1
        print(x, y)

print(x, y)
