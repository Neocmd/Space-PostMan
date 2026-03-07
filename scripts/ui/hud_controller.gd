extends Control

@onready var _obj_label: Label = $ObjectiveBanner/Label

func _ready() -> void:
	var ctrl := get_tree().get_first_node_in_group("c1_controller")
	if ctrl:
		ctrl.objective_updated.connect(_on_objective_updated)

func _on_objective_updated(text: String) -> void:
	_obj_label.text = text
	$ObjectiveBanner.visible = text != ""
