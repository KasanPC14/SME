extends KinematicBody2D

export (String,"Left","Right") var Direction = "Left"

export var gravity = 2
export var speed = 50


var motion = Vector2()
var UP = Vector2(0,-1)

func _ready():
	if get_tree().get_current_scene().get_name() != "MapMaker":
		get_node("BodyArea").connect("body_entered",self,"_bodyThouched")
		get_node("Area").connect("body_entered",self,"_UstTouched")
	
	pass 

func _physics_process(delta):
	
	get_node("AnimatedSprite").animation = get_tree().root.get_child(1).WorldType
	
	if Direction == "Left":
		motion.x = -speed
	elif Direction == "Right":
		motion.x = speed
	
	motion.y += gravity
	
	if get_tree().get_current_scene().get_name() != "MapMaker":
		move_and_slide(motion,UP)
	pass

func _bodyThouched(body):
	if "Player" in body.name and body.position.y >= position.y:
		body.die()
	elif "Goomba" in body.name:
		pass
	else:
		if Direction == "Left":
			Direction = "Right"
		elif Direction == "Right":
			Direction = "Left"	
	

func _UstTouched(body):
	if "Player" in body.name:
		
		if Input.is_action_pressed("Z"):
			body.motion.y = -600
		else:
			body.motion.y = -350
		body.get_node("Sounds/Stomp").play()
		queue_free()
		
	elif "Goomba" in body.name:
		pass
