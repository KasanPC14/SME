extends KinematicBody2D

var scene = null

func _ready():
	scene = get_parent().get_parent().get_parent().get_parent()
	pass

func _physics_process(delta):
	
	#$AnimatedSprite.animation = scene.WorldType
	
	pass
