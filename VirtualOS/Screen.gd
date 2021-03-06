# Classe che gestisce lo stato dell' OS.
extends Node

export(PackedScene) var boot_scene
export(PackedScene) var OS_scene
export(PackedScene) var BSOD_scene
export(PackedScene) var win_scene


func _ready():
	# FIXME, we want to be able to be told to boot up!
	VirtualOS.screen = self
	VirtualOS.connect("win", self, "_on_os_win")
	load_boot_screen()

func load_boot_screen():
	var boot = boot_scene.instance()
	# better to connect to signals BEFORE we put the scene in the tree
	boot.connect("done", self, "_start_OS")
	add_child(boot)


func _start_OS():
	var os = OS_scene.instance()
	#TODO connect to signals ...??
	_clear_current_scene()
	add_child(os)

func _on_os_win():
	_clear_current_scene()
	var win = win_scene.instance()
	add_child(win)

func _clear_current_scene():
	for c in get_children():
		remove_child(c)
		c.queue_free()

func reboot():
	_clear_current_scene()
	var bsod = BSOD_scene.instance()
	bsod.connect("done", self, "_start_OS")
	add_child(bsod)