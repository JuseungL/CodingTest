import sys

"""
N=1260
coins = [500,100,50,10]
"""
N = int(sys.stdin.readline().rstrip())
# coins = [int(sys.stdin.readline()) for _ in range(4)] #엔터로 입력
coins = list(map(int, sys.stdin.readline().rstrip().split()))  # 띄어쓰기로 입력, 갯수 제한 x
answer = 0
for coin in coins:
    answer += N // coin  # 해당 화폐로 거슬러 줄 수 있는 동전의 갯수 새기
    N %= coin

print(answer)
