extends Control

var LoadMap = "res://Scenes/Scenes/LoadMap.tscn"

func _ready():
	pass


func _on_LoadMap_btn_pressed():
	get_tree().change_scene(LoadMap)
	pass # Replace with function body.
