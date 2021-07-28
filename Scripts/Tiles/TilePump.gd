extends Node2D

var offset = Vector2(0,-10)		
var time = 0.1

var enabled = true

func _ready():
	get_parent().get_node("Area").connect("body_entered",self,"_bodyEntered")
	get_node("Tween").connect("tween_all_completed",self,"_phase2")
	pass

func _bodyEntered(body):
	var tween1 = get_node("Tween")
	var tween2 = get_node("Tween2")
	var p = get_parent()
	
	if body.name.begins_with("Player") and !tween1.is_active() and !tween2.is_active():
		
		if !body.onGround and enabled:
			get_parent().get_node("Sound").play()
			##First
			tween1.interpolate_property(p, "position",
			Vector2(p.position.x,p.position.y),
			Vector2(p.position.x,p.position.y) + offset, time,
			Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)
		
			tween1.start()
	pass

func _phase2():
	var tween2 = get_node("Tween2")
	var p = get_parent()
		
	tween2.interpolate_property(get_parent(),"position",
	Vector2(p.position.x,p.position.y),
	Vector2(p.position.x,p.position.y) - offset, time,
	Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)
		
	tween2.start()
	pass
