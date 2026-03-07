extends Node

signal objective_updated(text: String)

func _ready() -> void:
	add_to_group("c1_controller")
	ChapterState.step_changed.connect(_on_step_changed)
	start_chapter()

func start_chapter() -> void:
	if ChapterState.get_step() == ChapterState.C1Step.NOT_STARTED:
		ChapterState.set_step(ChapterState.C1Step.PROLOGUE_ACTIVE)
	update_objective()

func on_event(event_id: StringName, payload: Dictionary = {}) -> void:
	match event_id:
		&"ExitOfficeDoor":
			if ChapterState.get_step() != ChapterState.C1Step.PROLOGUE_ACTIVE:
				return
			ChapterState.set_flag("prologue_seen", true)
			ChapterState.set_step(ChapterState.C1Step.STAR_REVEALED)

		&"FirstStarInspect":
			if ChapterState.get_step() != ChapterState.C1Step.STAR_REVEALED:
				return
			ChapterState.set_flag("first_star_seen", true)
			ChapterState.set_flag("fragment_1_collected", true)
			ChapterState.set_step(ChapterState.C1Step.FRAGMENTS_HUNT)

		&"FragmentCollected":
			if ChapterState.get_step() < ChapterState.C1Step.FRAGMENTS_HUNT:
				return
			var frag: String = payload.get("fragment_id", "")
			if frag != "":
				ChapterState.set_flag(frag + "_collected", true)
			if ChapterState.all_fragments_collected():
				ChapterState.set_step(ChapterState.C1Step.ENVELOPE_READY)

		&"EnvelopeRebuilt":
			if ChapterState.get_step() != ChapterState.C1Step.ENVELOPE_READY:
				return
			ChapterState.set_flag("envelope_rebuilt", true)
			ChapterState.set_step(ChapterState.C1Step.RECIPIENT_PHASE)

		&"RecipientConfirmed":
			if not ChapterState.get_flag("envelope_rebuilt"):
				return
			ChapterState.set_flag("recipient_guess_beppe", true)

		&"TalkedToRosa":
			if not ChapterState.get_flag("recipient_guess_beppe"):
				return
			ChapterState.set_flag("spoke_to_rosa", true)
			_check_delivery_ready()

		&"TalkedToBeppe":
			if not ChapterState.get_flag("recipient_guess_beppe"):
				return
			ChapterState.set_flag("spoke_to_beppe", true)
			_check_delivery_ready()

		&"SideKeyFound":
			if ChapterState.get_step() != ChapterState.C1Step.DELIVERY_SETUP:
				return
			ChapterState.set_flag("side_key_found", true)

		&"SideDoorOpened":
			if not ChapterState.get_flag("side_key_found"):
				return
			ChapterState.set_flag("bakery_side_door_open", true)
			ChapterState.set_step(ChapterState.C1Step.DAWN_READY)

		&"DawnSceneTrigger":
			if ChapterState.get_step() != ChapterState.C1Step.DAWN_READY:
				return
			_play_dawn_scene()

		&"DawnSceneComplete":
			ChapterState.set_flag("dawn_scene_played", true)
			ChapterState.set_flag("bakery_lit", true)
			ChapterState.set_flag("ferry_shortcut_unlocked", true)
			ChapterState.set_step(ChapterState.C1Step.COMPLETE)

	GameState.save()

func update_objective() -> void:
	objective_updated.emit(_get_objective_text())

func _get_objective_text() -> String:
	var step := ChapterState.get_step()
	var obj_id := ""
	match step:
		ChapterState.C1Step.PROLOGUE_ACTIVE:
			obj_id = "C1_OBJ_001"
		ChapterState.C1Step.STAR_REVEALED:
			obj_id = "C1_OBJ_002"
		ChapterState.C1Step.FRAGMENTS_HUNT:
			obj_id = "C1_OBJ_003"
		ChapterState.C1Step.ENVELOPE_READY:
			obj_id = "C1_OBJ_005"
		ChapterState.C1Step.RECIPIENT_PHASE:
			if not ChapterState.get_flag("recipient_guess_beppe"):
				obj_id = "C1_OBJ_006"
			elif not ChapterState.get_flag("spoke_to_rosa"):
				obj_id = "C1_OBJ_007"
			else:
				obj_id = "C1_OBJ_008"
		ChapterState.C1Step.DELIVERY_SETUP:
			obj_id = "C1_OBJ_009"
		ChapterState.C1Step.DAWN_READY:
			obj_id = "C1_OBJ_010"
	return LocalizationDb.get_ui(obj_id) if obj_id != "" else ""

func _check_delivery_ready() -> void:
	if ChapterState.delivery_setup_ready():
		ChapterState.set_step(ChapterState.C1Step.DELIVERY_SETUP)

func _play_dawn_scene() -> void:
	var player := get_tree().get_first_node_in_group("player")
	if player and player.has_method("disable_movement"):
		player.disable_movement()
	DialogueManager.play_scene("C1_VS_S11", func():
		on_event(&"DawnSceneComplete")
		if player and player.has_method("enable_movement"):
			player.enable_movement()
	)

func _on_step_changed(_old: int, _new: int) -> void:
	update_objective()
