extends Area2D

## One collectible star fragment. Set fragment_id to "fragment_2", "fragment_3",
## or "fragment_4" in the editor (fragment_1 is consumed by FirstStarInspect).

@export var fragment_id: String = "fragment_2"

var _collected := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	ChapterState.flag_changed.connect(_on_flag_changed)
	_sync_visibility()

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player") and not _collected:
		_collect()

func _collect() -> void:
	_collected = true
	hide()
	var ctrl := get_tree().get_first_node_in_group("c1_controller")
	if ctrl:
		ctrl.on_event(&"FragmentCollected", {"fragment_id": fragment_id})

func _on_flag_changed(flag_name: String, value: bool) -> void:
	if flag_name == fragment_id + "_collected" and value:
		_collected = true
		hide()

func _sync_visibility() -> void:
	_collected = ChapterState.get_flag(fragment_id + "_collected")
	visible = (not _collected
		and ChapterState.get_step() >= ChapterState.C1Step.FRAGMENTS_HUNT)
