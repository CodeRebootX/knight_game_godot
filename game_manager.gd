extends Node
	
func restart_game():
	if get_tree():
		get_tree().change_scene_to_file("res://main.tscn")
	else:
		print("error al cargar escena nuevamente")
