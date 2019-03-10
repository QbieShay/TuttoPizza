# Boot screen of the game
# this can be a simple animation or an interactive scene
extends Control

# Emitted when we are done with the boot scene.
# Our computer will automatically instance the OS when this signal is fired.
signal done()


export(float) var short_pause_length = 0.1
export(float) var long_pause_length = 1.5


var _character_timer
var _pause_timer
var _current_dialogue_index = 0
var _current_character_index = 0


var dialogue = [
	"Hi Johnny, I'm Paul\n",
	"Please Johnny, delete my porn folder and my internet history\n",
	"My computer is possessed, be careful",
	".",
	".\n",
	"I’ve been watching some weird shit…",
	"I mean REALLY weird",
	".",
	".",
	".\n",
	"Thank you",
	]

func _ready():
	#FIXME: debugging purposes
	emit_signal("done")
	return
	$AnimationPlayer.connect("animation_finished", self, "_on_animation_done")
	#$AnimationPlayer.play("boot_animation")
	_character_timer = Timer.new()
	add_child(_character_timer)
	_character_timer.start(short_pause_length)
	_character_timer.connect("timeout", self, "_on_character_timer_timeout")
	_character_timer.one_shot = true
	_on_character_timer_timeout()
	_pause_timer = Timer.new()
	add_child(_pause_timer)
	_pause_timer.connect("timeout", self, "_on_pause_timer_timeout")
	_pause_timer.one_shot = true


func _on_animation_done(arg):
	emit_signal("done")


func _on_pause_timer_timeout():
	_current_dialogue_index += 1
	if _current_dialogue_index == dialogue.size():
		emit_signal("done")
		return
	_current_character_index = 0
	_on_character_timer_timeout()


func _on_character_timer_timeout():
	if _current_character_index == dialogue[_current_dialogue_index].length():
		# Long pause and move to next dialogue
		_character_timer.stop()
		_pause_timer.start(long_pause_length)
		pass
	else:
		$DialogueLabel.text += dialogue[_current_dialogue_index][_current_character_index]
		_current_character_index += 1
		_character_timer.start()