extends KinematicBody2D

var data = {}

func _physics_process(delta):
	var On = get_tree().root.get_child(1).On
	
	if On:
		get_node("AnimatedSprite").animation = "On"
	else:
		get_node("AnimatedSprite").animation = "Off"
	
	if "On" in name:
		if get_node("AnimatedSprite").animation == "On":
			get_node("Collision").disabled = false
		else:
			get_node("Collision").disabled = true
			
	if "Off" in name:
		if get_node("AnimatedSprite").animation == "On":
			get_node("Collision").disabled = true
		else:
			get_node("Collision").disabled = false
	pass
