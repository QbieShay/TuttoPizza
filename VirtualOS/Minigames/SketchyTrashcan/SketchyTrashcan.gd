extends Control

export(Array, String, MULTILINE) var clippy_text
export(String, MULTILINE) var win_text
export(String, MULTILINE) var start_text
export(String, MULTILINE) var wrong_file_deleted

onready var trashcan = $Trashcan
onready var clippy = $Clippy
onready var mistakes_count = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	hint_clippy_intro()


############### clippy stuff ###############
# Every function offered by the clippy singleton will need a timer or a queue on the clippy singleton to avoid spam
func hint_clippy_intro():
	clippy.change_text(start_text)

func _on_Trashcan_player_mistake():
	mistakes_count+=1
	if mistakes_count < clippy_text.size():
		if clippy_text[mistakes_count]:
			clippy.change_text(clippy_text[mistakes_count])

func _on_Trashcan_wrong_file_deleted():
	clippy.change_text(wrong_file_deleted)