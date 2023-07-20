import sys

N = int(sys.stdin.readline())
P = list(map(int, sys.stdin.readline().split(" ")))  # 한줄로 띄워쓰기로 입력받아서 리스팅
P.sort()  # 오름차순 정렬
total = 0
answer = 0

for time in P:
    total += time  # 기다린 시간
    answer += total  # 총 인출하는데 거리린 시간

print(answer)
