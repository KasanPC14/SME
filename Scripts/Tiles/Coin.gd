extends KinematicBody2D


func _ready():
	pass

func _physics_process(delta):
	#$AnimatedSprite.animation = get_parent().get_parent().get_parent().get_parent().WorldType
	pass
	
func _on_Collision_body_entered(body):
	if body.name.begins_with("Player"):
		get_parent().get_node("CoinSound").play()
		get_tree().queue_delete(self)
		body.playerParameters.Coins += 1
	pass # Replace with function body.
