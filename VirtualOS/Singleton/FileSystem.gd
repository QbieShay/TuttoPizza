extends Node

func get_files_in_path(path):
	return get_node(path).get_children()

func get_file(path):
	return get_node(path)
