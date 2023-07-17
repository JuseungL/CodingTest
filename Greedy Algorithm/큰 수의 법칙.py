import sys

N, M, K = map(int, sys.stdin.readline().rstrip().split())
numbers = list(map(int, sys.stdin.readline().rstrip().split()))
numbers.sort()

answer = 0

while True:
    for i in range(K):  # 가장 큰 수를 K번 더하기
        if M == 0:
            break
        answer += numbers[-1]  # 가장 큰 수
        M -= 1  # 더할 때 마다 1씩 빼면서 k번 더하고 break해서 두번째로 큰 수 더해지도록 하기
    if M == 0:
        break
    answer += numbers[-2]  # 두 번째로 큰 수
    M -= 1

print(answer)

# ㅡㅡㅡㅡ각각 몇 번 더해지는지 미리 계산하기ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
# count = int(M / (K + 1)) * K
# count += M % (K + 1)
# answer = 0
# answer += (count) * numbers[-1]
# answer += (M - count) * numbers[-2]
# print(answer)
