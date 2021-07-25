extends KinematicBody2D

var data = {}

func _ready():
	$Area.connect("body_entered",self,"_bodyEntered")

func _physics_process(delta):
	var On = get_tree().root.get_child(1).On
	
	if On:
		get_node("AnimatedSprite").animation = "On"
	else:
		get_node("AnimatedSprite").animation = "Off"
	pass

func _bodyEntered(body):
	if "Player" in body.name:
		if !body.onGround and !$Pump/Tween.is_active() and !$Pump/Tween2.is_active():
			get_tree().root.get_child(1).On = !get_tree().root.get_child(1).On
		
	pass
	 
