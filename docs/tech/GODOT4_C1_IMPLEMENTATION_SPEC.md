# Il Postino delle Stelle - Godot 4 C1 Implementation Spec

Spec tecnica per implementare il vertical slice del Capitolo 1 `Pane caldo` in Godot 4.

## 1. Assunzioni bloccate

- Engine: Godot 4.x.
- Target principale: mobile portrait landscape-safe 2D, con input touch come default e mouse come fallback editor.
- Architettura: scene-based con alcuni singleton autoload per stato, dialogo e dati.
- Il vertical slice implementa solo il Capitolo 1, non l'intero gioco.

## 2. Obiettivo della spec

Ridurre al minimo le decisioni aperte per iniziare l'implementazione reale del slice in Godot.

## 3. Struttura cartelle raccomandata

```text
res://
  scenes/
    bootstrap/
      bootstrap.tscn
    world/
      village_slice_root.tscn
      office.tscn
      square.tscn
      bakery_exterior.tscn
      bakery_back.tscn
      dock.tscn
    interactive/
      star_fragment.tscn
      star_trail_node.tscn
      side_key_pickup.tscn
      interact_prompt.tscn
    puzzles/
      envelope_puzzle.tscn
      recipient_deduction.tscn
    ui/
      hud.tscn
      objective_banner.tscn
      dialogue_box.tscn
      letter_view.tscn
      toast_message.tscn
  scripts/
    autoload/
      game_state.gd
      chapter_state.gd
      dialogue_manager.gd
      localization_db.gd
    chapter1/
      c1_controller.gd
      c1_trigger.gd
      c1_npc_brain.gd
      c1_world_state.gd
    player/
      nico_controller.gd
      interaction_sensor.gd
    ui/
      hud_controller.gd
      dialogue_box_controller.gd
      letter_view_controller.gd
  data/
    localization/
      ui.csv
      dialogue.csv
    letters/
      letters_it.json
```

## 4. Singleton autoload consigliati

### `GameState`
Responsabilita:
- Gestire slot save/load minimi.
- Conservare stato globale del villaggio e del capitolo.
- Esporre API semplici: `set_flag()`, `get_flag()`, `set_step()`, `get_step()`.

### `DialogueManager`
Responsabilita:
- Caricare righe dialogo da CSV.
- Restituire scene dialogue per ID o scene ID.
- Aprire e chiudere `DialogueBox`.

### `LocalizationDb`
Responsabilita:
- Caricare `ui.csv`, `dialogue.csv`, `letters.json`.
- Esporre lookup per `string_id` e payload lettera.

### `ChapterState`
Responsabilita:
- Gestire solo progresso di capitolo attivo.
- Per C1, incapsulare `c1_step`, flags e helper di transizione.

## 5. Scene root del vertical slice

### `bootstrap.tscn`
Responsabilita:
- Caricare autoload e poi instanziare `village_slice_root.tscn`.
- Opzionalmente caricare save di debug.

### `village_slice_root.tscn`
Node tree consigliato:

```text
VillageSliceRoot (Node2D)
  BackgroundLayer
  NavigationRoot
  PropsRoot
  NPCsRoot
  TriggersRoot
  FXRoot
  PlayerSpawn
  Nico
  Camera2D
  HUDCanvasLayer
  AudioRoot
  C1Controller
```

Responsabilita:
- Montare area giocabile continua o semi-continua.
- Delegare tutta la logica di capitolo a `C1Controller`.

## 6. C1Controller

Script: `res://scripts/chapter1/c1_controller.gd`

Responsabilita:
- Leggere `ChapterState` e attivare/disattivare interazioni.
- Aggiornare objective text.
- Orchestrare scene e trigger non ambientali.
- Applicare il world-state post-payoff.

API minima consigliata:

```gdscript
func start_chapter() -> void
func refresh_state() -> void
func on_event(event_id: StringName, payload := {}) -> void
func update_objective() -> void
func apply_post_payoff_state() -> void
```

Regola:
- Nessun trigger ambientale modifica direttamente lo stato globale del capitolo. Deve sempre passare da `C1Controller.on_event()`.

## 7. ChapterState per C1

Suggerimento dati:

```gdscript
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
```

Dictionary flags consigliato:

```gdscript
var c1_flags := {
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
```

## 8. Trigger pattern consigliato

Ogni trigger in scena usa un wrapper comune `c1_trigger.gd` con export parameters:

```gdscript
@export var event_id: StringName
@export var one_shot := true
@export var required_step: int = -1
@export var required_flags: Array[StringName] = []
```

Comportamento:
- Quando il player entra o interagisce, il trigger verifica `required_step` e `required_flags`.
- Se validi, chiama `C1Controller.on_event(event_id)`.
- Se `one_shot`, si disattiva.

Questo evita logica duplicata in 10 nodi diversi.

## 9. Implementazione scene chiave in Godot

### Prologo ufficio
- `office_exit_door` e un `Area2D` con `c1_trigger.gd`.
- `required_step = PROLOGUE_ACTIVE`.
- `event_id = "ExitOfficeDoor"`.

### Prima stella
- Nodo stella con VFX e `Interactable`.
- All'interazione invia `FirstStarInspect`.
- Dopo il trigger, il primo frammento puo essere incorporato nello stesso nodo per evitare extra complessita.

### Frammenti 2/3/4
- Ogni frammento e una scena `star_fragment.tscn` con:
  - Sprite2D
  - Area2D
  - GPUParticles2D
  - AudioStreamPlayer2D
  - Script che emette `FragmentCollected(fragment_id)`

