from __future__ import annotations

import csv
import json
import re
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
REQUIRED_FILES = [
    REPO_ROOT / "FOUNDATION_PACK_IL_POSTINO_DELLE_STELLE.md",
    REPO_ROOT / "CONTRIBUTING.md",
    REPO_ROOT / "docs" / "README.md",
    REPO_ROOT / "docs" / "narrative" / "VERTICAL_SLICE_CAPITOLO_1.md",
    REPO_ROOT / "docs" / "narrative" / "C1_STATES_AND_TRIGGERS.md",
    REPO_ROOT / "data" / "localization" / "ui.csv",
    REPO_ROOT / "data" / "localization" / "dialogue.csv",
    REPO_ROOT / "data" / "letters" / "letters_it.json",
    REPO_ROOT / "rulesets" / "main-ruleset.json",
    REPO_ROOT / "rulesets" / "develop-ruleset.json",
    REPO_ROOT / "rulesets" / "README.md",
]

ALLOWED_SCENES = {"GLOBAL", "C1_FREE_PRE", "C1_FREE_POST"}
SCENE_PATTERN = re.compile(r"^###\s+(C1_VS_S\d{2})\b")
RULESET_JSON_FILES = [
    REPO_ROOT / "rulesets" / "main-ruleset.json",
    REPO_ROOT / "rulesets" / "develop-ruleset.json",
]


def load_csv_rows(path: Path) -> list[dict[str, str]]:
    with path.open("r", encoding="utf-8", newline="") as handle:
        return list(csv.DictReader(handle))


def extract_vertical_slice_scenes() -> set[str]:
    path = REPO_ROOT / "docs" / "narrative" / "VERTICAL_SLICE_CAPITOLO_1.md"
    scenes: set[str] = set()
    for line in path.read_text(encoding="utf-8").splitlines():
        match = SCENE_PATTERN.match(line.strip())
        if match:
            scenes.add(match.group(1))
    return scenes


def validate_required_files() -> list[str]:
    errors: list[str] = []
    for path in REQUIRED_FILES:
        if not path.exists():
            errors.append(f"Missing required file: {path}")
    return errors


def validate_ui_csv() -> list[str]:
    path = REPO_ROOT / "data" / "localization" / "ui.csv"
    rows = load_csv_rows(path)
    errors: list[str] = []
    seen_ids: set[str] = set()

    required_fields = {"string_id", "kind", "scene", "speaker", "text_it", "max_chars", "notes"}
    if rows and set(rows[0].keys()) != required_fields:
        errors.append("ui.csv headers do not match the expected schema")

    for row in rows:
        string_id = row["string_id"].strip()
        if not string_id:
            errors.append("ui.csv contains an empty string_id")
            continue
        if string_id in seen_ids:
            errors.append(f"ui.csv duplicate string_id: {string_id}")
        seen_ids.add(string_id)

        text = row["text_it"].strip()
        if not text:
            errors.append(f"ui.csv empty text for {string_id}")

        try:
            max_chars = int(row["max_chars"])
        except ValueError:
            errors.append(f"ui.csv max_chars is not an integer for {string_id}")
            continue

        if max_chars <= 0:
            errors.append(f"ui.csv max_chars must be > 0 for {string_id}")
        if len(text) > max_chars:
            errors.append(f"ui.csv text exceeds max_chars for {string_id}")

    return errors


