import sys

N = int(sys.stdin.readline().rstrip())
numbers = [int(sys.stdin.readline()) for _ in range(N)]

numbers.sort(reverse=True)

# answer = ""
# for i in numbers:
#     answer += str(i)
#     answer += " "

for i in numbers:
    print(i, end=" ")
