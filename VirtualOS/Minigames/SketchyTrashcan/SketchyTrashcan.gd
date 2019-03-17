extends Control

signal done

export(Array, String, MULTILINE) var clippy_text
export(String, MULTILINE) var win_text
export(String, MULTILINE) var start_text
export(String, MULTILINE) var wrong_file_deleted
export(String, MULTILINE) var look_for_edgy

var file_displayer = preload("res://VirtualOS/Minigames/SketchyTrashcan/Regular.tscn")

onready var trashcan = $Trashcan
onready var clippy = VirtualOS.get_clippy()
onready var mistakes_count = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	if GameStage.current_game_state == GameStage.game_stages.TRASHCAN:
		hint_clippy_intro()
		trashcan.connect("player_win", self, "_on_player_win")
		trashcan.connect("player_mistake", self, "_on_player_mistake")
	_spawn_folders()


func _on_player_win():
	clippy.change_text(look_for_edgy)
	GameStage.current_game_state = GameStage.game_stages.EDGY
	emit_signal("done")
	print("WIN!!!!!")


func _on_player_mistake():
	print("MISTAKEEEEE!!!")
	_on_Trashcan_player_mistake()

func _spawn_folders():
	var idx = 0
	for f in VirtualOS.filesystem.get_children():
		if f.extension == "trashcan":
			continue # do not spawn, we already have it
		var displayer = file_displayer.instance()
		displayer.set_name_type_file(f.name, VirtualOS.get_filesystem_icon(f.extension))
		add_child(displayer)
		if f.name == "porn_folder":
			trashcan.set_goal(displayer)
		displayer.global_position = $StartPositions.get_child(idx).global_position
		displayer.connect("started_dragging", trashcan, "_on_Folder_started_dragging")
		displayer.connect("stopped_dragging", trashcan, "_on_Folder_stopped_dragging")
		idx += 1


############### clippy stuff ###############
# Every function offered by the clippy singleton will need a timer or a queue on the clippy singleton to avoid spam
func hint_clippy_intro():
	clippy.change_text(start_text)

func _on_Trashcan_player_mistake():
	if not GameStage.current_game_state == GameStage.game_stages.TRASHCAN:
		return
	mistakes_count+=1
	if mistakes_count < clippy_text.size():
		if clippy_text[mistakes_count]:
			clippy.change_text(clippy_text[mistakes_count])

func _on_Trashcan_wrong_file_deleted():
	if not GameStage.current_game_state == GameStage.game_stages.TRASHCAN:
		return
	clippy.change_text(wrong_file_deleted)