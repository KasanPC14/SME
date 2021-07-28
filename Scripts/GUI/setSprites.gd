extends Node

var data = {}

func _ready():
	pass
	
func _physics_process(delta):
	get_node("AnimatedSprite").animation = get_tree().root.get_child(1).WorldType
