extends App

func open_file(file):
	_show_image(file.title, file.image)
	popup_centered()

func _show_image(image_title, image):
	$TextureRect.texture = image
	$Label.text = image_title

func _on_ImageViewer_popup_hide():
	emit_signal("closed")
	pass # Replace with function body.
