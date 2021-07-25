extends KinematicBody2D

var speed = 1000

var UP = Vector2(0,0)

var motion = Vector2()

var K_LEFT = null
var K_RIGHT = null
var K_UP = null
var K_DOWN = null
var K_C = null
var K_X = null
var K_Z = null

func _ready():
	get_node("AnimatedSprite").animation = "Idle"
	get_node("CollisionShape2D").disabled = true
	pass

func _physics_process(delta):
	set_keys()
	
	if K_LEFT:
		motion.x = -speed
	elif K_RIGHT:
		motion.x = speed
	else:
		motion.x = 0
		
	if K_DOWN:
		motion.y = speed
	elif K_UP:
		motion.y = -speed
	else:
		motion.y = 0
	
		
	move_and_slide(motion,UP)
	pass

func set_keys():
	K_LEFT = Input.is_action_pressed("LEFT")
	K_RIGHT = Input.is_action_pressed("RIGHT")
	K_UP = Input.is_action_pressed("UP")
	K_DOWN = Input.is_action_pressed("DOWN")
	K_Z = Input.is_action_just_pressed("Z")
	K_X = Input.is_action_pressed("X")
	K_C = Input.is_action_pressed("C")
