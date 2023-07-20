import sys

N, K = map(int, sys.stdin.readline().split())
A = list(map(int, sys.stdin.readline().split()))
B = list(map(int, sys.stdin.readline().split()))

for _ in range(K):
    min_A = A.index(min(A))  # 리스트에서 특정 값을 인덱스 찾기
    max_B = B.index(max(B))

    A[min_A], B[max_B] = B[max_B], A[min_A]  # 파이썬에서 리스트 원소 자리 바꾸기

print(sum(A))