def validate_dialogue_csv() -> list[str]:
    path = REPO_ROOT / "data" / "localization" / "dialogue.csv"
    rows = load_csv_rows(path)
    errors: list[str] = []
    seen_ids: set[str] = set()
    valid_scenes = extract_vertical_slice_scenes() | ALLOWED_SCENES

    required_fields = {"string_id", "kind", "scene", "speaker", "text_it", "max_chars", "notes"}
    if rows and set(rows[0].keys()) != required_fields:
        errors.append("dialogue.csv headers do not match the expected schema")

    for row in rows:
        string_id = row["string_id"].strip()
        if not string_id:
            errors.append("dialogue.csv contains an empty string_id")
            continue
        if string_id in seen_ids:
            errors.append(f"dialogue.csv duplicate string_id: {string_id}")
        seen_ids.add(string_id)

        text = row["text_it"].strip()
        if not text:
            errors.append(f"dialogue.csv empty text for {string_id}")

        try:
            max_chars = int(row["max_chars"])
        except ValueError:
            errors.append(f"dialogue.csv max_chars is not an integer for {string_id}")
            continue

        if max_chars <= 0:
            errors.append(f"dialogue.csv max_chars must be > 0 for {string_id}")
        if len(text) > max_chars:
            errors.append(f"dialogue.csv text exceeds max_chars for {string_id}")

        scene = row["scene"].strip()
        if scene not in valid_scenes:
            errors.append(f"dialogue.csv references unknown scene {scene} for {string_id}")

    return errors


def validate_letters_json() -> list[str]:
    path = REPO_ROOT / "data" / "letters" / "letters_it.json"
    payload = json.loads(path.read_text(encoding="utf-8"))
    errors: list[str] = []

    letters = payload.get("letters")
    if not isinstance(letters, dict) or not letters:
        return ["letters_it.json must contain a non-empty 'letters' object"]

    for letter_id, letter in letters.items():
        for key in ("chapter", "title", "sender", "recipient", "read_time_seconds", "fragments", "body", "presentation"):
            if key not in letter:
                errors.append(f"{letter_id} missing key: {key}")

        if not isinstance(letter.get("fragments"), list) or not letter["fragments"]:
            errors.append(f"{letter_id} must define at least one fragment")

        presentation = letter.get("presentation", {})
        fragment_count = presentation.get("fragment_count")
        if fragment_count != len(letter.get("fragments", [])):
            errors.append(f"{letter_id} fragment_count does not match fragments length")

        if not isinstance(letter.get("read_time_seconds"), int) or letter["read_time_seconds"] <= 0:
            errors.append(f"{letter_id} read_time_seconds must be a positive integer")

        body = str(letter.get("body", "")).strip()
        if not body:
            errors.append(f"{letter_id} body must not be empty")

    return errors


def validate_ruleset_jsons() -> list[str]:
    errors: list[str] = []
    for path in RULESET_JSON_FILES:
        payload = json.loads(path.read_text(encoding="utf-8"))

        for key in ("name", "target", "enforcement", "bypass_actors", "conditions", "rules"):
            if key not in payload:
                errors.append(f"{path.name} missing key: {key}")

        if payload.get("target") != "branch":
            errors.append(f"{path.name} target must be 'branch'")
        if payload.get("enforcement") != "active":
            errors.append(f"{path.name} enforcement must be 'active'")

        conditions = payload.get("conditions", {})
        ref_name = conditions.get("ref_name", {}) if isinstance(conditions, dict) else {}
        include = ref_name.get("include", []) if isinstance(ref_name, dict) else []
        if not include:
            errors.append(f"{path.name} must declare at least one ref_name include pattern")

        rules = payload.get("rules", [])
        if not isinstance(rules, list) or not rules:
            errors.append(f"{path.name} must define a non-empty rules array")
            continue

        rule_types = {rule.get("type") for rule in rules if isinstance(rule, dict)}
        required_rule_types = {"deletion", "non_fast_forward", "pull_request", "required_status_checks"}
        missing = required_rule_types - rule_types
        if missing:
            errors.append(f"{path.name} missing required rule types: {sorted(missing)}")

    return errors


def run_all() -> list[str]:
    errors: list[str] = []
    errors.extend(validate_required_files())
    errors.extend(validate_ui_csv())
    errors.extend(validate_dialogue_csv())
    errors.extend(validate_letters_json())
    errors.extend(validate_ruleset_jsons())
    return errors


def main() -> int:
    errors = run_all()
    if errors:
        for error in errors:
            print(f"ERROR: {error}")
        return 1

    print("Repository contracts validated successfully.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
