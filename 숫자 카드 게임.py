import sys

N, M = map(int, sys.stdin.readline().split())
cards = list()
# for i in range(N):
#     cards.append(list(map(int, sys.stdin.readline().split())))
cards = [list(map(int, sys.stdin.readline().split())) for _ in range(N)]

min_cards = [min(cards[row]) for row in range(N)]

answer = max(min_cards)

print(answer)
# ㅡㅡㅡㅡ책 답안ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
result = 0
for i in range(N):
    cards = list(map(int, input().split()))
    # 현재 줄에서 가장 작은 수
    min_value = min(cards)
    # 현재 까지 가장 컸던 수와 이번에 들어온 min_value중 더 작은 값 반영
    result = max(result, min_value)

print(result)
