# Il Postino delle Stelle - C1 States and Triggers

Spec tecnica narrativa per lo scripting del Capitolo 1 `Pane caldo`.

## 1. Obiettivo

Fornire una base chiara per implementare il progression flow del vertical slice senza ambiguita tra design, code e narrative.

## 2. Raccomandazione architetturale

Usare una combinazione di:

- `c1_step` come stato principale del capitolo.
- `c1_flags` come booleane secondarie per eventi facoltativi o supporto UI.

Questo riduce il rischio di save corrotti o combinazioni incoerenti tra scene e interazioni.

## 3. Enum principale di progressione

| Valore | Nome | Descrizione |
| --- | --- | --- |
| 0 | C1_NOT_STARTED | Il capitolo non e ancora iniziato |
| 1 | C1_PROLOGUE_ACTIVE | Il prologo all'ufficio postale e giocabile |
| 2 | C1_STAR_REVEALED | La prima stella e apparsa sopra il forno |
| 3 | C1_FRAGMENTS_HUNT | Il giocatore sta raccogliendo i 4 frammenti |
| 4 | C1_ENVELOPE_READY | I 4 frammenti sono raccolti, la ricomposizione e disponibile |
| 5 | C1_RECIPIENT_PHASE | La lettera e stata letta e il destinatario va identificato |
| 6 | C1_DELIVERY_SETUP | Rosa e Beppe sono stati coinvolti, va aperta la porta laterale |
| 7 | C1_DAWN_READY | Tutte le condizioni per la scena d'alba sono soddisfatte |
| 8 | C1_COMPLETE | Il payoff e terminato e il world-state post-capitolo e attivo |

## 4. Flags secondarie minime

| Flag | Tipo | Default | Uso |
| --- | --- | --- | --- |
| prologue_seen | bool | false | Evita replay automatico del prologo |
| first_star_seen | bool | false | Sblocca testo e VFX della prima stella |
| fragment_1_collected | bool | false | Tracking frammenti |
| fragment_2_collected | bool | false | Tracking frammenti |
| fragment_3_collected | bool | false | Tracking frammenti |
| fragment_4_collected | bool | false | Tracking frammenti |
| envelope_rebuilt | bool | false | Sblocca lettura completa |
| recipient_guess_beppe | bool | false | Segna deduzione corretta |
| spoke_to_rosa | bool | false | Gating scena finale |
| spoke_to_beppe | bool | false | Gating scena finale |
| side_key_found | bool | false | Gating porta laterale |
| bakery_side_door_open | bool | false | Gating scena d'alba |
| dawn_scene_played | bool | false | Evita doppio trigger payoff |
| bakery_lit | bool | false | Stato mondo post-payoff |
| ferry_shortcut_unlocked | bool | false | Shortcut sbloccato |

## 5. Progression table

| c1_step | Entry condition | Goal del giocatore | Trigger di uscita | Next step |
| --- | --- | --- | --- | --- |
| C1_NOT_STARTED | New game o save prima del capitolo | Nessuno | Start game | C1_PROLOGUE_ACTIVE |
| C1_PROLOGUE_ACTIVE | Start game | Uscire dall'ufficio postale | ExitOfficeDoor | C1_STAR_REVEALED |
| C1_STAR_REVEALED | Uscita completata | Raggiungere la stella sopra il forno | FirstStarInspect | C1_FRAGMENTS_HUNT |
| C1_FRAGMENTS_HUNT | Primo frammento raccolto o step impostato | Raccogliere tutti e 4 i frammenti | AllFragmentsCollected | C1_ENVELOPE_READY |
| C1_ENVELOPE_READY | 4 frammenti raccolti | Ricomporre e leggere la lettera | EnvelopeRebuilt | C1_RECIPIENT_PHASE |
| C1_RECIPIENT_PHASE | Lettera letta | Identificare Beppe come destinatario e parlare con Rosa/Beppe | RecipientConfirmedAndBothTalksDone? No, first RecipientConfirmed | C1_RECIPIENT_PHASE resta fino a spoke_to_rosa && spoke_to_beppe |
| C1_DELIVERY_SETUP | recipient_guess_beppe && spoke_to_rosa && spoke_to_beppe | Recuperare chiave e aprire la porta laterale | SideDoorOpened | C1_DAWN_READY |
| C1_DAWN_READY | bakery_side_door_open | Entrare nell'area payoff o attendere auto-trigger controllato | DawnSceneTrigger | C1_COMPLETE |
| C1_COMPLETE | DawnScenePlayed | Osservare world-state change | Nessuno | Nessuno |

Nota implementativa:
Per semplificare lo scripting, `C1_RECIPIENT_PHASE` puo essere usato fino a quando il giocatore ha identificato il destinatario ma non ha ancora completato entrambi i dialoghi. Quando `recipient_guess_beppe && spoke_to_rosa && spoke_to_beppe` diventa true, forzare `c1_step = C1_DELIVERY_SETUP`.

