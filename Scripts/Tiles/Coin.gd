extends KinematicBody2D


func _ready():
	pass

func _physics_process(delta):
	get_node("AnimatedSprite").animation = get_tree().root.get_child(1).WorldType
	pass
	
func _on_Collision_body_entered(body):
	if body.name.begins_with("Player"):
		get_parent().get_node("CSound").play()
		get_tree().queue_delete(self)
		body.playerParameters.Coins += 1
	pass # Replace with function body.
