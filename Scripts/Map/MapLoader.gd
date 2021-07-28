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
	
	#Tiles
	_makeBricks()
	_makeBlocks()
	_makeCoins()
	_makeAirbricks()
	_makeOffBlocks()
	_makeOnBlocks()
	_makeSwitchBlocks()
	_makeQuestionBlocks()
	
	#Enemies
	_makeGoombas()
	
	_spawnPlayer()
	
	
	pass

func _createMap() -> void:
	get_parent().visible = true
	#$Camera2D.current = true
	get_tree().root.get_child(1).WorldType = mapData["map"]["settings"]["worldtype"]
	
	
	pass
	
func _createObj(obj,pos,objname) -> void:
	var newobj = obj.instance()
	newobj.position = pos
	get_node("Map/" + objname).add_child(newobj)



func _makeBricks():
	var obj = preload("res://Scenes/Instances/SMB1/Tiles/Brick.tscn")
	
	for i in mapData["map"]["tiles"]["Bricks"].size():
		var pos = _getPositions(mapData["map"]["tiles"]["Bricks"][i])
		_createObj(obj,pos,"Bricks")

func _makeBlocks():
	var obj = preload("res://Scenes/Instances/SMB1/Tiles/Block.tscn")
	
	for i in mapData["map"]["tiles"]["Blocks"].size():
		var pos = _getPositions(mapData["map"]["tiles"]["Blocks"][i])
		_createObj(obj,pos,"Blocks")

func _makeCoins():
	var obj = preload("res://Scenes/Instances/SMB1/Tiles/Coin.tscn")
	
	for i in mapData["map"]["tiles"]["Coins"].size():
		var pos = _getPositions(mapData["map"]["tiles"]["Coins"][i])
		_createObj(obj,pos,"Coins")	
	
func _makeAirbricks():
	var obj = preload("res://Scenes/Instances/SMB1/Tiles/AirBrick.tscn")
	
	for i in mapData["map"]["tiles"]["AirBricks"].size():
		var pos = _getPositions(mapData["map"]["tiles"]["AirBricks"][i])
		_createObj(obj,pos,"AirBricks")
	
func _makeOffBlocks():
	var obj = preload("res://Scenes/Instances/SMB1/Tiles/OffBlock.tscn")
	
	for i in mapData["map"]["tiles"]["OffBlocks"].size():
		var pos = _getPositions(mapData["map"]["tiles"]["OffBlocks"][i])
		_createObj(obj,pos,"OffBlocks")
	
func _makeOnBlocks():
	var obj = preload("res://Scenes/Instances/SMB1/Tiles/OnBlock.tscn")
	
	for i in mapData["map"]["tiles"]["OnBlocks"].size():
		var pos = _getPositions(mapData["map"]["tiles"]["OnBlocks"][i])
		_createObj(obj,pos,"OnBlocks")
	
func _makeSwitchBlocks():
	var obj = preload("res://Scenes/Instances/SMB1/Tiles/SwitchBlock.tscn")
	
	for i in mapData["map"]["tiles"]["SwitchBlocks"].size():
		var pos = _getPositions(mapData["map"]["tiles"]["SwitchBlocks"][i])
		_createObj(obj,pos,"SwitchBlocks")
	
func _makeQuestionBlocks():
	var obj = preload("res://Scenes/Instances/SMB1/Tiles/QuestionBlock.tscn")
	
	for i in mapData["map"]["tiles"]["QuestionBlocks"].size():
		var pos = _getPositions(mapData["map"]["tiles"]["QuestionBlocks"][i])
		_createObj(obj,pos,"QuestionBlocks")

func _makeGoombas():
	var obj = preload("res://Scenes/Instances/Enemies/Goomba.tscn")
	
	for i in mapData["map"]["tiles"]["Goombas"].size():
		var pos = _getPositions(mapData["map"]["tiles"]["Goombas"][i])
		_createObj(obj,pos,"Goombas")

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
