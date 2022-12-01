import random
def input_size_board():
    n = int(input("Enter size of board: "))
    return n
def print_board(board, n):
    print('Board:')
    for i in range(len(board)):
        print(str(board[i]) + ' ', end='')
        if (i + 1) % n == 0:
            print()
    print('H value: ', determine_h_cost(board, n))
    print('---------------------')
def generate_random_board(n):
    generated_board = []
    for i in range(n):
        j = random.randint(0, n-1)
        row = [0]*n
        row[j] = 1
        generated_board.extend(row)
    return generated_board
def find_collisions(board, n):
    collisions = 0
    max_index = len(board)
    for i in range(max_index):
        if board[i] == 1:
            for x in range(1, n):
                if (i - n*x >= 0):
                    north = i - n*x
                    if (board[north] == 1):
                        collisions += 1
                    if (int((north - x)/n) == int(north/n)) and (north - x) >= 0:
                        northwest = north - x
                        if (board[northwest] == 1):
                            collisions += 1
                    if (int((north + x)/n) == int(north/n)):
                        northeast = north + x
                        if (board[northeast] == 1):
                            collisions += 1
                if (i + n*x < max_index):
                    south = i + n*x
                    if (board[south] == 1):
                        collisions += 1
                    if (int((south - x)/n) == int(south/n)):
                        southwest = south - x
                        if (board[southwest] == 1):
                            collisions += 1
                    if (int((south + x)/n) == int(south/n)) and ((south + x) < max_index):
                        southeast = south + x
                        if (board[southeast] == 1):
                            collisions += 1
                if (int((i - x)/n) == int(i/n)) and (i - x >= 0):
                    west = i - x
                    if (board[west] == 1):
                        collisions += 1
                if (int((i + x)/n) == int(i/n)) and (i + x < max_index):
                    east = i + x
                    if (board[east] == 1):
                        collisions += 1
    return collisions
def determine_h_cost(board, n):
    collisions = find_collisions(board, n)
    return int(collisions/2)
def find_child(board, n):
    child = []
    current_h_cost = determine_h_cost(board, n)
    same_cost_children = []
    for row in range(n):
        for col in range(n):
            temp_board = []
            temp_board.extend(board[:row*n])
            new_row = [0]*n
            new_row[col] = 1
            temp_board.extend(new_row)
            temp_board.extend(board[(row+1)*n:])
            temp_h_cost = determine_h_cost(temp_board, n)
            if (temp_board != board) and (temp_h_cost < current_h_cost):
                child = temp_board.copy()
                current_h_cost = temp_h_cost
    return child
def steepest_hill_climbing(board, n, max_iterations=10):
    steps = 0
    success = False
    current_board = board.copy()
    for i in range(max_iterations):
        next_node = find_child(current_board, n).copy()
        steps += 1
        if (len(next_node) != 0) and (determine_h_cost(next_node, n) == 0):
            success = True
            break
        if (len(next_node) == 0):
            break
        current_board = next_node.copy()
    print_board(current_board,n)
    return steps, success
n = input_size_board()
iterations = 10
print('Steepest Hill Climbing:')
success_rate_steepest_hill_climbing = False
step_count_rate_steepest_hill_climbing_success = 0
step_count_rate_steepest_hill_climbing_failure = 0
i=0
while(1):
    print('Run ' + str(i + 1) + ':')
    step_count, success = steepest_hill_climbing(
        generate_random_board(n), n)
    if (success):
        print('Success in run ', i+1)
        step_count_rate_steepest_hill_climbing_success += step_count
        break
    else:
        print('Failure.')
        step_count_rate_steepest_hill_climbing_failure += step_count
    success_rate_steepest_hill_climbing += success
    i+=1
for i in range(3, iterations):
    step_count, success = steepest_hill_climbing(generate_random_board(n), n)
    if (success):
        step_count_rate_steepest_hill_climbing_success += step_count
    else:
        step_count_rate_steepest_hill_climbing_failure += step_count
    success_rate_steepest_hill_climbing += success
print('Success rate: ' + str(success_rate_steepest_hill_climbing/iterations))
print('Failure rate: ' + str(1-(success_rate_steepest_hill_climbing/iterations)))
print('Average steps until success: ' +
      str(step_count_rate_steepest_hill_climbing_success/success_rate_steepest_hill_climbing))
print('Average steps until failure: ' + str(step_count_rate_steepest_hill_climbing_failure /
      (iterations - success_rate_steepest_hill_climbing)))
