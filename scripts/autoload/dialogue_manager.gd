extends Node

signal dialogue_started(scene_id: String)
signal dialogue_finished(scene_id: String)

var _box: Control = null
var _queue: Array[Dictionary] = []
var _current_scene_id: String = ""
var _on_finish: Callable

func register_box(box: Control) -> void:
	_box = box

func play_scene(scene_id: String, on_finish: Callable = Callable()) -> void:
	var lines := LocalizationDb.get_scene_lines(scene_id)
	_start(lines, scene_id, on_finish)

func play_lines(lines: Array[Dictionary], scene_id: String = "", on_finish: Callable = Callable()) -> void:
	_start(lines, scene_id, on_finish)

func _start(lines: Array[Dictionary], scene_id: String, on_finish: Callable) -> void:
	if lines.is_empty():
		if on_finish.is_valid():
			on_finish.call()
		return
	_queue = lines.duplicate()
	_current_scene_id = scene_id
	_on_finish = on_finish
	dialogue_started.emit(scene_id)
	_show_next()

func _show_next() -> void:
	if _queue.is_empty():
		_end()
		return
	var line: Dictionary = _queue.pop_front()
	if _box and _box.has_method("show_line"):
		_box.show_line(line.get("speaker", ""), line.get("text_it", ""))
	else:
		push_warning("DialogueManager: no box registered, skipping line")
		_end()

func advance() -> void:
	if _queue.is_empty():
		_end()
	else:
		_show_next()

func _end() -> void:
	var sid := _current_scene_id
	_current_scene_id = ""
	if _box and _box.has_method("hide_box"):
		_box.hide_box()
	dialogue_finished.emit(sid)
	if _on_finish.is_valid():
		_on_finish.call()
