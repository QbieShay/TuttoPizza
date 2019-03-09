extends Node

export(String) var intro_scene

func _show_intro():
	get_tree().change_scene(intro_scene)
