extends Control

var LoadMap = "res://Scenes/Scenes/LoadMap.tscn"

var TestLevel = "res://Scenes/Levels/TestLevel.tscn"

func _ready():
	pass


func _on_LoadMap_btn_pressed():
	get_tree().change_scene(LoadMap)
	pass # Replace with function body.


func _on_Test_btn_pressed():
	get_tree().change_scene(TestLevel)
	pass # Replace with function body.
