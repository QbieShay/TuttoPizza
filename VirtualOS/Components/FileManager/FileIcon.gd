extends TextureRect

signal clicked()


func _on_TextureButton_pressed():
	emit_signal("clicked")
	pass # Replace with function body.


func display_file(file_icon: Texture, file_name: String):
	$Label.text = file_name.replace("_", ".")
	texture = file_icon