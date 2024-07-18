extends Node

#direction in binary value
const N = 1
const E = 2
const S = 4
const W = 8

var wall_directions:Dictionary = {Vector2.UP: N, Vector2.RIGHT: E, Vector2.DOWN: S, Vector2.LEFT: W}
var tile_size: int = 16
var width: int = 9
var height: int = 5
var unvisited: Array
@onready var tilemap:TileMap = $TileMap

func _ready():
	randomize()
	create_maze()
	var test_cell: Array = get_univisted_neighbours(Vector2(0,0), unvisited)
	print(test_cell)



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
			var cell: Vector2 = Vector2(x,y)
			unvisited.append(cell)
			tilemap.set_cell(0, cell, 0, Vector2(0,0))


func id_to_atlas():
	pass
