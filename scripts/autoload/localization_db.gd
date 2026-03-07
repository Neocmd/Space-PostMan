extends Node

var _ui: Dictionary = {}
var _dialogue: Dictionary = {}
var _letters: Dictionary = {}

func _ready() -> void:
	_load_csv("res://data/localization/ui.csv", _ui)
	_load_csv("res://data/localization/dialogue.csv", _dialogue)
	_load_letters("res://data/letters/letters_it.json")

func _load_csv(path: String, target: Dictionary) -> void:
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("LocalizationDb: cannot open %s" % path)
		return
	var headers := file.get_csv_line()
	while not file.eof_reached():
		var row := file.get_csv_line()
		if row.size() < headers.size():
			continue
		var entry: Dictionary = {}
		for i in headers.size():
			entry[headers[i]] = row[i]
		var sid: String = entry.get("string_id", "").strip_edges()
		if sid != "":
			target[sid] = entry
	file.close()

func _load_letters(path: String) -> void:
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("LocalizationDb: cannot open %s" % path)
		return
	var text := file.get_as_text()
	file.close()
	var json := JSON.new()
	if json.parse(text) != OK:
		push_error("LocalizationDb: invalid JSON in %s" % path)
		return
	_letters = (json.data as Dictionary).get("letters", {})

func get_ui(string_id: String) -> String:
	return _ui.get(string_id, {}).get("text_it", string_id)

func get_dialogue(string_id: String) -> Dictionary:
	return _dialogue.get(string_id, {})

func get_letter(letter_id: String) -> Dictionary:
	return _letters.get(letter_id, {})

func get_scene_lines(scene_id: String) -> Array[Dictionary]:
	var result: Array[Dictionary] = []
	for entry in _dialogue.values():
		if entry.get("scene", "") == scene_id:
			result.append(entry)
	result.sort_custom(func(a, b): return a["string_id"] < b["string_id"])
	return result
