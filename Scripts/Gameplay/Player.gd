extends KinematicBody2D

export var speed = 250
export var accuration = 10
export var jump = -450
export var gravity = 20


var UP = Vector2(0,-1)

var motion = Vector2()

var onGround = false
var isMoving = false

var LEFT = null
var RIGHT = null
var Z = null


func _ready():
	pass
	
func _physics_process(delta):
	
	onGround = is_on_floor()
	set_keys()
	movement()
	set_animations()

func set_keys():
	LEFT = Input.is_action_pressed("LEFT")
	RIGHT = Input.is_action_pressed("RIGHT")
	Z = Input.is_action_just_pressed("Z")

func movement():
	
	if LEFT:
		motion.x -= accuration
	elif RIGHT:
		motion.x += accuration
	else:
		motion.x = 0
	
	if motion.x > speed:
		motion.x = speed
	elif motion.x < -speed:
		motion.x = -speed
	
	
	if Z and onGround:
		motion.y = jump
		
	
	motion.y += gravity
	
	motion = move_and_slide(motion, UP)	

func set_animations():
	var animSpr = $AnimatedSprite
	
	if motion.x > 0:
		animSpr.flip_h = false
		isMoving = true
	elif motion.x < 0:
		animSpr.flip_h = true
		isMoving = true
	else:
		isMoving = false

	
	if isMoving and onGround:
		animSpr.animation = "Walk"
		
	elif !isMoving and onGround:
		animSpr.animation = "Idle"
		
	elif !onGround:
		animSpr.animation = "Jump"
		
	###################################
	
	if motion.x > 0 && LEFT:
		animSpr.animation = "Slowing"
		animSpr.flip_h = true
	elif motion.x < 0 && RIGHT:
		animSpr.animation = "Slowing"
		animSpr.flip_h = false
