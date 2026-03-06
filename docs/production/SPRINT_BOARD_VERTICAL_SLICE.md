# Il Postino delle Stelle - Vertical Slice Sprint Board

Board operativa derivata da `docs/narrative/VERTICAL_SLICE_BACKLOG.md`.
Assunzione di team minimo consigliato:

- 1 game designer / scripter
- 1 programmer gameplay
- 1 pixel artist generalista
- 1 narrative designer / writer
- 1 supporto audio part-time

## Regole di uso della board

- Ogni ticket deve chiudersi con un output verificabile, non con attivita generiche.
- Nessun ticket di polish prima che il capitolo sia completabile end-to-end.
- Se un ticket apre dipendenze nuove fuori scope, va congelato e discusso prima di entrare in sprint.

## Sprint 0 - Alignment e formato dati

### Goal
Bloccare naming, flow, stringhe e struttura dei dati prima di iniziare l'implementazione del slice.

### Exit criteria
- Tutti i documenti chiave sono approvati.
- State machine C1 e string pack C1 sono considerati stabili.
- Il team condivide naming convention unica.

| Ticket | Owner | Output verificabile | Dipendenze | Stima | Priorita |
| --- | --- | --- | --- | --- | --- |
| S0-01 Scope lock del vertical slice | Production | Lista scope in/out approvata | Nessuna | 0.5g | Alta |
| S0-02 Naming convention scene/flags/strings/assets | Production + Engineering | Documento naming firmato | S0-01 | 0.5g | Alta |
| S0-03 Review script runtime Capitolo 1 | Narrative | Script C1 validato | Nessuna | 0.5g | Alta |
| S0-04 Review lettera 1 e frammenti | Narrative | Testo definitivo approvato | Nessuna | 0.5g | Alta |
| S0-05 Flow del loop C1 | Design | Diagramma flow approvato | Nessuna | 0.5g | Alta |
| S0-06 Regole di deduzione destinatario | Design | Specifica UX e fallback | S0-05 | 0.5g | Alta |
| S0-07 Failure-soft systems | Design | Regole retry + hint | S0-05 | 0.5g | Alta |
| S0-08 Setup cartelle dati e convenzioni import | Engineering | Struttura repo pronta | S0-02 | 0.5g | Media |

## Sprint 1 - Playable greybox

### Goal
Ottenere una run end-to-end del Capitolo 1 con placeholder funzionali.

### Exit criteria
- Il capitolo e completabile.
- Le transizioni di stato sono corrette.
- Il giocatore vede raccolta, ricomposizione, deduzione e payoff.

| Ticket | Owner | Output verificabile | Dipendenze | Stima | Priorita |
| --- | --- | --- | --- | --- | --- |
| S1-01 Greybox mappa 5 aree | Art + Design | Layout navigabile | S0-05 | 1g | Alta |
| S1-02 Objective system base | Engineering | Objective text aggiornabile runtime | S0-02 | 1g | Alta |
| S1-03 Dialogue runner base | Engineering | Balloon system con next/skip | S0-02 | 1g | Alta |
| S1-04 Collectible fragment system | Engineering | 4 frammenti raccoglibili | S0-02 | 1g | Alta |
| S1-05 Star trail system | Engineering | Scia luminosa followable | S1-04 | 1g | Alta |
| S1-06 Envelope puzzle base | Engineering | Puzzle ricomposizione funzionante | S1-04 | 1.5g | Alta |
| S1-07 Recipient deduction UI | Engineering + UI | Schermata deduzione completa | S0-06 | 1g | Alta |
| S1-08 C1 state machine base | Engineering | Progression stabile da start a complete | S0-05, S0-02 | 1.5g | Alta |
| S1-09 Trigger scena alba | Engineering | Gating finale funzionante | S1-08 | 0.5g | Alta |
| S1-10 Placeholder props chiave | Art | Cassa blu, forno, porta, banco | S1-01 | 1g | Alta |
| S1-11 UI lettera e hint | UI | Mock o implementazione leggibile su mobile | S1-03, S1-06 | 1g | Alta |
| S1-12 Smoke run interna | QA / Team | Prima run completa documentata | S1-01..S1-11 | 0.5g | Alta |

