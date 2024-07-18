extends Node

#direction in binary value
const N = 1
const E = 2
const S = 4
const W = 8

var wall_directions:Dictionary = {Vector2.UP: N, Vector2.RIGHT: E, Vector2.DOWN: S, Vector2.LEFT: W}
var tile_size: int = 16
var width: int = 18
var height: int = 10
var unvisited: Array

#Tileset properties
var tileset_collumns: int = 4
var tileset_rows:     int = 4

@onready var tilemap:TileMap = $TileMap

func _ready():
	randomize()
	create_maze()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		randomize()
		create_maze()

func get_univisted_neighbours(cell: Vector2, univisited: Array) -> Array:
	#Returns an array of the cells univisited neighbours
	var list = []
	for dir in wall_directions.keys():
		var neighbour_cell: Vector2 = cell + dir
		if neighbour_cell in univisited:
			list.append(neighbour_cell)
	return list

func create_maze():
	var stack = [] #stack of cells travelled
	unvisited.clear()
	tilemap.clear()
	for x in range(width):
		for y in range(height):
			#register tiles
			var cell: Vector2 = Vector2(x,y)
			unvisited.append(cell)
			tilemap.set_cell(0, cell, 0, int_to_atlas(N|E|S|W))
			
			#print(atlas_to_int(tilemap.get_cell_atlas_coords(0, cell)) - wall_directions[Vector2.UP])
	
	var current_cell : Vector2 = Vector2.ZERO
	unvisited.erase(current_cell)
	
	while  !unvisited.is_empty():
		#iterate backtrack algo
		var neighbours: Array = get_univisted_neighbours(current_cell, unvisited)
		if neighbours:
			var next_cell: Vector2 = neighbours.pick_random()
			#knock down walls between two cells
			remove_walls(current_cell, next_cell)
			stack.append(current_cell)
			current_cell = next_cell
			unvisited.erase(current_cell)
			await get_tree().create_timer(0.01).timeout
		else:
			current_cell = stack.pop_back()


func remove_walls(a_cell: Vector2, b_cell: Vector2):
	var a_to_b: Vector2i = int_to_atlas(wall_directions[b_cell - a_cell])
	var b_to_a: Vector2i = int_to_atlas(wall_directions[a_cell - b_cell])
	tilemap.set_cell(0, a_cell, 0, tilemap.get_cell_atlas_coords(0, a_cell) - a_to_b)
	tilemap.set_cell(0, b_cell, 0, tilemap.get_cell_atlas_coords(0, b_cell) - b_to_a)

func int_to_atlas(num: int) -> Vector2:
	var atlas_coord: Vector2 = Vector2(num % tileset_collumns, num / tileset_rows)
	return atlas_coord

func atlas_to_int(coord: Vector2) -> int:
	var num = coord.x + (coord.y * tileset_rows)
	return num
