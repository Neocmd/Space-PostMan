extends Node

enum C1Step {
	NOT_STARTED,
	PROLOGUE_ACTIVE,
	STAR_REVEALED,
	FRAGMENTS_HUNT,
	ENVELOPE_READY,
	RECIPIENT_PHASE,
	DELIVERY_SETUP,
	DAWN_READY,
	COMPLETE,
}

signal step_changed(old_step: int, new_step: int)
signal flag_changed(flag_name: String, value: bool)

var c1_step: int = C1Step.NOT_STARTED
var c1_flags: Dictionary = {
	"prologue_seen": false,
	"first_star_seen": false,
	"fragment_1_collected": false,
	"fragment_2_collected": false,
	"fragment_3_collected": false,
	"fragment_4_collected": false,
	"envelope_rebuilt": false,
	"recipient_guess_beppe": false,
	"spoke_to_rosa": false,
	"spoke_to_beppe": false,
	"side_key_found": false,
	"bakery_side_door_open": false,
	"dawn_scene_played": false,
	"bakery_lit": false,
	"ferry_shortcut_unlocked": false,
}

func set_step(new_step: int) -> void:
	if new_step == c1_step:
		return
	var old := c1_step
	c1_step = new_step
	step_changed.emit(old, new_step)

func get_step() -> int:
	return c1_step

func set_flag(flag_name: String, value: bool) -> void:
	if not flag_name in c1_flags:
		push_warning("ChapterState: unknown flag '%s'" % flag_name)
		return
	if c1_flags[flag_name] == value:
		return
	c1_flags[flag_name] = value
	flag_changed.emit(flag_name, value)

func get_flag(flag_name: String) -> bool:
	return c1_flags.get(flag_name, false)

func fragments_collected_count() -> int:
	var count := 0
	for i in range(1, 5):
		if c1_flags.get("fragment_%d_collected" % i, false):
			count += 1
	return count

func all_fragments_collected() -> bool:
	return fragments_collected_count() == 4

func delivery_setup_ready() -> bool:
	return (get_flag("recipient_guess_beppe")
		and get_flag("spoke_to_rosa")
		and get_flag("spoke_to_beppe"))

func to_dict() -> Dictionary:
	return {
		"c1_step": c1_step,
		"c1_flags": c1_flags.duplicate(),
	}

func from_dict(data: Dictionary) -> void:
	c1_step = data.get("c1_step", C1Step.NOT_STARTED)
	var saved_flags: Dictionary = data.get("c1_flags", {})
	for key in saved_flags:
		if key in c1_flags:
			c1_flags[key] = saved_flags[key]
