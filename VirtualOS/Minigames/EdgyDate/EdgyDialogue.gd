extends Node

signal closed()

onready var _edgy_text = $Control/Panel/Label
onready var _option_1 = $Control/Panel/VBoxContainer/Option1
onready var _option_2 = $Control/Panel/VBoxContainer/Option2
onready var _option_3 = $Control/Panel/VBoxContainer/Option3
var _current_dialog_index = 0

var dialogues = [
	{# number 0
		"edgy_text": "what do you want?...\nto download another browser?",
		"option1":{
			"text": "No, i’m here to see you",
			"goto": "1"
			},
		"option2":{
			"text": "It's not my fault you suck",
			"goto": "fail"
			},
		"option3":{
			"text": "wait? there are other\nbrowsers?",
			"goto": "2"
			},
	},
	{ # number 1
		"edgy_text": "oh really? and what do you need?",
		"option1":{
			"text": "Nothing! I just want to play with you",
			"goto": "3"
			},
		"option2":{
			"text": "We must delete Paul’s internet history",
			"goto": "2"
			},
		"option3":{
			"text": "",
			"goto": ""
			},
	},
	{ # number 2
		"edgy_text": "I knew it! you need something!\nyou’re not here to play with me!",
		"option1":{
			"text": "Just kidding! I’m here to play with you!!",
			"goto": "3"
			},
		"option2":{
			"text": "Oh i’m sorry... you must be feeling very lonely",
			"goto": "4"
			},
		"option3":{
			"text": "",
			"goto": ""
			},
	},
	{ # number 3
		"edgy_text": "Wow, really!?!? it never happened!\nYAYYYYYY!!!\nWhat do you want to do??",
		"option1":{
			"text": "I don’t know...What do you want do?",
			"goto": "5"
			},
		"option2":{
			"text": "Let’s watch Paul’s internet history!",
			"goto": "win"
			},
		"option3":{
			"text": "",
			"goto": ""
			},
	},
	{ # number 4
		"edgy_text": "Yes i am.\nPaul is gone and he never played with me anyway.\nWould you play with me??",
		"option1":{
			"text": "Yes! let’s play!",
			"goto": "3"
			},
		"option2":{
			"text": "There’s no time to waste! Paul is in danger!! ",
			"goto": "6"
			},
		"option3":{
			"text": "",
			"goto": ""
			},
	},
	{ # number 5
		"edgy_text": "I don’t know...i never played before...\nMaybe we can see Paul’s internet history\nHe must have visited fun websites!",
		"option1":{
			"text": "seems nice! lets see!",
			"goto": "win"
			},
		"option2":{
			"text": "What if we delete it instead?",
			"goto": "pre_win"
			},
		"option3":{
			"text": "",
			"goto": ""
			},
	},
	]

func _ready():
	show_dialogue(0)

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
		"pre_win":
			pre_win()
		_:
			show_dialogue(int(goto))

func fail():
	VirtualOS.reboot()

func win():
	pass
	# TODO win the game!!!

func pre_win():
	pass


func show_dialogue(dialogue_index: int):
	var dial = dialogues[dialogue_index]
	_current_dialog_index = dialogue_index
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
