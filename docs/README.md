# Il Postino delle Stelle - Docs Index

Indice operativo della documentazione di progetto.

## Foundation

- [Foundation Pack](../FOUNDATION_PACK_IL_POSTINO_DELLE_STELLE.md)
- [Contributing](../CONTRIBUTING.md)
- [Narrative Docs Index](./narrative/README.md)

## Narrative

- [Chapter Cards](./narrative/CHAPTER_CARDS.md)
- [Lettere Cardine](./narrative/LETTERE_CARDINE.md)
- [Vertical Slice Capitolo 1](./narrative/VERTICAL_SLICE_CAPITOLO_1.md)
- [Vertical Slice Backlog](./narrative/VERTICAL_SLICE_BACKLOG.md)
- [C1 States and Triggers](./narrative/C1_STATES_AND_TRIGGERS.md)

## Production

- [Sprint Board Vertical Slice](./production/SPRINT_BOARD_VERTICAL_SLICE.md)

## Process

- [GitFlow and Releases](./process/GITFLOW_AND_RELEASES.md)
- [Rulesets README](../rulesets/README.md)
- [Main Ruleset JSON](../rulesets/main-ruleset.json)
- [Develop Ruleset JSON](../rulesets/develop-ruleset.json)

## Tech

- [Godot 4 C1 Implementation Spec](./tech/GODOT4_C1_IMPLEMENTATION_SPEC.md)

## Runtime Data

- [UI Strings CSV](../data/localization/ui.csv)
- [Dialogue CSV](../data/localization/dialogue.csv)
- [Letters JSON](../data/letters/letters_it.json)
- [Combined Runtime Strings CSV](./narrative/C1_RUNTIME_STRINGS.csv)

## Automation

- [CI Workflow](../.github/workflows/ci.yml)
- [CD Workflow](../.github/workflows/cd.yml)
- [PR Template](../.github/pull_request_template.md)
- [Repository Contracts Validator](../scripts/repository_contracts.py)

## Ordine di esecuzione consigliato

1. Allineamento creativo e scope sul foundation pack.
2. Allineamento di processo su `CONTRIBUTING.md`, `docs/process/GITFLOW_AND_RELEASES.md` e `rulesets/README.md`.
3. Applicazione delle ruleset su GitHub.
4. Planning di sprint con backlog e sprint board.
5. Implementazione Godot del vertical slice usando states/triggers.
6. Import dei dati runtime separati.
7. Primo playtest del Capitolo 1.
