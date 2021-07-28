extends KinematicBody2D

export (String,"Coin","Mushroom","Fireflower") var Inside = "Coin"

var used = false

var data = {}

func _ready():
	get_node("Area").connect("body_entered",self,"_onBody")
	pass

func _physics_process(delta):
	if !used:
		get_node("AnimatedSprite").animation = get_tree().root.get_child(1).WorldType
	elif used:
		get_node("AnimatedSprite").animation =  "_" + get_tree().root.get_child(1).WorldType
	
	get_node("Pump").enabled = !used
	
func _onBody(body):
	if "Player" in body.name:
		if !body.onGround and !used:
			used = true
			if Inside == "Coin":
				_coin(body)
	pass


func _coin(body):
	body.playerParameters.Coins += 1
	get_node("CoinSound").play()
	pass
