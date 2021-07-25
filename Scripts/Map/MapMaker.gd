extends Node2D

var mouse_pos = Vector2()

onready var Brick = load("res://Scenes/Instances/SMB1/Tiles/Brick.tscn")
onready var AirBrick = load("res://Scenes/Instances/SMB1/Tiles/AirBrick.tscn")
onready var Coin = load("res://Scenes/Instances/SMB1/Tiles/Coin.tscn")

var selected = null
var selectedTile = null
var selectedTileName = ""

var newBrick = null

var mapData = {
	
		"map": {
		"settings": {
			"worldtype": "Overworld",
			"theme": "smb1"
		},
		
		"player": {
			"position": {"x":0,"y":23}
		},
		
		"tiles": {
			"Bricks": [],
			"Coins": [],
			"AirBricks": []
		}
	}
}

var playerStart = Vector2()

onready var player = get_parent().get_node("Player")

func _ready():
	selectedTile = Brick
	selectedTileName = "Bricks"
	playerStart = player.position
	pass

func _physics_process(delta):
	mouse_pos = get_global_mouse_position()
	_showSelected()
	
	if Input.is_action_pressed("Mouse1"):
		_putTile()
	if Input.is_action_just_pressed("R"):
		player.position = playerStart
	
	
func _showSelected():
	if get_node("selected") == null:
		newBrick = selectedTile.instance()
		add_child(newBrick)
		newBrick.name = "selected"
	
		for i in newBrick.get_child_count():
			if newBrick.get_child(i).name == "Collision":
				newBrick.get_node("Collision").disabled = true
			else:
				newBrick.get_node("Area/Collision").disabled = true
		
	newBrick.position = _snapPos(mouse_pos)
	
	newBrick.get_node("AnimatedSprite").modulate = Color(1,1,1,0.4)
	
	pass

func _snapPos(pos):
	var result = Vector2() 
	
	result.x = pos.x - fmod(pos.x+16,32)
	result.y = pos.y - fmod(pos.y+16,32)
		
	return result

func _putTile():
	
	var canPut = true
	
	#Test any block on that tile
	for i in mapData["map"]["tiles"].values().size():
		if mapData["map"]["tiles"].values()[i] != []:
			for j in mapData["map"]["tiles"].values()[i].size():
				if Vector2(mapData["map"]["tiles"].values()[i][j]["position"]["x"],mapData["map"]["tiles"].values()[i][j]["position"]["y"]) == newBrick.position:
					canPut = false
					
		
	#puts tile	
	if canPut:	
		var newTile = selectedTile.instance()
		newTile.position = newBrick.position
		get_node("Map/" + selectedTileName).add_child(newTile)
	
		mapData["map"]["tiles"][selectedTileName].append({"position": {"x": newTile.position.x, "y":newTile.position.y}})
	
	pass


