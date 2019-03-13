extends Spatial

export(NodePath) var top_left_corner_path
export(NodePath) var top_right_corner_path 
export(NodePath) var bottom_left_corner_path 
export(NodePath) var bottom_right_corner_path 

var _top_left_corner_coordinate
var _top_right_corner_coordinate
var _bottom_left_corner_coordinate
var _bottom_right_corner_coordinate

var _width = 1.0
var _height = 1.0
var _screen_plane = null


func _ready():
	_top_left_corner_coordinate = get_viewport().get_camera().unproject_position(get_node(top_left_corner_path).global_transform.origin)
	_top_right_corner_coordinate = get_viewport().get_camera().unproject_position(get_node(top_right_corner_path).global_transform.origin)
	_bottom_left_corner_coordinate = get_viewport().get_camera().unproject_position(get_node(bottom_left_corner_path).global_transform.origin)
	_bottom_right_corner_coordinate = get_viewport().get_camera().unproject_position(get_node(bottom_right_corner_path).global_transform.origin)

	# _screen_plane = Plane( _top_left_corner_coordinate, _top_right_corner_coordinate, _bottom_left_corner_coordinate)

	_width = _top_right_corner_coordinate.x - _top_left_corner_coordinate.x
	_height = _bottom_right_corner_coordinate.y - _top_right_corner_coordinate.y


func link_to_viewport(viewport):
	$MeshInstance.get_surface_material(0).albedo_texture = viewport.get_texture()
	$MeshInstance.get_surface_material(0).emission_texture = viewport.get_texture()


func transform_in_screen_coordinate(position):
	if _top_left_corner_coordinate == null:
		return -position
	var space = get_viewport().world.direct_space_state
	var cam = get_viewport().get_camera()
	var mouse_vec = cam.project_local_ray_normal(position)
	var intersect = space.intersect_ray(cam.global_transform.origin, mouse_vec*100.0) # position
#	if intersect.size() == 0:
#		return -position
	# var local_pos = $KinematicBody.xform(intersect["position"])
	var new_x = position.x - _top_left_corner_coordinate.x
	var new_y = position.y - _top_left_corner_coordinate.y
	var normalized_position = Vector2(new_x/_width, new_y/_height)
	return normalized_position