extends Control

var doubleclik_enabled = false

func _input(event):
	if not doubleclik_enabled:
		return
	if event is InputEventMouseButton and event.doubleclick:
		VirtualOS.open_file("trashcan")

func _on_Control_mouse_entered():
	doubleclik_enabled = true
	pass # Replace with function body.


func _on_Control_mouse_exited():
	doubleclik_enabled = false
	pass # Replace with function body.
