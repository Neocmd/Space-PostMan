extends Control

## Recipient deduction UI.
## Shows two choices: Rosa Ferri and Beppe Ferri.
## Wrong answer shows a hint; correct answer fires RecipientConfirmed.

func _ready() -> void:
	$Panel/VBox/BeppeButton.pressed.connect(_on_beppe_pressed)
	$Panel/VBox/RosaButton.pressed.connect(_on_rosa_pressed)
	ChapterState.step_changed.connect(_on_step_changed)
	hide()

func _on_step_changed(_old: int, new_step: int) -> void:
	if new_step == ChapterState.C1Step.RECIPIENT_PHASE:
		open()

func open() -> void:
	show()
	var player := get_tree().get_first_node_in_group("player")
	if player and player.has_method("disable_movement"):
		player.disable_movement()

func _on_beppe_pressed() -> void:
	_close()
	var ctrl := get_tree().get_first_node_in_group("c1_controller")
	if ctrl:
		ctrl.on_event(&"RecipientConfirmed")

func _on_rosa_pressed() -> void:
	# Wrong answer: show hint, do not close
	var hint := LocalizationDb.get_ui("C1_HINT_002")
	var hint_label := get_node_or_null("HintLabel")
	if hint_label:
		hint_label.text = hint
		hint_label.show()

func _close() -> void:
	hide()
	var player := get_tree().get_first_node_in_group("player")
	if player and player.has_method("enable_movement"):
		player.enable_movement()
