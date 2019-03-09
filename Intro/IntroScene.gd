extends Node

export(String) var game_scene


func _show_game():
	get_tree().change_scene(game_scene)


func _input(event):
	if event is InputEventKey or event is InputEventMouseButton:
		_show_game()