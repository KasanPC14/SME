extends Node2D


var mapPath = ""
var mapData = { }
	
func _ready():
	pass
	
func _loadMap(path) -> void:
	mapPath = path
	
	var file = File.new()
	
	if !file.file_exists(mapPath):
		get_tree().change_scene("res://Scenes/Scenes/LoadMap.tscn")
	
	file.open(mapPath, file.READ)
	var text = file.get_as_text()
	
	mapData = parse_json(text)
	file.close()
	
	_createMap()
	_deleteOld()
	
	_makeBricks()
	_makeBlocks()
	_makeCoins()
	_makeAirbricks()
	_makeOffBlocks()
	_makeOnBlocks()
	_makeSwitchBlocks()
	_makeQuestionBlocks()
	
	get_parent().mapData = mapData
	#_spawnPlayer()
	
	
	pass

func _createMap() -> void:
	get_parent().visible = true
	#$Camera2D.current = true
	get_parent().get_parent().WorldType = mapData["map"]["settings"]["worldtype"]
	print(get_parent().get_parent().WorldType)
	
	pass
	
func _createObj(obj,pos,objname) -> void:
	var newobj = obj.instance()
	newobj.position = pos
	get_parent().get_node("Map/" + objname).add_child(newobj)



func _makeBricks():
	var Brick = preload("res://Scenes/Instances/SMB1/Tiles/Brick.tscn")
	
	for i in mapData["map"]["tiles"]["Bricks"].size():
		var pos = _getPositions(mapData["map"]["tiles"]["Bricks"][i])
		_createObj(Brick,pos,"Bricks")

func _makeBlocks():
	var Block = preload("res://Scenes/Instances/SMB1/Tiles/Block.tscn")
	
	for i in mapData["map"]["tiles"]["Blocks"].size():
		var pos = _getPositions(mapData["map"]["tiles"]["Blocks"][i])
		_createObj(Block,pos,"Blocks")

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

func _spawnPlayer():
	var Player = preload("res://Scenes/Instances/Player.tscn")
	
	var pos = _getPositions(mapData["map"]["player"])
	var newPlayer = Player.instance()
	newPlayer.position = pos
	get_parent().add_child(newPlayer)
	$Camera2D.current = true

func _deleteOld():
	var oldBricks = get_parent().get_node("Map/Bricks")
	var oldAirBricks = get_parent().get_node("Map/AirBricks")
	var oldCoins = get_parent().get_node("Map/Coins")
	var oldOffBlocks = get_parent().get_node("Map/OffBlocks")
	var oldOnBlocks = get_parent().get_node("Map/OnBlocks")
	var oldSwitchBlocks = get_parent().get_node("Map/SwitchBlocks")
	var oldQuestionBlocks = get_parent().get_node("Map/SwitchBlocks")
	
	_del(oldBricks)
	_del(oldAirBricks)
	_del(oldOffBlocks)
	_del(oldOnBlocks)
	_del(oldSwitchBlocks)
	
	for i in oldCoins.get_child_count():
		if oldCoins.get_child(i).name.begins_with("Coin"):
			oldCoins.get_child(i).queue_free()
	
	
	
func _getPositions(obj):
	var v2 = Vector2((obj["position"]["x"]*32)+16,(obj["position"]["y"]*32)+16)
	return v2



func _on_FileDialog_file_selected(path):
	if get_parent().get_parent().get_node("Maker/FileDialog").mode == FileDialog.MODE_OPEN_FILE:
		_loadMap(path)
	pass # Replace with function body.

func _del(obj):
	for i in obj.get_child_count():
		obj.get_child(i).queue_free()
	pass
