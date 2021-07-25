extends Node2D




var mapPath = ""
var mapData = { }
	
func _ready():
	pass
	
func _loadMap() -> void:
	var file = File.new()
	
	if !file.file_exists(mapPath):
		get_tree().change_scene("res://Scenes/Scenes/LoadMap.tscn")
	
	file.open(mapPath, file.READ)
	var text = file.get_as_text()
	
	mapData = parse_json(text)
	file.close()
	
	_createMap()
	
	_makeBricks()
	_makeCoins()
	_makeAirbricks()
	
	_spawnPlayer()
	
	
	pass

func _createMap() -> void:
	get_parent().visible = true
	#$Camera2D.current = true
	get_parent().WorldType = mapData["map"]["settings"]["worldtype"]
	
	
	pass
	
func _createObj(obj,pos,objname) -> void:
	var newobj = obj.instance()
	newobj.position = pos
	get_node("Map/" + objname).add_child(newobj)



func _makeBricks():
	var Brick = preload("res://Scenes/Instances/SMB1/Tiles/Brick.tscn")
	
	for i in mapData["map"]["tiles"]["Bricks"].size():
		var pos = _getPositions(mapData["map"]["tiles"]["Bricks"][i])
		_createObj(Brick,pos,"Bricks")

func _makeCoins():
	var Coin = preload("res://Scenes/Instances/SMB1/Tiles/Coin.tscn")
	
	for i in mapData["map"]["tiles"]["Coins"].size():
		var pos = _getPositions(mapData["map"]["tiles"]["Coins"][i])
		_createObj(Coin,pos,"Coins")	
	
func _makeAirbricks():
	var AirBrick = preload("res://Scenes/Instances/SMB1/Tiles/AirBrick.tscn")
	
	for i in mapData["map"]["tiles"]["AirBricks"].size():
		var pos = _getPositions(mapData["map"]["tiles"]["AirBricks"][i])
		_createObj(AirBrick,pos,"AirBricks")
	
func _spawnPlayer():
	var Player = preload("res://Scenes/Instances/Player.tscn")
	
	var pos = _getPositions(mapData["map"]["player"])
	var newPlayer = Player.instance()
	newPlayer.position = pos
	get_parent().add_child(newPlayer)
	$Camera2D.current = true

func _getPositions(obj):
	var v2 = Vector2((obj["position"]["x"]*32)+16,(obj["position"]["y"]*32)+16)
	return v2
