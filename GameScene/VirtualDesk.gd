#This scene is the 3D desk.
extends Spatial

export(String) var virtual_os

func _ready():
	#FIXME: make a proper 3D scene with input and all.
	get_tree().change_scene(virtual_os)