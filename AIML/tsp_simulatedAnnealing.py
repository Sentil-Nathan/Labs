import random
import math

class City:
	def __init__(self):
		self.x = random.randint(0, 50)
		self.y = random.randint(0, 50)

	def __str__(self):
		return '({},{})'.format(self.x, self.y)


def get_city(n: int):
	city_list = [i for i in range(n)]
	return city_list


def get_dis(c1: City, c2: City):
	return math.sqrt(math.pow(c1.x-c2.x, 2) + math.pow(c1.y-c2.y, 2))


def all_dis(_list:list, city_list): # _list is a index list of the origin list
	dis = 0
	for i in range(len(_list)-1):
		dis += get_dis(city_list[_list[i]], city_list[_list[i+1]])
	dis += get_dis(city_list[_list[-1]], city_list[_list[0]])
	return dis


def SA(citys):
	n = len(citys)  # number of cities
	gen_t = 100 * n  # number of generations
	
	x = get_city(n)
	for i in range(n):
		print("City ",i,end="-> ")
		print(citys[i].x,", ",citys[i].y)
	dis = 99999999
	dis_best = dis
	answer = ''
	T = 280
	rate = 0.92
	
	for i in range(gen_t):
		random.shuffle(x)  # give it a initial state.  random method
	
		new_dis = all_dis(x, citys)  # compute the new distance violently
		
		if dis >= new_dis:
			dis = new_dis
			if dis_best > dis:
				dis_best = dis
				answer = x
		else:
			P = math.exp(-1 * (new_dis - dis) / T)
			if random.random() < P:
				dis = new_dis
		
		T *= rate
		
	print(dis)
	print(answer)

if __name__ == '__main__':
	n = 5

	citys = [City() for i in range(n)]
	SA(citys)
	
