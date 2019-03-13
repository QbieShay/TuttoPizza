extends KinematicBody2D

onready var flee_cooldown = $FleeCooldown
onready var flee_interpolation = $FleeCooldown
onready var flee_range = $FleeCollider
onready var bin_range = $Collider
onready var can_flee = true
onready var is_moving = false
onready var path_checker = $PathChecker
onready var interpolator = $SpeedInterpolation
onready var current_point = -1
onready var flee_points = get_tree().get_nodes_in_group("trashcan_flee_points")

signal player_mistake
signal wrong_file_deleted

func _ready():
	randomize()

func _process(delta):
	if can_flee and not is_moving and __needs_to_flee():
		__flee_from_threat()

func __needs_to_flee():
	# stub for now
	return true

func __pick_a_point_to_go():
		# get a random point from the array
	var cur_size = flee_points.size()
	var point = randi() % cur_size

	# address to avoid chosing the same point we are now
	if point == current_point:
		print("same_point")
		point = point-1 if point > 0 else point+1
	return point

func __flee_from_threat():
	__start_flee_cooldown()

	var point = __pick_a_point_to_go()

	# cast the ray to that point
	path_checker.cast_to = flee_points[point].position
	path_checker.force_raycast_update()

	# travel to destination, whether it's a folder or a point
	var destination = path_checker.get_collision_point() if path_checker.is_colliding() else flee_points[point].position
	interpolator.interpolate_property(self, 'position', self.position, destination, 1.0, Tween.TRANS_QUAD, Tween.EASE_OUT)
	interpolator.start()
	is_moving = true

	# set the current chosen point
	current_point = point

	# notify of the player mistake
	emit_signal("player_mistake")

func __start_flee_cooldown():
	can_flee = false
	flee_cooldown.start()

func _on_FleeCooldown_timeout():
	__enable_flee()

func __enable_flee():
	can_flee = true

func _on_SpeedInterpolation_tween_completed(object, key):
	is_moving = false
