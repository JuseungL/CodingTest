import sys

# N, K = map(int, input().split())
# 한칸 띄워져 있는거 입력 받기
N, K = map(int, sys.stdin.readline().split(" "))

coins = [int(sys.stdin.readline()) for _ in range(N)]
coins.reverse()  # 리스트 뒤집기

count = 0

for coin in coins:
    count += K // coin
    K %= coin

print(count)
