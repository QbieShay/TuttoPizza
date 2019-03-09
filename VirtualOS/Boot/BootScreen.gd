# Boot screen of the game
# this can be a simple animation or an interactive scene
extends Control

# Emitted when we are done with the boot scene.
# Our computer will automatically instance the OS when this signal is fired.
signal done()

func _ready():
	$AnimationPlayer.connect("animation_finished", self, "_on_animation_done")
	$AnimationPlayer.play("boot_animation")

func _on_animation_done(arg):
	emit_signal("done")
