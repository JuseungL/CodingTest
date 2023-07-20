import sys

N, M = map(int, sys.stdin.readline().rstrip().split())
graph = []

# 2차원 좌표 입력
for i in range(N):
    graph.append(list(map(int, input())))


# DFS로 특정 노드를 방문하고 연결된 모든 노드들도 방문
def dfs(x, y):
    # 주어진 범위를 벗어나는 경우 즉시 종료
    if x <= -1 or x >= N or y <= -1 or y >= M:
        return False
    # 현재 노드를 아직 방문하지 않았다면
    if graph[x][y] == 0:
        # 해당 노드 방문 처리
        graph[x][y] = 1
        # 상, 하, 좌, 우의 위치들도 모두 재귀적으로 호출
        dfs(x - 1, y)
        dfs(x, y - 1)
        dfs(x + 1, y)
        dfs(x, y + 1)
        return True
    return False


answer = 0
for i in range(N):
    for j in range(M):
        if dfs(i, j) == True:
            answer += 1

print(answer)
