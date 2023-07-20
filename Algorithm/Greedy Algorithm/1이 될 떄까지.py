import sys

# 내 답
N, K = map(int, sys.stdin.readline().split())
print(N, K)
answer = 0
while N != 1:
    if N % K != 0:
        N -= 1
        answer += 1
    else:
        N = N // K  # N//=K있다.
        answer += 1

print(answer)

# ㅡㅡㅡ답지 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
result = 0

# N이 K 이상이라면 K로 계속 나누기
while N >= K:
    # N이 K로 나누어 떨어지지 않는다면 N에서 1씩 빼기
    while N % K != 0:
        N -= 1
        result += 1
    # K로 나누기
    N //= K
    result += 1

print(result)
