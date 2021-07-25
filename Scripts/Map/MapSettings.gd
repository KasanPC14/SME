extends Node

export (String,"Overworld","Underground","Castle") onready var WorldType = "Overworld"

export (bool) var On = false

func _ready():
	
	if WorldType == null:
		WorldType = "Overworld"
	print(WorldType)
	pass

func _physics_process(delta):
	var bg = $Map/Camera2D/GUI/Background
	
	if WorldType == "Overworld":
		bg.color = Color.cornflower
	if WorldType == "Underground":
		bg.color = Color.navyblue
	if WorldType == "Castle":
		bg.color = Color.black
