extends App

func open_file(file):
	$Title.text = file.name
	$Panel/RichTextLabel.text = file.text
	popup_centered()

func _on_WindowDialog_popup_hide():
	emit_signal("closed")
