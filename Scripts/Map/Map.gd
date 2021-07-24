extends Node

var onBrick = preload("res://Scenes/Instances/SMB1/Tiles/Brick.tscn")

export (int) var MAP_WIDTH = 100
export (int) var MAP_HEIGHT = 3

func _ready():
	_generate(MAP_WIDTH,MAP_HEIGHT)
	pass
	
func _generate(w,h):
	
	for y in h:
		for x in w:
			var newBrick = onBrick.instance()
			newBrick.position = Vector2((32 * newBrick.scale.x * x)+16 ,32 * newBrick.scale.y * y + 784)
			$Map/Bricks.add_child(newBrick)
	
	pass
