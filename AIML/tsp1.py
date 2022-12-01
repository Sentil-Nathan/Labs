def nearest_neighbor_tsp(adj, n):
    curr = 0
    cost = 0
    path = "Path: 0"
    visited = [0]
    while len(visited) != n:
        print(path)
        print(f"Cost: {cost}")
        distance = 100000000
        new_curr = None
        for x in range(n):
            if x not in visited:
                if adj[curr][x] < distance:
                    distance = adj[curr][x]
                    new_curr = x
        cost += adj[curr][new_curr]
        curr = new_curr
        path += f" -> {curr} "
        visited.append(curr)
    path += " -> 0"
    cost += adj[curr][0]
    print(path)
    print(f"Cost: {cost}")
adj = []
n = int(input("Enter size"))
for i in range(n):
    data_int = []
    data = input(f"Enter row{i} data: ").split(" ")
    for x in data:
        data_int.append(int(x))
    adj.append(data_int)
nearest_neighbor_tsp(adj, n)

'''
4
-1 10 15 20
10 -1 35 25
15 35 -1 30
20 25 30 -1
'''
