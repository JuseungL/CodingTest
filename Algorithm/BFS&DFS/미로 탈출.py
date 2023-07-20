from collections import deque
import sys

fin = sys.stdin.readline


# BFS 소스코드 구현
def bfs(x, y):
    # 큐(Queue) 구현을 위해 deque 라이브러리 사용
    queue = deque()
    queue.append((x, y))
    # 큐가 빌 때까지 반복
    while queue:
        x, y = queue.popleft()
        # 현재 위치에서 4가지 방향으로의 위치 확인
        for i in range(4):
            nx = x + dx[i]
            ny = y + dy[i]
            # 미로 찾기 공간을 벗어난 경우 무시
            if nx < 0 or nx >= n or ny < 0 or ny >= m:
                continue
            # 벽인 경우 무시
            if graph[nx][ny] == 0:
                continue
            # 해당 노드를 처음 방문하는 경우에만 최단 거리 기록
            if graph[nx][ny] == 1:
                graph[nx][ny] = graph[x][y] + 1  # 최단 거리 갱신
                queue.append((nx, ny))
    return graph[n - 1][m - 1]


# N, M을 공백을 기준으로 구분하여 입력 받기
n, m = map(int, fin().split())
# 2차원 리스트의 맵 정보 입력 받기
graph = []
for i in range(n):
    graph.append(list(map(int, fin())))

# 이동할 네 가지 방향 정의 (상, 하, 좌, 우)
dx = [0, 0, -1, 1]
dy = [1, -1, 0, 0]

# BFS를 수행한 결과 출력
print(bfs(0, 0))
