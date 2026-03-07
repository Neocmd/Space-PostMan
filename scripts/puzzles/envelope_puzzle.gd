extends Control

## Envelope reassembly puzzle.
## Greybox: single "Ricomponi" button. Replace with drag-and-drop fragments later.

signal puzzle_completed
signal puzzle_cancelled

func _ready() -> void:
	$Panel/VBox/CompleteButton.pressed.connect(_on_complete_pressed)
	$Panel/VBox/CancelButton.pressed.connect(_on_cancel_pressed)
	ChapterState.step_changed.connect(_on_step_changed)
	hide()

func _on_step_changed(_old: int, new_step: int) -> void:
	if new_step == ChapterState.C1Step.ENVELOPE_READY:
		open_puzzle()

func open_puzzle() -> void:
	show()
	var player := get_tree().get_first_node_in_group("player")
	if player and player.has_method("disable_movement"):
		player.disable_movement()

func _on_complete_pressed() -> void:
	_close()
	puzzle_completed.emit()
	var ctrl := get_tree().get_first_node_in_group("c1_controller")
	if ctrl:
		ctrl.on_event(&"EnvelopeRebuilt")
	# Show letter after rebuild
	var letter_view := get_tree().get_first_node_in_group("letter_view")
	if letter_view and letter_view.has_method("show_letter"):
		letter_view.show_letter("C1_LTR_001")

func _on_cancel_pressed() -> void:
	_close()
	puzzle_cancelled.emit()

func _close() -> void:
	hide()
	var player := get_tree().get_first_node_in_group("player")
	if player and player.has_method("enable_movement"):
		player.enable_movement()
