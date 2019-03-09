# Classe che gestisce lo stato dell' OS.
extends CanvasLayer

export(PackedScene) var boot_scene
export(PackedScene) var OS_scene


func _ready():
	# FIXME, we want to be able to be told to boot up!
	load_boot_screen()


func load_boot_screen():
	var boot = boot_scene.instance()
	# better to connect to signals BEFORE we put the scene in the tree
	boot.connect("done", self, "_on_boot_done")
	add_child(boot)


func _on_boot_done():
	var os = OS_scene.instance()
	#TODO connect to signals ...??
	for c in get_children():
		remove_child(c)
		c.queue_free()
	add_child(os)