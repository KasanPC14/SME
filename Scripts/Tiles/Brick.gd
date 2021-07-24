extends KinematicBody2D


func _ready():
	
	pass

func _physics_process(delta):
	$AnimatedSprite.animation = get_parent().get_parent().get_parent().get_parent().WorldType 
	pass
