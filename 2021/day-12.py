data = [line.split('-') for line in
        [line.strip() for line in open('input/day-12-example-1.txt')]]

graph = {}
for k,v in data:
    if k not in graph:
        graph[k] = []
    if v not in graph:
        graph[v] = []
    graph[k].append(v)
    graph[v].append(k)

class Graph:
    def __init__(self, graph):
        self.adj = graph
        self.pathCount = 0

    def countPaths(self, s, d):
        # Mark all the vertices as not visited
        visited = {key: False for key in self.adj}
        self.countPathsUtil(s, d, visited)
        return self.pathCount

    def countPathsUtil(self, u, d, visited):
        if not u.isupper():
            visited[u] = True
        # If current vertex is the destination, increment count
        if (u == d):
            self.pathCount += 1
        else:
            for v in self.adj[u]:
                if not visited[v]:
                    self.countPathsUtil(v, d, visited)
        visited[u] = False


g = Graph(graph)
print(g.countPaths('start', 'end')) # 5157


class Graph2:
    def __init__(self, graph):
        self.adj = graph
        self.pathCount = 0

    def countPaths(self, s, d):
        for u in self.adj:
            if u == s or u == d or u.isupper():
                continue
            visit_twice= {u: 2}
            visited = {key: False for key in self.adj}
            self.countPathsUtil(s, d, visited, visit_twice)
        return self.pathCount

    def countPathsUtil(self, u, d, visited, visit_twice):
        if not u.isupper():
            visited[u] = True
        if u in visit_twice:
            visit_twice[u] -= 1
        # If current vertex is the destination, increment count
        if (u == d):
            self.pathCount += 1
        else:
            for v in self.adj[u]:
                if not visited[v] or (v in visit_twice and visit_twice[v] > 0):
                    self.countPathsUtil(v, d, visited, visit_twice)
        visited[u] = False


g = Graph2(graph)
print(g.countPaths('start', 'end'))
