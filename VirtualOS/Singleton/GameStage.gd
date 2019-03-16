extends Node

enum game_stages {
	TRASHCAN,
	EDGY,
	} 

var game_levels = {
	game_stages.TRASHCAN: preload("res://VirtualOS/Minigames/SketchyTrashcan/SketchyTrashcan.tscn"),
	game_stages.EDGY: "mah"
	}

var current_game_state = game_stages.TRASHCAN

var app_states = {}