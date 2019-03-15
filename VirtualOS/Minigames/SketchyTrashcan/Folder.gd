extends KinematicBody2D

export var pick_range = 30

var dragging = false
var inside = false
var delta_diff = null

signal started_dragging
signal stopped_dragging
func _process(delta):

	inside = __get_inside_status()

	var started_dragging = false
	if inside and Input.is_action_just_pressed("left_mouse"):
		dragging = true
		emit_signal("started_dragging")
	elif dragging and Input.is_action_just_released("left_mouse"):
		dragging = false
		emit_signal("stopped_dragging")

	delta_diff = get_local_mouse_position()

	if dragging:
		position = position + delta_diff

func __get_inside_status():
	var pos = get_local_mouse_position()
	return pos.x < pick_range and pos.x > -pick_range and pos.y < pick_range and pos.y > -pick_range
