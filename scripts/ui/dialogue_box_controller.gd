extends Control

@onready var _speaker: Label = $Panel/VBox/Speaker
@onready var _text: Label = $Panel/VBox/Text
@onready var _next: Button = $Panel/VBox/Next

func _ready() -> void:
	DialogueManager.register_box(self)
	_next.pressed.connect(DialogueManager.advance)
	hide()

func show_line(speaker: String, text: String) -> void:
	_speaker.text = speaker
	_text.text = text
	show()

func hide_box() -> void:
	hide()