## 6. Event catalog

| Event ID | Trigger source | Condizione | Effetto |
| --- | --- | --- | --- |
| StartGame | Sistema | Nuova partita | c1_step = C1_PROLOGUE_ACTIVE |
| ExitOfficeDoor | Interazione porta | c1_step = C1_PROLOGUE_ACTIVE | prologue_seen = true; c1_step = C1_STAR_REVEALED |
| FirstStarInspect | Interazione VFX stella | c1_step = C1_STAR_REVEALED | first_star_seen = true; fragment_1_collected = true; c1_step = C1_FRAGMENTS_HUNT |
| FragmentCollected | Interazione frammento | c1_step >= C1_FRAGMENTS_HUNT | Set relativo flag true; controlla totale |
| AllFragmentsCollected | Sistema | 4 frammenti true | c1_step = C1_ENVELOPE_READY; objective = Ricomponi la busta |
| EnvelopeRebuilt | Esito puzzle | c1_step = C1_ENVELOPE_READY | envelope_rebuilt = true; c1_step = C1_RECIPIENT_PHASE |
| RecipientConfirmed | UI deduzione | envelope_rebuilt = true e scelta corretta | recipient_guess_beppe = true; objective = Parla con Rosa |
| TalkedToRosa | Fine dialogo Rosa | recipient_guess_beppe = true | spoke_to_rosa = true |
| TalkedToBeppe | Fine dialogo Beppe | recipient_guess_beppe = true | spoke_to_beppe = true |
| DeliverySetupReady | Sistema | recipient_guess_beppe && spoke_to_rosa && spoke_to_beppe | c1_step = C1_DELIVERY_SETUP; objective = Apri la porta laterale |
| SideKeyFound | Interazione cassa blu | c1_step = C1_DELIVERY_SETUP | side_key_found = true |
| SideDoorOpened | Interazione porta | side_key_found = true | bakery_side_door_open = true; c1_step = C1_DAWN_READY |
| DawnSceneTrigger | Trigger volume o interact sul forno | c1_step = C1_DAWN_READY | play scene C1_VS_S11 |
| DawnSceneComplete | Fine sequenza | scena C1_VS_S11 completata | dawn_scene_played = true; bakery_lit = true; ferry_shortcut_unlocked = true; c1_step = C1_COMPLETE |

## 7. Objective mapping

| Condizione | Objective text |
| --- | --- |
| c1_step = C1_PROLOGUE_ACTIVE | Chiudi l'ufficio e torna a casa |
| c1_step = C1_STAR_REVEALED | Raggiungi la luce sopra il forno |
| c1_step = C1_FRAGMENTS_HUNT | Raccogli i frammenti della lettera |
| c1_step = C1_ENVELOPE_READY | Ricomponi la busta |
| c1_step = C1_RECIPIENT_PHASE && !recipient_guess_beppe | Capisci a chi appartiene |
| c1_step = C1_RECIPIENT_PHASE && recipient_guess_beppe && !spoke_to_rosa | Parla con Rosa |
| c1_step = C1_RECIPIENT_PHASE && recipient_guess_beppe && spoke_to_rosa && !spoke_to_beppe | Parla con Beppe |
| c1_step = C1_DELIVERY_SETUP && !side_key_found | Cerca la chiave sotto la cassa blu |
| c1_step = C1_DELIVERY_SETUP && side_key_found && !bakery_side_door_open | Apri la porta laterale del forno |
| c1_step = C1_DAWN_READY | Torna al forno prima dell'alba |
| c1_step = C1_COMPLETE | Il forno e di nuovo acceso |

## 8. Interactables e condizioni di accesso

| Interactable ID | Disponibile quando | Esito |
| --- | --- | --- |
| office_exit_door | C1_PROLOGUE_ACTIVE | Trigger ExitOfficeDoor |
| first_star_fx | C1_STAR_REVEALED | Trigger FirstStarInspect |
| fragment_2_node | C1_FRAGMENTS_HUNT | Trigger FragmentCollected |
| fragment_3_node | C1_FRAGMENTS_HUNT | Trigger FragmentCollected |
| fragment_4_node | C1_FRAGMENTS_HUNT | Trigger FragmentCollected |
| envelope_puzzle_station | C1_ENVELOPE_READY | Trigger EnvelopeRebuilt |
| deduction_ui_node | C1_RECIPIENT_PHASE && !recipient_guess_beppe | Trigger RecipientConfirmed |
| rosa_dialogue_node | C1_RECIPIENT_PHASE && recipient_guess_beppe | Trigger TalkedToRosa |
| beppe_dialogue_node | C1_RECIPIENT_PHASE && recipient_guess_beppe | Trigger TalkedToBeppe |
| blue_crate_key_node | C1_DELIVERY_SETUP && !side_key_found | Trigger SideKeyFound |
| bakery_side_door | C1_DELIVERY_SETUP && side_key_found | Trigger SideDoorOpened |
| dawn_trigger_volume | C1_DAWN_READY | Trigger DawnSceneTrigger |

