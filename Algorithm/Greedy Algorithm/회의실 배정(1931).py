import sys

N = int(sys.stdin.readline())
meeting_times = [list(map(int, input().split())) for _ in range(N)]
meeting_times.sort(key=lambda x: (x[1], x[0]))
# 정렬 키는 먼저 종료 시간(x[1])을 기준으로 오름차순으로 정렬
# 종료시간이 같으면 시작시간(x[0])을 기준으로 오름차순으로 정렬

endPoint = 0
answer = 0

for newStart, newEnd in meeting_times:
    if endPoint <= newStart:
        answer += 1
        endPoint = newEnd
print(answer)
