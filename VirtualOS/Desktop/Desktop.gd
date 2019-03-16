extends Control



func _ready():
	$Folders.add_child(preload("res://VirtualOS/Minigames/SketchyTrashcan/SketchyTrashcan.tscn").instance())

