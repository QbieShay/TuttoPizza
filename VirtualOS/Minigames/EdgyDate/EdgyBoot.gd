extends App

var edgy_scene = preload("res://VirtualOS/Minigames/EdgyDate/EdgyDialogue.tscn")

func open_file(_file):
	popup_centered()
	if GameStage.current_game_state != GameStage.game_stages.EDGY:
		$Unable.visible = true
	else:
		$EdgyBar.visible = true
		yield(get_tree().create_timer(2.0), "timeout")
		_show_edgy()


func _close():
	emit_signal("closed")


func _show_edgy():
	VirtualOS.app_layer.close_program(self)
	VirtualOS.app_layer.open_program(edgy_scene.instance())