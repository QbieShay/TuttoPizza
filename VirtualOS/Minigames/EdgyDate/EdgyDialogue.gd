extends Node

signal closed()

onready var _edgy_text = $Control/Panel/Label
onready var _option_1 = $Control/Panel/VBoxContainer/Option1
onready var _option_2 = $Control/Panel/VBoxContainer/Option2
onready var _option_3 = $Control/Panel/VBoxContainer/Option3
var _current_dialog_index = 0

export(Texture) var edgy_normal
export(Texture) var edgy_bugged
export(Texture) var edgy_upset
export(Texture) var edgy_giggly

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
			"goto": "pre_win",
			"additional": 0
			},
		"option3":{
			"text": "",
			"goto": ""
			},
	},
	{ # number 6
		"edgy_text": "What!? Oh no!!\nWhat’s happening??",
		"option1":{
			"text": "The government is chasing him!",
			"goto": "7"
			},
		"option2":{
			"text": "He discovered something ...",
			"goto": "7"
			},
		"option3":{
			"text": "",
			"goto": ""
			},
	},
	{ # number 7
		"edgy_text": "What?!\nLet’s go through his internet history!\nLet’s see what it is!!",
		"option1":{
			"text": "No! We must delete it, it's too dangerous!",
			"goto": "pre_win",
			"additional": 1
			},
		"option2":{
			"text": "Uhm .. you don't really want to see that ...",
			"goto": "pre_win",
			"additional": 2
			},
		"option3":{
			"text": "",
			"goto": ""
			},
	},
	]

var additional_dialogues = [
	"What?? don’t be silly!\n Let’s check it!! :-D",
	"What? but i wanna see it!:-(\ncmon... just a quick peek",
	"I’m a grown up browser!\nI can handle it!",
]

var end_dialogues = [
	"*Opening internet history ..*",
	"Let's see .. uhm",
	"...",
	"That is bad",
	"...",
	"Uh, no good!",
	"Oh my .. that is disgusting!!",
	"Where does that even come from?!",
	"I never thought humans can do that",
	"... interesting",
	"Wait, is that me?!",
	"AAAARGH I NEED TO DESTROY THIS!",
]

func _ready():
	VirtualOS.clippy.close()
	show_dialogue(0)
	$Control/EdgySolo.visible = false
	VirtualOS.open_program_exclusive(self)

func open_file(_file):
	pass

func _compute_next(option: String):
	var metadata = dialogues[_current_dialog_index][option]
	var goto = metadata["goto"]
	match goto:
		"fail":
			fail()
		"win":
			win()
		"pre_win":
			pre_win(int(metadata["additional"]))
		_:
			show_dialogue(int(goto))

func fail():
	VirtualOS.reboot()

func win():
	$Control/Panel.visible = false
	$Control/EdgySolo.visible = true
	var face = 0
	for d in end_dialogues:
		$Control/EdgySolo/AnimationPlayer.play("show_text")
		$Control/EdgySolo/CenterContainer/Label.text = d
		yield($Control/EdgySolo/AnimationPlayer, "animation_finished")
		face += 1
		_change_face(face)
	$EndAnimation.play("end")
	yield($EndAnimation, "animation_finished")
	VirtualOS.win()

func pre_win(idx):
	$Control/Panel.visible = false
	$Control/EdgySolo.visible = true
	$Control/EdgySolo/CenterContainer/Label.text = additional_dialogues[idx]
	$Control/EdgySolo/AnimationPlayer.play("show_text")
	yield($Control/EdgySolo/AnimationPlayer, "animation_finished")
	win()


func show_dialogue(dialogue_index: int):
	var dial = dialogues[dialogue_index]
	_current_dialog_index = dialogue_index
	_edgy_text.text = dial["edgy_text"]
	_option_1.text = "> " + dial["option1"]["text"]
	_option_2.text = "> " + dial["option2"]["text"]
	_option_3.text = "> " + dial["option3"]["text"]
	$AnimationPlayer.play("show_next_dialog")


func _on_Option1_pressed():
	_compute_next("option1")


func _on_Option2_pressed():
	_compute_next("option2")


func _on_Option3_pressed():
	_compute_next("option3")


func _change_face(idx):
	match idx:
		5:
			$Control/Edgy.texture = edgy_bugged
		9:
			$Control/Edgy.texture = edgy_giggly
		10:
			$Control/Edgy.texture = edgy_upset