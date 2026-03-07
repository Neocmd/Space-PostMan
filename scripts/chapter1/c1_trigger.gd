extends Area2D

## Generic trigger that fires a C1 event when the player enters or interacts.
## Place in TriggersRoot. Set required_step and required_flags to gate it.

@export var event_id: StringName = &""
@export var one_shot: bool = true
@export var required_step: int = -1
@export var required_flags: Array[String] = []
## Per FragmentCollected: imposta l'id del frammento (es. "fragment_2")
@export var fragment_id: String = ""

var _fired := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		_try_fire()

## Call this from an interactable node to fire on explicit interaction.
func interact() -> void:
	_try_fire()

func _try_fire() -> void:
	if one_shot and _fired:
		return
	if not _can_fire():
		return
	_fired = true
	var ctrl := get_tree().get_first_node_in_group("c1_controller")
	if ctrl:
		var payload := {}
		if fragment_id != "":
			payload = {"fragment_id": fragment_id}
		ctrl.on_event(event_id, payload)

func _can_fire() -> bool:
	if required_step >= 0 and ChapterState.get_step() != required_step:
		return false
	for flag in required_flags:
		if not ChapterState.get_flag(flag):
			return false
	return true

func reset() -> void:
	_fired = false
