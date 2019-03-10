extends Sprite

onready var timer = $FleeCooldown
onready var ray_down = $RayDown
onready var ray_left = $RayLeft
onready var ray_right = $RayRight
onready var ray_up = $RayUp

func _ready():
	self.father_node = __get_father_node()
	self.bounds = __get_bounds()

func flee_from_threat():
	# flee stuff...

	__start_flee_cooldown()

func __get_father_node():
	return get_node("../")

func __get_bounds():
	return __get_father_node().get_rect()

func _callback_folder_enter_zone():
	if __can_flee():
		flee_from_threat()



func _on_FleeCooldown_timeout():
	# let the bin flee again
	__enable_flee()

func __enable_flee():
	self.can_flee = true

func __start_flee_cooldown():
	self.can_flee = false
	timer.start()

func __can_flee():
	return self.can_flee