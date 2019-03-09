extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	hint_clippy_intro()


# clippy stuff
func hint_clippy_intro():
	pass
func hint_clippy_wrong_file_deleted():
	pass
func hint_clippy_first_advice():
	pass
func hint_clippy_second_advice():
	pass
func hint_clippy_solution():
	pass


func get_scene_bounds():
	return self.get_rect()