extends App

var yes_pressed = false

func _ready():
	pass

func open_file(_file):
	if GameStage.app_states.has(app_name):
		$Thanks.show()
	else:
		$GiveSoul.show()
	connect("popup_hide", self, "_on_trying_to_hide")
	popup_centered()

func _on_trying_to_hide():
	if yes_pressed:
		emit_signal("closed")
	else:
		show()

func _on_Yay_pressed():
	emit_signal("closed")


func _on_Yes_pressed():
	# TODO play animation?
	yes_pressed = true
	GameStage.app_states[app_name] = yes_pressed
	$GiveSoul.hide()
	$Thanks.show()


func _process(_delta):
	if not visible:
		show()