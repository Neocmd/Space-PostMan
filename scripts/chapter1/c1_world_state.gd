extends Node

## Applies persistent world-state changes to the scene after each chapter event.
## Export the relevant scene nodes in the editor.

@export var bakery_lit_layer: Node2D = null
@export var bakery_dark_layer: Node2D = null
@export var ferry_shortcut: Node2D = null

func _ready() -> void:
	ChapterState.step_changed.connect(_on_step_changed)
	_apply_current()

func _apply_current() -> void:
	_set_bakery(ChapterState.get_flag("bakery_lit"))
	_set_ferry(ChapterState.get_flag("ferry_shortcut_unlocked"))

func _on_step_changed(_old: int, new_step: int) -> void:
	if new_step == ChapterState.C1Step.COMPLETE:
		_set_bakery(true)
		_set_ferry(true)

func _set_bakery(lit: bool) -> void:
	if bakery_lit_layer:
		bakery_lit_layer.visible = lit
	if bakery_dark_layer:
		bakery_dark_layer.visible = not lit

func _set_ferry(unlocked: bool) -> void:
	if ferry_shortcut:
		ferry_shortcut.visible = unlocked
