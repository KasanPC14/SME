extends Node2D

export (String) var node = "Map/Camera2D"

var Open = false

func _ready():
	var mapMaker = get_parent().get_node("Map")
	
	for i in get_child_count():
		get_child(i).connect("mouse_entered",mapMaker,"_on_gui_mouse_entered")
		get_child(i).connect("mouse_exited",mapMaker,"_on_gui_mouse_exited")
	pass
	
	_connectAllButtons()

func _physics_process(delta):
	var mapMaker = get_parent().get_node("Map")
	if $FileDialog.visible:
		mapMaker.onGui = true
	else:
		mapMaker.onGui = false
	
	if Input.is_action_just_pressed("M"):
		Open = !Open
		
	visible = Open
	mapMaker.onGui = Open
	
	position = get_parent().get_node(node).position
	#$FileDialog.visible = $FileDialog/FileDialog.visible

func _on_Load_btn_pressed():
	$FileDialog.mode = FileDialog.MODE_OPEN_FILE
	$FileDialog.popup()
	pass # Replace with function body.

func _connectAllButtons() -> void:
	var mapMaker = get_parent().get_node("Map")
	get_node("AirBrick_btn").connect("pressed",mapMaker,"_on_AirBrick")
	get_node("Brick_btn").connect("pressed",mapMaker,"_on_Brick")
	get_node("Block_btn").connect("pressed",mapMaker,"_on_Block")
	get_node("Coin_btn").connect("pressed",mapMaker,"_on_Coin")
	pass


func _on_Save_btn_pressed():
	$FileDialog.mode = FileDialog.MODE_SAVE_FILE
	$FileDialog.popup()
	
	pass # Replace with function body.


func _on_FileDialog_file_selected(path):
	if $FileDialog.mode == FileDialog.MODE_SAVE_FILE:
		_saveMap(path,$FileDialog.current_file)
		
	pass # Replace with function body.

func _saveMap(path,dir)->void:
	var mapMaker = get_parent().get_node("Map")
	var saveFile = File.new()
	saveFile.open(path, File.WRITE)
	saveFile.store_string(var2str(mapMaker.mapData))
	print("Created in " + path)
	saveFile.close()
	pass
