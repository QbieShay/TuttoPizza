extends Control

signal done()

func _ready():
	yield(get_tree().create_timer(5.0), "timeout")
	emit_signal("done")