## 9. NPC behavior matrix

### Rosa
| Stato | Posizione | Disponibilita dialogo | Nota |
| --- | --- | --- | --- |
| Pre-lettera | Forno, distante dal banco | Bassa | Risponde in modo operativo |
| Recipient phase | Forno | Alta | Dialogo chiave disponibile |
| Delivery setup | Forno interno, meno rigida | Bassa | Solo bark brevi |
| Complete | Forno acceso / piazza presto | Media | Nuova routine attiva |

### Beppe
| Stato | Posizione | Disponibilita dialogo | Nota |
| --- | --- | --- | --- |
| Pre-lettera | Molo | Bassa | Brevi linee asciutte |
| Recipient phase | Molo | Alta | Dialogo chiave disponibile |
| Delivery setup | Molo, pronto a muoversi | Bassa | Bark solo contestuale |
| Complete | Attraversa la piazza una volta | Media | Shortcut del traghetto attivo |

### Tilde
| Stato | Posizione | Disponibilita dialogo | Nota |
| --- | --- | --- | --- |
| Prologo | Ufficio postale | Alta | Solo scena introduttiva |
| Dopo prologo | Off-screen | Nessuna | Non deve rubare focus al capitolo |
| Complete | Eventuale linea finale opzionale in ufficio | Bassa | Solo stinger leggero se necessario |

## 10. Save / load rules

- Salvare `c1_step` e tutte le flags secondarie dopo ogni evento maggiore.
- Se un save viene caricato in `C1_ENVELOPE_READY`, i frammenti non devono essere piu visibili nel mondo.
- Se un save viene caricato in `C1_DELIVERY_SETUP`, Rosa e Beppe devono avere gia consumato i dialoghi chiave.
- Se un save viene caricato in `C1_COMPLETE`, il forno deve risultare acceso, il shortcut sbloccato e la scena d'alba non deve ripetersi.

## 11. Anti soft-lock rules

- Se il giocatore lascia il molo senza vedere la cassa blu, il journal/objective deve comunque nominare la cassa blu dopo la ricomposizione lettera.
- Se il giocatore identifica il destinatario ma incontra prima Beppe di Rosa, il flow deve restare valido.
- Se il giocatore apre la porta laterale e lascia l'area, il trigger d'alba deve restare disponibile al rientro.
- Nessun dialogo chiave deve potersi ripetere in versione completa piu di una volta; dopo la prima esecuzione usare barks brevi.

## 12. Pseudoflow di implementazione

```text
StartGame
 -> C1_PROLOGUE_ACTIVE
 -> ExitOfficeDoor
 -> C1_STAR_REVEALED
 -> FirstStarInspect
 -> C1_FRAGMENTS_HUNT
 -> Collect fragments 2/3/4
 -> AllFragmentsCollected
 -> C1_ENVELOPE_READY
 -> EnvelopeRebuilt
 -> C1_RECIPIENT_PHASE
 -> RecipientConfirmed(Beppe)
 -> TalkedToRosa
 -> TalkedToBeppe
 -> DeliverySetupReady
 -> SideKeyFound
 -> SideDoorOpened
 -> C1_DAWN_READY
 -> DawnSceneTrigger
 -> DawnSceneComplete
 -> C1_COMPLETE
```

## 13. Test cases minimi

| ID | Scenario | Risultato atteso |
| --- | --- | --- |
| TC-01 | Nuova partita -> uscita dall'ufficio | La stella compare sopra il forno |
| TC-02 | Raccolta di tutti i frammenti | Si sblocca ricomposizione busta |
| TC-03 | Scelta destinatario errata | Feedback contestuale senza blocco |
| TC-04 | Parlare con Beppe prima di Rosa | Il capitolo resta completabile |
| TC-05 | Aprire porta laterale e ricaricare save | Lo stato resta coerente |
| TC-06 | Fine payoff e reload area | Forno acceso e shortcut attivo |
| TC-07 | Riattivare trigger scena finale dopo complete | La scena non si ripete |

## 14. Decisioni bloccate in questa spec

- Il destinatario corretto della prima lettera e sempre Beppe Ferri.
- La scena d'alba e non interattiva o semi-interattiva, ma non fallibile.
- Il world-state change finale del slice e composto da 3 segnali obbligatori: forno acceso, shortcut attivo, nuova routine di Beppe.
