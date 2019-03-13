extends TextureRect

signal clicked()


func _on_TextureButton_pressed():
	emit_signal("clicked")
	pass # Replace with function body.


func display_file(file_icon, file_name):
	$Label.text = file_name
	texture = file_icon