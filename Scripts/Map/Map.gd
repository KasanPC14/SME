extends Node

var onBrick = preload("res://Scenes/Instances/Tiles/Brick.tscn")

func _ready():
	_generate(10,2)
	pass
	
func _generate(w,h):
	
	for y in h:
		for x in w:
			var newBrick = onBrick.instance()
			newBrick.position = Vector2((32 * newBrick.scale.x * x)+16 ,32 * newBrick.scale.y * y + 720)
			$Map/Bricks.add_child(newBrick)
	
	pass
