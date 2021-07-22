extends Node

export (String,"Overworld","Underground","Castle") var WorldType = ""

export (Color,RGBA) var Color_overworld = Color(169,185,255,255)
export (Color,RGBA) var Color_underground = Color(0,0,0.2,255)
export (Color,RGBA) var Color_castle = Color(0,0,0,255)

func _ready():
	var bg = $Background
	
	if WorldType == "Overworld":
		bg.color = Color_overworld
	if WorldType == "Underground":
		bg.color = Color_underground
	if WorldType == "Castle":
		bg.color = Color_castle
	
	
	pass
