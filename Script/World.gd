extends Node

var borders = Rect2(1, 1, 40, 40)
@onready var tileMap = $TileMap
@export var walker_steps:int = 500


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func generate_world():
	var walker = Walker.new(Vector2(19, 11), borders)
	var map = walker.walk(500)
	walker.queue_free()
	for step in map:
		tileMap.set_cell(step, -1)
