extends KinematicBody2D

var scene = null

var data = {}

func _ready():
	scene = get_tree().root.get_child(1)
	pass

func _physics_process(delta):
	
	$AnimatedSprite.animation = scene.WorldType
	
	pass
