extends Node


var app_layer = null
var clippy = null
var filesystem = null
var filesystem_icon_map
var screen

var extension_application = {
	"jpg": preload("res://VirtualOS/Components/ImageViewer/ImageViewer.tscn"),
	"folder": preload("res://VirtualOS/Components/FileManager/FileManager.tscn"),
	"pepo": preload("res://VirtualOS/Components/SoulStealer/Pepo.tscn"),
	"edgy": preload("res://VirtualOS/Minigames/EdgyDate/EdgyDialogue.tscn"),
	"trashcan": preload("res://VirtualOS/Components/TrashCanApp/ThrashCanApp.tscn"),
	}


func _ready():
	filesystem = preload("res://VirtualOS/Singleton/FileSystem.tscn").instance()
	filesystem_icon_map = preload("res://VirtualOS/Singleton/FileTypes/ExtensionIcons.tscn").instance()

func open_file(path):
	var file = filesystem.get_file(path)
	var program = extension_application[file.extension].instance()
	app_layer.open_program(program)
	program.connect("closed", self, "_on_program_closed", [program])
	program.open_file(file)

func open_program_exclusive(program):
	app_layer.make_exclusive(program)

func get_file(path):
	return filesystem.get_file(path)


func get_filesystem_icon(extension):
	return filesystem_icon_map.get_node(extension).filesystem_icon


func _on_program_closed(program):
	app_layer.close_program(program)
	program.queue_free()


func get_clippy():
	return clippy


func reboot():
	screen.reboot()