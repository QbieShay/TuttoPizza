extends App


func _on_WindowDialog_popup_hide():
	emit_signal("closed")

func open_file(_file):
	popup_centered()