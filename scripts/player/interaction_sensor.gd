extends Area2D

## Attach as a child of Nico. Detects nearby interactables and notifies
## the player controller so a prompt can be shown.

signal interactable_focused(node: Node)
signal interactable_lost(node: Node)

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(area: Area2D) -> void:
	var parent := area.get_parent()
	if parent.has_method("interact"):
		interactable_focused.emit(parent)

func _on_area_exited(area: Area2D) -> void:
	var parent := area.get_parent()
	if parent.has_method("interact"):
		interactable_lost.emit(parent)
