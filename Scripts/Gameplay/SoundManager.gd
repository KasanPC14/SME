extends Node


func get(url):
	return get_node(url)
	
func play(url):
	get_node(url).play()
