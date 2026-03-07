extends Node

func _ready() -> void:
	if not GameState.load_save():
		ChapterState.set_step(ChapterState.C1Step.NOT_STARTED)
	get_tree().change_scene_to_file.call_deferred("res://scenes/world/village_slice_root.tscn")
