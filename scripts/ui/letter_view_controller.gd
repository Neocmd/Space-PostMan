extends Control

signal letter_closed(letter_id: String)

@onready var _title: Label = $Panel/VBox/Title
@onready var _body: Label = $Panel/VBox/Body
@onready var _close: Button = $Panel/VBox/Close

var _current_id: String = ""

func _ready() -> void:
	add_to_group("letter_view")
	_close.pressed.connect(_on_close)
	hide()

func show_letter(letter_id: String) -> void:
	var letter := LocalizationDb.get_letter(letter_id)
	if letter.is_empty():
		push_warning("LetterView: '%s' not found" % letter_id)
		return
	_current_id = letter_id
	_title.text = letter.get("title", "")
	_body.text = letter.get("body", "")
	show()

func show_fragment(text: String) -> void:
	_current_id = ""
	_title.text = ""
	_body.text = text
	show()

func _on_close() -> void:
	var lid := _current_id
	_current_id = ""
	hide()
	letter_closed.emit(lid)
