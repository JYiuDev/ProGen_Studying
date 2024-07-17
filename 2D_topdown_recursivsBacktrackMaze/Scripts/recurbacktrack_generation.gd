extends Node

#direction in binary value
const N = 1
const E = 2
const S = 4
const W = 8

var wall_directions:Dictionary = {Vector2.UP: N, Vector2.RIGHT: E, Vector2.DOWN: S, Vector2.LEFT: W}
var tile_size: int = 16
var width: int
var height: int

@onready var tilemap:TileMap = $TileMap

func _ready():
	var test_binary = N|E
	print(test_binary)
