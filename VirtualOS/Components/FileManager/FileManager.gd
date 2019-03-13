extends App

export(PackedScene) var file_displayer

var current_directory = ""
var file_map = {}

func open_file(file):
	popup_centered()
	change_directory(str(VirtualOS.filesystem.get_path_to(file)))
#	get_


func _on_file_pressed(file):
	if file_map[file].extension == "folder":
		change_directory( current_directory + "/" + file_map[file].name )
	else:
		VirtualOS.open_file( current_directory + "/" + file_map[file].name)


func change_directory(to):
	current_directory = to
	var current_files = $GridContainer.get_children()
	for f in current_files:
		$GridContainer.remove_child(f)
		f.queue_free()
		file_map.erase(f)
	var files = VirtualOS.filesystem.get_files_in_path(current_directory)
	for f in files:
		var displayer = file_displayer.instance()
		displayer.display_file(VirtualOS.get_filesystem_icon(f.extension), f.name)
		file_map[displayer] = f
		$GridContainer.add_child(displayer)
		displayer.connect("clicked", self, "_on_file_pressed", [displayer])


func _on_FileManager_popup_hide():
	emit_signal("closed")
	pass # Replace with function body.