### Puzzle busta
- Apertura tramite `CanvasLayer` e pausa del movimento player.
- Output semplice: `success` boolean.
- Se success, `C1Controller.on_event("EnvelopeRebuilt")`.

### Deduzione destinatario
- UI con massimo 2 opzioni visibili: `Rosa Ferri`, `Beppe Ferri`.
- Se errore, non cambiare stato ma mostrare hint.
- Se corretto, emettere `RecipientConfirmed`.

### Porta laterale
- `StaticBody2D` con area interazione.
- Se `side_key_found == false`, mostra prompt passivo o nessuna interazione.
- Se `true`, interazione lancia `SideDoorOpened` e cambia sprite/animazione porta.

### Scena d'alba
Raccomandazione pragmatica:
- Non farla come cutscene separata pesante.
- Usare una `Timeline` semplice o una sequenza controllata via script in `C1Controller`, con:
  - player control disabilitato
  - NPC posizionati
  - 6 linee di dialogo
  - cambio lighting e vapore forno
  - riattivazione controllo o breve epilogo libero

## 10. UI implementation mapping

### HUD
Componenti minimi:
- Objective banner.
- Prompt interazione.
- Toast piccoli.

### DialogueBox
Requisiti:
- Speaker name.
- Auto-wrap.
- Next/skip.
- Supporto a pause brevi via token opzionale o timing esterno.

### LetterView
Requisiti:
- Modal fullscreen o quasi fullscreen.
- Supporto body multilinea.
- Pulsante `Chiudi`.
- Versione frammenti e versione lettera completa.

## 11. Data format raccomandato

### `ui.csv`
Campi:
- `string_id`
- `kind`
- `scene`
- `speaker`
- `text_it`
- `max_chars`
- `notes`

### `dialogue.csv`
Campi:
- `string_id`
- `scene`
- `speaker`
- `text_it`
- `max_chars`
- `notes`

### `letters_it.json`
Struttura consigliata:

```json
{
  "C1_LTR_001": {
    "title": "Il pane del mattino",
    "sender": "Rosa",
    "recipient": "Beppe",
    "fragments": [
      "metto ancora da parte il primo pane",
      "continuo a guardare la porta laterale",
      "la tua chiave e ancora sotto la cassa blu",
      "il pane si raffredda in fretta"
    ],
    "body": "..."
  }
}
```

## 12. Segnali Godot consigliati

### `DialogueManager`
- `dialogue_started(scene_id)`
- `dialogue_finished(scene_id)`

### `ChapterState`
- `step_changed(old_step, new_step)`
- `flag_changed(flag_name, value)`

### `LetterView`
- `letter_closed(letter_id)`

### `EnvelopePuzzle`
- `puzzle_completed(puzzle_id)`
- `puzzle_cancelled(puzzle_id)`

## 13. Pseudoflow Godot event-driven

```text
Player exits office
 -> c1_trigger emits ExitOfficeDoor
 -> C1Controller.on_event("ExitOfficeDoor")
 -> ChapterState.set_step(STAR_REVEALED)
 -> Objective updated
 -> Star node becomes interactable

Player inspects star
 -> FirstStarInspect
 -> fragment_1_collected = true
 -> step = FRAGMENTS_HUNT
 -> remaining fragment nodes enabled

All fragments collected
 -> step = ENVELOPE_READY
 -> envelope puzzle station enabled

Envelope puzzle success
 -> step = RECIPIENT_PHASE
 -> deduction UI enabled

RecipientConfirmed + both talks done
 -> step = DELIVERY_SETUP
 -> blue crate key enabled

SideDoorOpened
 -> step = DAWN_READY
 -> dawn trigger enabled

DawnSceneComplete
 -> step = COMPLETE
 -> bakery_lit = true
 -> ferry_shortcut_unlocked = true
 -> world state refreshed
```

## 14. Save system minimo in Godot

Per il slice basta salvare JSON locale con:

```json
{
  "current_chapter": "C1",
  "c1_step": 6,
  "c1_flags": {
    "recipient_guess_beppe": true,
    "spoke_to_rosa": true,
    "spoke_to_beppe": true,
    "side_key_found": false
  }
}
```

Raccomandazione:
- Salvare dopo ogni evento maggiore, non a ogni frame.
- Path pratico: `user://save_slot_0.json`.

## 15. Anti-overengineering rules per Godot

- Niente quest system generico per il slice: basta `C1Controller`.
- Niente behaviour tree per NPC: usare script semplici con stati locali.
- Niente localization framework complesso: caricare CSV e JSON in memoria all'avvio.
- Niente plugin custom per cutscene: usare sequenze scriptate e segnali.

## 16. Task tecnici immediati in Godot

1. Creare autoload `GameState`, `ChapterState`, `DialogueManager`, `LocalizationDb`.
2. Creare `village_slice_root.tscn` con 5 aree essenziali.
3. Implementare `C1Controller` e collegarlo a `ChapterState`.
4. Implementare `DialogueBox` e `LetterView` minimi.
5. Importare `ui.csv`, `dialogue.csv`, `letters_it.json`.
6. Implementare i 10 trigger/eventi principali del capitolo.
7. Chiudere il payoff e verificare che il world-state finale si applichi al reload.

## 17. Decisione raccomandata

Godot 4 e una scelta forte per questo progetto perche consente:
- iterazione rapida su scene 2D e UI;
- scripting diretto del slice senza tool overhead;
- build mobile gestibili per un team piccolo;
- buona compatibilita con pipeline data-driven leggere come CSV e JSON.

Se il team non ha un vincolo preesistente forte su un altro engine, questa e la scelta raccomandata.
