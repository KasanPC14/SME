extends KinematicBody2D

export var speed = 200
export var max_speed = 300
export var accuration = 10
export var jump = -450
var oldJump = jump
export var gravity = 20



var playerParameters := {
	"Powerup" : 0,
	"Coins" : 0,
	"Score" : 0,
}

var UP = Vector2(0,-1)

var motion = Vector2()

var onGround = false
var isMoving = false
var isRunning = false

var K_LEFT = null
var K_RIGHT = null
var K_C = null
var K_X = null
var K_Z = null

var Sounds = null

func _ready():
	Sounds = $Sounds
	pass
	
func _physics_process(delta):
	
	onGround = is_on_floor()
	set_keys()
	movement()
	set_animations()
	
	if motion.x > 0:
		jump = oldJump - motion.x/2.5
	else:
		jump = oldJump + motion.x/2.5
	

func set_keys():
	K_LEFT = Input.is_action_pressed("LEFT")
	K_RIGHT = Input.is_action_pressed("RIGHT")
	K_Z = Input.is_action_just_pressed("Z")
	K_X = Input.is_action_pressed("X")
	K_C = Input.is_action_pressed("C")
	

func movement():
	
	if motion.x < accuration and motion.x > -accuration:
		motion.x = 0
	
	if K_LEFT:
		motion.x -= accuration
	elif K_RIGHT:
		motion.x += accuration
		
	if motion.x > 0 and !K_RIGHT and onGround:
		motion.x -= accuration
	if motion.x < 0 and !K_LEFT and onGround:
		motion.x += accuration
	
	if motion.x > 0 and !K_RIGHT and !onGround:
		motion.x -= accuration/4
	if motion.x < 0 and !K_LEFT and !onGround:
		motion.x += accuration/4
	
	if !isRunning:
		if motion.x > speed:
			motion.x -= accuration*2
		elif motion.x < -speed:
			motion.x += accuration*2
	else:
		if motion.x > max_speed:
			motion.x = max_speed
		elif motion.x < -max_speed:
			motion.x = -max_speed
	
	if K_Z and onGround:
		motion.y = jump
		Sounds.play("Jump")
		
	if K_C:
		isRunning = true
	else:
		isRunning = false
		
	
	motion.y += gravity
	
	motion = move_and_slide(motion, UP)	

func set_animations():
	var animSpr = $AnimatedSprite
	
	
	
	if !animSpr.flip_h:
		animSpr.speed_scale = motion.x / speed
	else:
		animSpr.speed_scale = -motion.x / speed
			
	if animSpr.speed_scale < 0.5:
		animSpr.speed_scale = 0.5
		
	
	if motion.x > 0:
		animSpr.flip_h = false
		isMoving = true
	elif motion.x < 0:
		animSpr.flip_h = true
		isMoving = true
	else:
		isMoving = false

	#animSpr.speed_scale = motion.x / speed
	
	if isMoving and onGround:
		animSpr.animation = "Walk"
		
	elif !isMoving and onGround:
		animSpr.animation = "Idle"
		
	elif !onGround:
		animSpr.animation = "Jump"
		
	###################################
	
	if motion.x > 0 and K_LEFT and !K_RIGHT and onGround:
		animSpr.animation = "Slowing"
		animSpr.flip_h = true
	if motion.x < 0 and K_RIGHT and !K_LEFT and onGround:
		animSpr.animation = "Slowing"
		animSpr.flip_h = false

