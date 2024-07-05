extends Node
class_name  Walker

const DIRECTIONS = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]

var position: Vector2 = Vector2.ZERO
var direction: Vector2 = Vector2.RIGHT
var borders:Rect2 = Rect2()
var path: Array = []
var step_since_turn: int = 0


func _init(start_position: Vector2, new_borders: Rect2):
	#check if start position is within borders
	assert(new_borders.has_point(start_position))
	position = start_position
	path.append(start_position)
	borders = new_borders
	

func step() -> bool:	#Try step in the current direction, return true if able and vice versa
	var try_position: Vector2 = position + direction
	if(borders.has_point(try_position)):
		position = try_position
		step_since_turn += 1
		return true
	else:
		return false

func walk(walk_length: int):
	for i in walk_length:
		step()

func new_direction() -> Vector2:
	var directions:Array = DIRECTIONS.duplicate()
	directions.erase(direction)
	var try_dir = directions.pop_front()
	while !borders.has_point(position + try_dir):
		try_dir = directions.pop_front()
	return Vector2.ZERO
