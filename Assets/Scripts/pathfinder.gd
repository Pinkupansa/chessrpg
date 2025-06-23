class_name Pathfinder

## Breadth-First-Search algorithm [br]
## [code]get_neighbours_function[/code] takes in a cell and outputs all neighbours of the cell
static func find_path(get_neighbours_function: Callable, start: Vector2i, end: Vector2i) -> Array[Vector2i]:
	#a dictionary that tells what cell called what cell, to reconstruct the path later
	var predecessor = {start: Vector2.ZERO} 

	#the queue of cells to visit. the front element is the next cell.
	var queue = [start] 

	var max_iter = 10000 #avoid infinite loops
	for i in range(max_iter):
		if len(queue) == 0: 
			#no more cells to visit
			break

		var current_cell = queue.pop_front()
		if current_cell == end:
			#this is the end cell
			break

		#look at all neighbours of the cell
		var neighbours = get_neighbours_function.call(current_cell)
		if i%2 == 0:
			neighbours.reverse() # otherwise x direction is always looked at first which makes ugly paths

		for neighbour in neighbours:
			if not neighbour in predecessor: #if the neighbour is not visited already
				predecessor[neighbour] = current_cell #remember that this cell called the neighbour
				queue.append(neighbour) #add neighbour to the cells to visit 

	if end not in predecessor: #the end has not been found, return empty path
		return []
	
	#reconstruct the path from end to start using the predecessor table
	var path: Array[Vector2i] = [end]
	while true:
		var current = path.back() 
		if current == start:
			break
		path.append(predecessor[current])
	path.reverse()
	return path



	
	
