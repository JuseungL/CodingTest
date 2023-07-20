import sys
import heapq

N = int(sys.stdin.readline())
lectures = [list(map(int, input().split())) for _ in range(N)]  # [[페이, 날짜]]
lectures.sort(key=lambda x: x[1])  # 날짜 순으로 오름차순!
answers = list()
for pay, deadline in lectures:
    heapq.heappush(answers, pay)
    if len(answers) > deadline:
        heapq.heappop(answers)

print(sum(answers))

""" 날짜가 아니라 데드라인이였다...
"""
