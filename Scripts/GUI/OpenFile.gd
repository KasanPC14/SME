extends Control


var LoadedMap = "res://Scenes/Scenes/LoadedLevel.tscn"

func _ready():
	pass


func _on_Button_pressed():
	$FileDialog.popup()
	pass # Replace with function body.


func _on_FileDialog_file_selected(path):
	get_parent().get_node("Level/Map").mapPath = path
	get_parent().get_node("Level/Map")._loadMap()
	queue_free()
	
	pass # Replace with function body.


