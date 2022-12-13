data = [line.split('-') for line in
        [line.strip() for line in
         open('input/day-12-example-1.txt')]]

graph = {}
for k,v in data:
    if k not in graph:
        graph[k] = []
    if v not in graph:
        graph[v] = []
    graph[k].append(v)
    graph[v].append(k)

#==== Part 1 ==================================

class Graph:
    def __init__(self, graph):
        self.graph = graph
        self.path_count = 0

    def count_paths(self, start, end):
        visited = {key: False for key in self.graph}
        self.count_paths_util(start, end, visited)
        return self.path_count

    def count_paths_util(self, u, end, visited):
        if not u.isupper():
            visited[u] = True
        if (u == end):
            self.path_count += 1
        else:
            for v in self.graph[u]:
                if not visited[v]:
                    self.count_paths_util(v, end, visited)
        visited[u] = False


g = Graph(graph)
print(g.count_paths('start', 'end')) # 5157

#==== Part 2 ==================================

class Graph2:
    def __init__(self, graph):
        self.graph = graph
        self.path_count = 0

    def count_paths(self, start, end):
        for u in self.graph:
            if u == start or u == end or u.isupper():
                continue
            visit_twice= {u: 2}
            visited = {key: False for key in self.graph}
            self.count_paths_util(start, end, visited, visit_twice)
        return self.path_count

    def count_paths_util(self, u, end, visited, visit_twice):
        if not u.isupper():
            visited[u] = True
        if u in visit_twice:
            visit_twice[u] -= 1
        # If current vertex is the destination, increment count
        if (u == end):
            self.path_count += 1
        else:
            for v in self.graph[u]:
                if not visited[v] or (v in visit_twice and visit_twice[v] > 0):
                    self.count_paths_util(v, end, visited, visit_twice)
        visited[u] = False


g = Graph2(graph)
print(g.count_paths('start', 'end'))
