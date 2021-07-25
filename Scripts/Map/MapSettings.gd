extends Node2D

export (String,"Overworld","Underground","Castle") var WorldType = "Overworld"

export (bool) var On = false

func _ready():
	
	pass

func _physics_process(delta):
	
	if WorldType == null:
		WorldType = "Overworld"
	
	var bg = null
	
	if get_tree().get_current_scene().get_name() == "LoadMap":
		bg = get_node("Level/Map/Camera2D/GUI/Background")
	else:
		bg = get_node("Map/Camera2D/GUI/Background")
	
	if WorldType == "Overworld":
		bg.color = Color.cornflower
	if WorldType == "Underground":
		bg.color = Color.navyblue
	if WorldType == "Castle":
		bg.color = Color.black

func _getworldtype():
	return WorldType