## Sprint 2 - First content pass

### Goal
Sostituire placeholder con contenuto reale nei punti che definiscono il tono e il payoff del slice.

### Exit criteria
- Lettera 1 e dialoghi chiave sono in gioco.
- Il world-state change e visibile.
- Il mood del capitolo e leggibile senza spiegazioni esterne.

| Ticket | Owner | Output verificabile | Dipendenze | Stima | Priorita |
| --- | --- | --- | --- | --- | --- |
| S2-01 Import runtime strings | Engineering | Import CSV separati funzionante | S1-03, S1-11 | 0.5g | Alta |
| S2-02 Hook dialogues C1 | Narrative + Engineering | Scene C1_VS_S01, S08, S09, S11 attive | S2-01 | 1g | Alta |
| S2-03 Hook lettera 1 e frammenti | Narrative + Engineering | Lettera leggibile in UI | S2-01 | 0.5g | Alta |
| S2-04 First art pass delle 5 aree | Art | Slice visivamente coerente | S1-01 | 2g | Alta |
| S2-05 Variante post-payoff forno acceso | Art | Stato prima/dopo visibile | S2-04 | 1g | Alta |
| S2-06 Routine Beppe post-payoff | Engineering | Path e presenza in piazza funzionanti | S1-08 | 0.5g | Media |
| S2-07 Shortcut traghetto attivo | Engineering + Design | Shortcut giocabile post-payoff | S1-08 | 0.5g | Media |
| S2-08 Audio cue base | Audio | Raccolta, scia, molo, forno | Nessuna | 0.5g | Media |
| S2-09 Ambiente pre/post payoff | Audio | Due mix distinti | S2-08 | 0.5g | Media |
| S2-10 Lighting pass alba | Art | Mood finale leggibile | S2-04 | 0.5g | Media |
| S2-11 QA leggibilita UI mobile | QA | Bug list testi e overflow | S2-01 | 0.5g | Alta |

## Sprint 3 - Validation e go/no-go

### Goal
Testare il vertical slice con occhi freschi, ridurre gli attriti e decidere se il progetto regge la produzione completa.

### Exit criteria
- 3-5 playtest interni completati.
- Top issue sistemate o accettate consapevolmente.
- Decisione go/no-go su espansione contenuti.

| Ticket | Owner | Output verificabile | Dipendenze | Stima | Priorita |
| --- | --- | --- | --- | --- | --- |
| S3-01 Playtest script e questionario | Production + Narrative | Template playtest pronto | S2 complete | 0.5g | Alta |
| S3-02 3-5 playtest interni | Team | Note raccolte | S3-01 | 1g | Alta |
| S3-03 Analisi friction points | Design + Engineering | Lista problemi ordinata per severita | S3-02 | 0.5g | Alta |
| S3-04 Fix top 5 problemi | Engineering + Narrative + UI | Build migliorata | S3-03 | 1.5g | Alta |
| S3-05 Review tono e pacing | Narrative | Tagli o revisioni script | S3-02 | 0.5g | Media |
| S3-06 Review go/no-go | Production | Decisione su espansione | S3-04, S3-05 | 0.5g | Alta |

## Bucket Kanban suggeriti

- Backlog
- Ready
- In progress
- Review
- Blocked
- Done

## Ticket che non devono entrare prima del go/no-go

- Capitolo 2 completo
- Sistema archivio lettere globale
- Save system esteso oltre il necessario per C1
- Tool proprietari di narrative editing
- Ottimizzazione art/audio non necessaria al slice

## Criterio di priorita assoluta

Se due task competono, vince sempre quello che aumenta la probabilita di una run completa e leggibile del Capitolo 1.
