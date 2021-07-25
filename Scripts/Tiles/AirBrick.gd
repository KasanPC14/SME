extends KinematicBody2D

var offset = Vector2(0,-10)
var time = 0.1

func _ready():
	pass

func _physics_process(delta):
	#print(get_parent().get_parent().get_parent().get_parent().name)
	get_node("AnimatedSprite").animation = get_tree().root.get_child(1).WorldType
	
	pass

func _on_Alt_body_entered(body):
	var tween1 = get_node("Tweens/Tween")
	var tween2 = get_node("Tweens/Tween2")
	
	if body.name.begins_with("Player") and !tween1.is_active() and !tween2.is_active():
		
		if !body.onGround:
			$Sound.play()
			##First
			tween1.interpolate_property(self,"position",
			Vector2(position.x,position.y),
			Vector2(position.x,position.y) + offset, time,
			Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)
		
			tween1.start()
		
	
		
		
		
	pass # Replace with function body.


func _on_Tween_tween_all_completed():
	var tween2 = get_node("Tweens/Tween2")
		
	tween2.interpolate_property(self,"position",
	Vector2(position.x,position.y),
	Vector2(position.x,position.y) - offset, time,
	Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)
		
	tween2.start()
	pass
	# Replace with function body.
