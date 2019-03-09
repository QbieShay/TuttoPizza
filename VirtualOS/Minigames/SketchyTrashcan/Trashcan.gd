extends Sprite

func _ready():
	self.father_node = __get_father_node()
	self.bounds = __get_bounds()

func is_able_to_move():
	pass

func flee_from_threat(delta):
	pass

func __get_father_node():
	return get_node("../")

func __get_bounds():
	return __get_father_node().get_rect()

func __is_still_fleeing():
	pass

func _callback_folder_enter_zone():
	if not __is_still_fleeing():
		pass