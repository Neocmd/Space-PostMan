# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

**Il Postino delle Stelle** is a narrative mobile game (Godot 4, 16-bit style) in Italian. This repository currently holds the **pre-production foundation pack**: narrative design, runtime data, localization, and CI/CD pipelines. The Godot project itself does not exist yet.

## Commands

Run before opening any PR:

```bash
python -m unittest discover -s tests -v
python scripts/repository_contracts.py
```

Package the foundation bundle locally:

```bash
python scripts/package_foundation_pack.py <version>
# Output: dist/foundation-pack-<version>.zip
```

Run a single test class:

```bash
python -m unittest tests.test_repository_contracts.RepositoryContractsTest.test_repository_contracts_are_valid -v
```

## Repository Contracts

`scripts/repository_contracts.py` enforces these rules — CI will fail if they are broken:

- All files listed in `REQUIRED_FILES` must exist.
- `data/localization/ui.csv` and `data/localization/dialogue.csv` must match the schema `{string_id, kind, scene, speaker, text_it, max_chars, notes}` with no duplicate `string_id`s and no `text_it` exceeding `max_chars`.
- `dialogue.csv` scenes must be either in the `ALLOWED_SCENES` set (`GLOBAL`, `C1_FREE_PRE`, `C1_FREE_POST`) or match a scene ID extracted from `docs/narrative/VERTICAL_SLICE_CAPITOLO_1.md` (pattern `### C1_VS_S\d{2}`).
- `data/letters/letters_it.json` letters must have all required keys, non-empty `body`, `read_time_seconds > 0`, and `fragment_count` matching the actual `fragments` array length.
- `rulesets/main-ruleset.json` and `rulesets/develop-ruleset.json` must have `target: "branch"`, `enforcement: "active"`, at least one `ref_name.include` pattern, and the rule types `deletion`, `non_fast_forward`, `pull_request`, `required_status_checks`.

## Architecture

```
project.godot                   # Godot 4 project (viewport 390×844, mobile renderer)
icon.svg                        # Project icon
scenes/
  bootstrap/bootstrap.tscn      # Entry point — loads save then opens village_slice_root
  world/                        # Area scenes (office, square, bakery_exterior/back, dock)
  interactive/                  # star_fragment, star_trail_node, side_key_pickup, interact_prompt
  puzzles/                      # envelope_puzzle, recipient_deduction
  ui/                           # hud, dialogue_box, letter_view, toast_message, objective_banner
scripts/
  autoload/                     # Godot singletons (loaded at project start)
    game_state.gd               # save/load → user://save_slot_0.json
    chapter_state.gd            # C1Step enum + c1_flags dict + signals
    localization_db.gd          # Loads ui.csv, dialogue.csv, letters_it.json at startup
    dialogue_manager.gd         # Plays dialogue scenes; requires register_box() call
  chapter1/
    c1_controller.gd            # Central event router; add_to_group("c1_controller")
    c1_trigger.gd               # Area2D generic trigger (set event_id, required_step)
    c1_npc_brain.gd             # NPC visibility/interaction gated on ChapterState
    c1_world_state.gd           # Applies bakery_lit / ferry_shortcut world changes
  player/
    nico_controller.gd          # CharacterBody2D; add_to_group("player"); tap-to-move
    interaction_sensor.gd       # Area2D child of Nico; emits interactable_focused/lost
  interactive/
    star_fragment.gd            # Area2D collectible; @export fragment_id ("fragment_2"…"4")
  puzzles/
    envelope_puzzle.gd          # Greybox button → fires EnvelopeRebuilt + shows letter
    recipient_deduction.gd      # Two-button UI → RecipientConfirmed or hint
  ui/
    dialogue_box_controller.gd  # Expects $Panel/VBox/{Speaker,Text,Next}
    hud_controller.gd           # Expects $ObjectiveBanner/Label
    letter_view_controller.gd   # Expects $Panel/VBox/{Title,Body,Close}
data/
  letters/letters_it.json       # Runtime letter data (one entry per letter-cardine)
  localization/ui.csv           # UI strings
  localization/dialogue.csv     # Dialogue strings, keyed by scene ID
docs/
  narrative/                    # Story design docs and vertical slice spec
  tech/GODOT4_C1_IMPLEMENTATION_SPEC.md  # Godot 4 implementation spec
  process/GITFLOW_AND_RELEASES.md
scripts/                        # Also contains Python CI scripts at root level
  repository_contracts.py       # Contract validator (also imported by tests)
  package_foundation_pack.py    # Zips docs/ + data/ + root MDs into dist/
tests/
  test_repository_contracts.py  # unittest wrapping repository_contracts.run_all()
rulesets/                       # GitHub branch ruleset JSON payloads + apply scripts
```

### Godot event flow

All game events pass through `C1Controller.on_event(event_id, payload)`. Triggers and NPCs never touch `ChapterState` directly.

```
c1_trigger / npc_brain → C1Controller.on_event() → ChapterState.set_step/flag()
                                                           ↓
                                               HUD (objective_updated signal)
                                               C1WorldState (step_changed signal)
```

### Key groups
- `"c1_controller"` — C1Controller node; queried by triggers, NPCs and puzzles
- `"player"` — Nico; queried by puzzle scripts and dawn scene
- `"letter_view"` — LetterView node; queried by envelope_puzzle

`letters_it.json` schema per letter:

```json
{
  "chapter": "C1",
  "title": "...",
  "sender": "...",
  "recipient": "...",
  "read_time_seconds": 25,
  "fragments": ["...", "..."],
  "body": "Full letter text",
  "presentation": {
    "fragment_count": 4,
    "show_in_archive_after_complete": true,
    "scene_id": "C1_VS_S06"
  }
}
```

## GitFlow

- `main` → releasable state, source of version tags (`v*`)
- `develop` → integration branch
- `feature/<name>`, `codex/<name>` → PR to `develop`
- `release/<version>` → PR to `main`, then back-merge to `develop`
- `hotfix/<version>` → PR to `main`, then back-merge to `develop`

Branch naming is validated by CI; any other pattern causes the build to fail.

## CD Artifacts

- Push to `develop` → snapshot artifact `develop-<sha>`
- Push to `main` → candidate artifact `main-<sha>`
- Tag `v*` → GitHub Release with the foundation pack zip
