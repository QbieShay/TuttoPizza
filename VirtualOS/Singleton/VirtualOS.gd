extends Node


var app_layer = null
var filesystem_scene = preload("res://VirtualOS/Singleton/FileSystem.tscn")
var filesystem = null

var extension_application = {
	"jpg": preload("res://VirtualOS/Components/ImageViewer/ImageViewer.tscn"),
	}

var opened_apps = []

func _ready():
	filesystem = filesystem_scene.instance()

func open_file(path):
	var file = filesystem.get_file(path)
	var program = extension_application[file.extension].instance()
	opened_apps.append(program)
	app_layer.add_child(program)
	program.connect("closed", self, "_on_program_closed")
	program.open_file(file)


func _on_program_closed(program):
	app_layer.remove_child(program)
	opened_apps.erase(program)
	program.queue_free()
