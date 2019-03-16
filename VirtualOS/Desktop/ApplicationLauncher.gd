extends CanvasLayer


func _ready():
	VirtualOS.app_layer = self
	$ColorRect.visible = false


func open_program(program):
	var overlay = $ColorRect
	if overlay.get_child_count() == 0:
		overlay.visible = true
	overlay.add_child(program)


func close_program(program):
	var overlay = $ColorRect
	overlay.remove_child(program)
	if overlay.get_child_count() == 0:
		overlay.visible = false


func make_exclusive(program):
	var overlay = $ColorRect
	for c in overlay.get_children():
		if c != program:
			close_program(c)