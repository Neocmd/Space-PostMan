extends Node2D

enum NpcType { ROSA, BEPPE, TILDE, VILLAGER }

@export var npc_type: NpcType = NpcType.VILLAGER

func _ready() -> void:
	ChapterState.step_changed.connect(_refresh)
	ChapterState.flag_changed.connect(func(_f, _v): _refresh())
	_refresh()

func _refresh(_a = null, _b = null) -> void:
	match npc_type:
		NpcType.ROSA:  _update_rosa()
		NpcType.BEPPE: _update_beppe()
		NpcType.TILDE: _update_tilde()

func _update_rosa() -> void:
	# Rosa is always visible; position/animation set in editor per state
	pass

func _update_beppe() -> void:
	# Post-payoff: Beppe gets a new path through the square
	var post_payoff := ChapterState.get_flag("ferry_shortcut_unlocked")
	# Notify animator or path follower via a child node signal if needed
	pass

func _update_tilde() -> void:
	# Tilde only visible during prologue
	visible = ChapterState.get_step() == ChapterState.C1Step.PROLOGUE_ACTIVE

func interact() -> void:
	var ctrl := get_tree().get_first_node_in_group("c1_controller")
	if ctrl == null:
		return
	match npc_type:
		NpcType.TILDE:
			if ChapterState.get_step() == ChapterState.C1Step.PROLOGUE_ACTIVE:
				DialogueManager.play_scene("C1_VS_S01", Callable())
		NpcType.ROSA:
			if (ChapterState.get_flag("recipient_guess_beppe")
					and not ChapterState.get_flag("spoke_to_rosa")):
				DialogueManager.play_scene("C1_VS_S08", func():
					ctrl.on_event(&"TalkedToRosa")
				)
		NpcType.BEPPE:
			if (ChapterState.get_flag("recipient_guess_beppe")
					and not ChapterState.get_flag("spoke_to_beppe")):
				DialogueManager.play_scene("C1_VS_S09", func():
					ctrl.on_event(&"TalkedToBeppe")
				)
