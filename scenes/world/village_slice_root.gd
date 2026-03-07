extends Node2D

const C1_TRIGGER = preload("res://scripts/chapter1/c1_trigger.gd")
const ENVELOPE_PUZZLE = preload("res://scenes/puzzles/envelope_puzzle.tscn")
const RECIPIENT_DEDUCTION = preload("res://scenes/puzzles/recipient_deduction.tscn")

func _ready() -> void:
	RenderingServer.set_default_clear_color(Color(0.08, 0.08, 0.15))
	_build_world()
	_build_triggers()
	_build_puzzle_ui()
	$Nico.global_position = Vector2(195, 160)

# ── World layout ────────────────────────────────────────────────────────────

func _build_world() -> void:
	_area($BackgroundLayer, "",        Rect2(-200, -200, 800, 1400), Color(0.10, 0.12, 0.20), false)
	_area($PropsRoot, "Ufficio Postale", Rect2(40,  40,  310, 180),  Color(0.20, 0.25, 0.40))
	_area($PropsRoot, "Piazza del Pozzo",Rect2(40,  270, 310, 160),  Color(0.15, 0.15, 0.22))
	_area($PropsRoot, "Forno Ferri",     Rect2(40,  480, 180, 140),  Color(0.32, 0.18, 0.10))
	_area($PropsRoot, "Retro Forno",     Rect2(230, 480, 120, 140),  Color(0.26, 0.14, 0.08))
	_area($PropsRoot, "Molo Vecchio",    Rect2(40,  680, 310, 140),  Color(0.10, 0.15, 0.30))

func _area(parent: Node, label: String, rect: Rect2, color: Color, show_label: bool = true) -> void:
	var cr := ColorRect.new()
	cr.color = color
	cr.position = rect.position
	cr.size = rect.size
	parent.add_child(cr)
	if show_label:
		var lbl := Label.new()
		lbl.text = label
		lbl.position = rect.position + Vector2(6, 6)
		lbl.add_theme_font_size_override("font_size", 12)
		lbl.modulate = Color(1, 1, 1, 0.55)
		parent.add_child(lbl)

# ── Triggers ────────────────────────────────────────────────────────────────

func _build_triggers() -> void:
	# 1 – ExitOfficeDoor: striscia sul bordo inferiore dell'ufficio
	_trigger(&"ExitOfficeDoor",  Vector2(195, 224), Vector2(250, 20),
		ChapterState.C1Step.PROLOGUE_ACTIVE)

	# 2 – FirstStarInspect: luce sopra il forno
	_trigger(&"FirstStarInspect", Vector2(130, 472), Vector2(60, 30),
		ChapterState.C1Step.STAR_REVEALED)

	# 3 – Frammenti 2 / 3 / 4
	_fragment_trigger("fragment_2", Vector2(290, 510))
	_fragment_trigger("fragment_3", Vector2(80,  710))
	_fragment_trigger("fragment_4", Vector2(290, 730))

	# 4 – EnvelopePuzzle si apre in automatico via step_changed (vedi script)

	# 5 – RecipientDeduction si apre in automatico via step_changed

	# 6 – TalkedToRosa (greybox: trigger di prossimità, salta dialogo)
	_trigger(&"TalkedToRosa", Vector2(130, 540), Vector2(80, 40),
		ChapterState.C1Step.RECIPIENT_PHASE,
		["recipient_guess_beppe"])

	# 7 – TalkedToBeppe (greybox: trigger di prossimità, salta dialogo)
	_trigger(&"TalkedToBeppe", Vector2(195, 720), Vector2(80, 40),
		ChapterState.C1Step.RECIPIENT_PHASE,
		["recipient_guess_beppe"])

	# 8 – SideKeyFound: cassa blu sul molo
	_trigger(&"SideKeyFound", Vector2(90, 740), Vector2(40, 40),
		ChapterState.C1Step.DELIVERY_SETUP)

	# 9 – SideDoorOpened: porta laterale del forno (richiede chiave)
	_trigger(&"SideDoorOpened", Vector2(290, 555), Vector2(40, 40),
		ChapterState.C1Step.DELIVERY_SETUP,
		["side_key_found"])

	# 10 – DawnSceneTrigger: ingresso area payoff
	_trigger(&"DawnSceneTrigger", Vector2(130, 515), Vector2(80, 40),
		ChapterState.C1Step.DAWN_READY)

func _trigger(event_id: StringName, pos: Vector2, size: Vector2,
		required_step: int, flags: Array = []) -> void:
	var t: Area2D = C1_TRIGGER.new()
	t.event_id = event_id
	t.required_step = required_step
	t.one_shot = true
	for f in flags:
		t.required_flags.append(f)
	t.position = pos

	var shape := CollisionShape2D.new()
	var rs := RectangleShape2D.new()
	rs.size = size
	shape.shape = rs
	t.add_child(shape)

	_debug_overlay(t, str(event_id), size)
	$TriggersRoot.add_child(t)

func _fragment_trigger(frag_id: String, pos: Vector2) -> void:
	var t: Area2D = C1_TRIGGER.new()
	t.event_id = &"FragmentCollected"
	t.fragment_id = frag_id
	t.required_step = ChapterState.C1Step.FRAGMENTS_HUNT
	t.one_shot = true
	t.position = pos

	var shape := CollisionShape2D.new()
	var rs := RectangleShape2D.new()
	rs.size = Vector2(32, 32)
	shape.shape = rs
	t.add_child(shape)

	_debug_overlay(t, frag_id, Vector2(32, 32), Color(0.8, 0.9, 0.3, 0.4))
	$TriggersRoot.add_child(t)

func _debug_overlay(parent: Node2D, label: String, size: Vector2,
		color: Color = Color(1, 1, 0, 0.25)) -> void:
	var cr := ColorRect.new()
	cr.color = color
	cr.size = size
	cr.position = -size / 2
	parent.add_child(cr)
	var lbl := Label.new()
	lbl.text = label
	lbl.add_theme_font_size_override("font_size", 9)
	lbl.position = Vector2(-size.x / 2, -size.y / 2 - 14)
	parent.add_child(lbl)

# ── Puzzle UI ────────────────────────────────────────────────────────────────

func _build_puzzle_ui() -> void:
	$HUDCanvasLayer.add_child(ENVELOPE_PUZZLE.instantiate())
	$HUDCanvasLayer.add_child(RECIPIENT_DEDUCTION.instantiate())
