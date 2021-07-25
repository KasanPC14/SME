extends Node2D

var mouse_pos = Vector2()

onready var Brick = load("res://Scenes/Instances/SMB1/Tiles/Brick.tscn")
onready var AirBrick = load("res://Scenes/Instances/SMB1/Tiles/AirBrick.tscn")
onready var Block = load("res://Scenes/Instances/SMB1/Tiles/Block.tscn")
onready var Coin = load("res://Scenes/Instances/SMB1/Tiles/Coin.tscn")
onready var OffBlock = load("res://Scenes/Instances/SMB1/Tiles/OffBlock.tscn")
onready var OnBlock = load("res://Scenes/Instances/SMB1/Tiles/OnBlock.tscn")
onready var QuestionBlock = load("res://Scenes/Instances/SMB1/Tiles/QuestionBlock.tscn")
onready var SwitchBlock = load("res://Scenes/Instances/SMB1/Tiles/SwitchBlock.tscn")

var selected = null
var selectedTile = null
var selectedTileName = ""

var onGui = false

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
			"AirBricks": [],
			"Blocks": [],
			"Coins": [],
			"OffBlocks": [],
			"OnBlocks": [],
			"SwitchBlocks": [],
			"QuestionBlocks": []
			
			
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
	print(mapData["map"]["tiles"]["Bricks"].size())
	mouse_pos = get_global_mouse_position()
	_showSelected()
	
	if Input.is_action_pressed("Mouse1") and !onGui:
		_putTile()
	if Input.is_action_pressed("Mouse2") and !onGui:
		_deleteTile()	
	
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
				if Vector2(mapData["map"]["tiles"].values()[i][j]["position"]["x"],mapData["map"]["tiles"].values()[i][j]["position"]["y"]) == _getVector(newBrick.position):
					canPut = false
					
		
	#puts tile	
	if canPut:	
		var newTile = selectedTile.instance()
		newTile.position = newBrick.position
		newTile.data = {"position": {"x": _getPositions(newTile.position.x), "y":_getPositions(newTile.position.y)}}
		get_node("Map/" + selectedTileName).add_child(newTile)
		
		mapData["map"]["tiles"][selectedTileName].append({"position": {"x": _getPositions(newTile.position.x), "y":_getPositions(newTile.position.y)}})
	
	pass

func _deleteTile():
	var canDel = true
	
	for i in mapData["map"]["tiles"].values().size(): #i = all tiles
		if mapData["map"]["tiles"].values()[i] != []: #if not empty
			for child in get_node("Map").get_children():
				for num in child.get_child_count():
					if  !("Sound" in child.get_child(num).name):
						if _getVector(child.get_child(num).position) == _getVector(newBrick.position):
							
							child.get_child(num).queue_free()
					
					
				
func _changeBlock(obj,objname):
	selectedTile = obj
	selectedTileName = objname
	get_node("selected").queue_free()
	

func _on_AirBrick():
	_changeBlock(AirBrick,"AirBricks")
	pass # Replace with function body.

func _on_Brick():
	_changeBlock(Brick,"Bricks")
	pass

func _on_Block():
	_changeBlock(Block,"Blocks")
	pass

func _on_Coin():
	_changeBlock(Coin,"Coins")
	pass

func _on_OffBlock():
	_changeBlock(OffBlock,"OffBlocks")

func _on_OnBlock():
	_changeBlock(OnBlock,"OnBlocks")

func _on_SwitchBlock():
	_changeBlock(SwitchBlock,"SwitchBlocks")

func _on_QuestionBlock():
	_changeBlock(QuestionBlock,"QuestionBlocks")

func _on_gui_mouse_entered():
	onGui = true
	pass # Replace with function body.


func _on_gui_mouse_exited():
	onGui = false
	pass # Replace with function body.

func _getPositions(val):
	var result = (val-16)/32
	return result
	
	
func _getVector(v2):
	var result = Vector2((v2.x-16)/32, (v2.y-16)/32)
	return result

