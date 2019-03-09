#This scene is the 3D desk.
extends Spatial

export(PackedScene) var virtual_os
export(NodePath) var screen_path

var _virtual_screen

func _ready():
	var osie = virtual_os.instance()
	$Viewport.add_child(osie)
	_virtual_screen = get_node(screen_path)
	_virtual_screen.link_to_viewport($Viewport)

func _process(delta):
	pass

func _input(event):
	if event.get("position") != null:
		event.position = _virtual_screen.transform_in_screen_coordinate(event.position) * $Viewport.size
	$Viewport.input(event)

