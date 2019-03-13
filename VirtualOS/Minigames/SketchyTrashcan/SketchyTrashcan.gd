extends Control

export(int) var first_advice_mistake_count = 2
export(int) var second_advice_mistake_count = 5
export(int) var solution_advice_mistake_count = 10

onready var trashcan = $Trashcan
onready var mistakes_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	hint_clippy_intro()


############### clippy stuff ###############
# Every function offered by the clippy singleton will need a timer or a queue on the clippy singleton to avoid spam
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

func _on_Trashcan_player_mistake():
	mistakes_count+=1
	if mistakes_count >= solution_advice_mistake_count:
		hint_clippy_solution()
	elif mistakes_count >= second_advice_mistake_count:
		hint_clippy_second_advice()
	elif mistakes_count >= first_advice_mistake_count:
		hint_clippy_first_advice()

func _on_Trashcan_wrong_file_deleted():
	hint_clippy_wrong_file_deleted()
