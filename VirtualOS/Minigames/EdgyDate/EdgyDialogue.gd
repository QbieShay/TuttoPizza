extends Node

signal closed()

onready var _edgy_text = $Control/Panel/Label
onready var _option_1 = $Control/Panel/VBoxContainer/Option1
onready var _option_2 = $Control/Panel/VBoxContainer/Option2
onready var _option_3 = $Control/Panel/VBoxContainer/Option3
var _current_dialog_index = 0

var dialogues = [
	{
		"edgy_text": "YOU ONLY WANT ME FOR DOWNLOADING\nANOTHER BROWSER... AND THEN YOU'LL FORGET ME ...\nAGAIN!!!",
		"option1":{
			"text": "NO! I WILL NEVER DO THAT TO YOU!",
			"goto": "2"
			},
		"option2":{
			"text": "It's not my fault you suck",
			"goto": "fail"
			},
		"option3":{
			"text": "CAN YOU BOOT JUST ONCE ? .. PLEASE?",
			"goto": "3"
			},
	},
	]

func open_file(_file):
	VirtualOS.open_program_exclusive(self)
	show_dialogue(0)
	pass

func _compute_next(option: String):
	var goto = dialogues[_current_dialog_index][option]["goto"]
	match goto:
		"fail":
			fail()
		"win":
			win()
		_:
			show_dialogue(int(goto))

func fail():
	VirtualOS.reboot()

func win():
	pass
	# TODO win the game!!!


func show_dialogue(dialogue_index: int):
	var dial = dialogues[dialogue_index]
	_edgy_text.text = dial["edgy_text"]
	_option_1.text = dial["option1"]["text"]
	_option_2.text = dial["option2"]["text"]
	_option_3.text = dial["option3"]["text"]
	$AnimationPlayer.play("show_next_dialog")


func _on_Option1_pressed():
	_compute_next("option1")


func _on_Option2_pressed():
	_compute_next("option2")


func _on_Option3_pressed():
	_compute_next("option3")
