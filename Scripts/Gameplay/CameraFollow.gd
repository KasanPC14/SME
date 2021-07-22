extends Camera2D


func _ready():
	pass

func _physics_process(delta):
	var player = get_parent().get_parent().get_node("Player")
	transform.origin = Vector2(player.position.x,transform.origin.y)
	pass
