extends KinematicBody2D

signal player_win()

export var flee_range = 100
export var speed_travel = .5

onready var flee_cooldown = $FleeCooldown
onready var flee_interpolation = $FleeCooldown
onready var bin_range = $Collider
onready var can_flee = true
onready var is_moving = false
onready var path_checker = $PathChecker
onready var interpolator = $SpeedInterpolation
onready var current_point = -1
onready var flee_points = get_tree().get_nodes_in_group("trashcan_flee_points")
onready var look = $Look
onready var is_dragging = false
var _goal = null
var completed = false

signal player_mistake
signal wrong_file_deleted

func _ready():
	print("alive from place")
	randomize()

func _process(delta):
	if can_flee and not is_moving and __needs_to_flee():
		__flee_from_threat()



func set_goal(folder):
	_goal = folder

func __needs_to_flee():
	var pos = get_local_mouse_position()
	return is_dragging and pos.x < flee_range and pos.x > -flee_range and pos.y < flee_range and pos.y > -flee_range

func __pick_a_point_to_go():
	# get a random point from the array
	var cur_size = flee_points.size()
	var point = randi() % cur_size

	# address to avoid chosing the same point we are now
	if point == current_point:
		point = point-1 if point > 0 else point+1
	return point

func __flee_from_threat():
	if completed:
		return
	var point = __pick_a_point_to_go()

	# cast the ray to that point
	path_checker.enabled = true
	path_checker.cast_to = global_transform.xform_inv(flee_points[point].position)
	path_checker.force_raycast_update()

	# travel to destination, whether it's a folder or a point
	var destination = path_checker.get_collision_point() if path_checker.is_colliding() else flee_points[point].position

	# i save my destination length

	var dest_len = max(global_position.distance_to(destination) - bin_range.shape.radius, 0.0)

	__start_flee_cooldown()
	if dest_len < 10:
		return

	var new_dest = destination + (global_position - destination).normalized() * bin_range.shape.radius

	interpolator.interpolate_property(self, 'position', self.position, new_dest, speed_travel, Tween.TRANS_QUAD, Tween.EASE_OUT)
	interpolator.start()
	is_moving = true

	# set the current chosen point
	current_point = point

	path_checker.enabled = false


func __start_flee_cooldown():
	can_flee = false
	flee_cooldown.start()

func _on_FleeCooldown_timeout():
	__enable_flee()

func __enable_flee():
	can_flee = true

func _on_SpeedInterpolation_tween_completed(object, key):
	is_moving = false
	look.frame = 0
	look.stop()

func _on_SpeedInterpolation_tween_started(object, key):
	look.frame = 1
	look.play()


func _on_Folder_started_dragging():
	is_dragging = true

func _on_Folder_stopped_dragging():
	is_dragging = false


func _on_Area2D_body_entered(body):
	if body == self:
		return
	if is_dragging and not can_flee and not completed:
		if body != _goal:
			emit_signal("player_mistake")
		else:
			_goal.queue_free()
			var porn = VirtualOS.filesystem.get_node("porn_folder")
			VirtualOS.filesystem.remove_child(porn)
			porn.queue_free()
			_goal = null
			emit_signal("player_win")
			completed = true

