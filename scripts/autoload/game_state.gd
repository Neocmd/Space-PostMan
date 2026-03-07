extends Node

const SAVE_PATH := "user://save_slot_0.json"

func save() -> void:
	var data := {
		"current_chapter": "C1",
		"c1_step": ChapterState.c1_step,
		"c1_flags": ChapterState.c1_flags.duplicate(),
	}
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		push_error("GameState: cannot write save file")
		return
	file.store_string(JSON.stringify(data, "\t"))
	file.close()

func load_save() -> bool:
	if not FileAccess.file_exists(SAVE_PATH):
		return false
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		return false
	var text := file.get_as_text()
	file.close()
	var json := JSON.new()
	if json.parse(text) != OK:
		push_error("GameState: invalid save JSON")
		return false
	ChapterState.from_dict(json.data)
	return true

func delete_save() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(SAVE_PATH)
