# Il Postino delle Stelle - Vertical Slice Backlog

Backlog operativo per avviare sviluppo concreto del vertical slice del Capitolo 1 `Pane caldo`.

## 1. Obiettivo

Tradurre il pacchetto narrativo in task eseguibili da un team indie piccolo, mantenendo il focus su:

- 1 capitolo giocabile completo.
- 1 loop base completo.
- 1 payoff emotivo leggibile.
- 1 world-state change persistente.
- 1 slice abbastanza solido da validare il progetto prima di espandere i capitoli 2-5.

## 2. Assunzioni operative

- Engine e toolchain non sono ancora bloccati, quindi il backlog resta engine-agnostic.
- Il target del primo sprint non e polishing, ma `playable end-to-end`.
- Il contenuto di riferimento e quello gia definito in `FOUNDATION_PACK_IL_POSTINO_DELLE_STELLE.md`, `CHAPTER_CARDS.md`, `LETTERE_CARDINE.md` e `VERTICAL_SLICE_CAPITOLO_1.md`.
- Il vertical slice copre solo il Capitolo 1 e non include lettere minori o sistemi meta.

## 3. Milestone consigliate

### M0 - Alignment Pack
Obiettivo: team allineato su scope, tono e formato dati.

Definition of done:
- Backlog approvato.
- State machine del Capitolo 1 approvata.
- Pacchetto stringhe importabile approvato.

### M1 - Greybox Playable
Obiettivo: capitolo completabile dall'inizio alla fine con placeholder grafici e audio minimi.

Definition of done:
- Tutti i trigger funzionano.
- Il giocatore puo finire il capitolo senza blocchi.
- I flag persistono correttamente al reload.

### M2 - First Content Pass
Obiettivo: inserire contenuti finali principali e world-state change.

Definition of done:
- Lettera 1 finale implementata.
- Dialoghi chiave implementati.
- Forno acceso e shortcut traghetto visibili nel post-payoff.

### M3 - Slice Polish + Playtest
Obiettivo: validare tono, ritmo e leggibilita mobile.

Definition of done:
- Playtest interno completato.
- Top 5 problemi di leggibilita o pacing risolti.
- Decisione go/no-go su espansione capitoli 2-5.

## 4. Task backlog per disciplina

| ID | Milestone | Disciplina | Task | Output atteso | Dipendenze | Stima | Priorita |
| --- | --- | --- | --- | --- | --- | --- | --- |
| PROD-01 | M0 | Production | Confermare scope del vertical slice e tagliati fuori espliciti | Lista scope in/out firmata dal team | Nessuna | S | Alta |
| PROD-02 | M0 | Production | Definire naming convention per scene, flags, string IDs, assets | Mini standard condiviso | PROD-01 | S | Alta |
| NAR-01 | M0 | Narrative | Rifinire script runtime di C1 con taglio da implementazione | Script scene stabile | Nessuna | S | Alta |
| NAR-02 | M0 | Narrative | Validare lettera cardine 1 e frammentazione | Testo lettera + 4 frammenti approvati | Nessuna | S | Alta |
| NAR-03 | M0 | Narrative | Approvare bark set minimo pre/post payoff | Lista barks pronta | NAR-01 | S | Media |
| DES-01 | M0 | Design | Definire flow del loop per il Capitolo 1 | Diagramma step-by-step | Nessuna | S | Alta |
| DES-02 | M0 | Design | Definire le regole di deduzione destinatario | Logic flow e fallback UX | DES-01 | S | Alta |
| DES-03 | M0 | Design | Definire failure-soft dei 3 sistemi base | Specifica di retry e hint | DES-01 | S | Alta |
| ENG-01 | M1 | Engineering | Implementare sistema objective text base | UI objective funzionante | PROD-02 | M | Alta |
| ENG-02 | M1 | Engineering | Implementare raccolta frammenti | Interazione + salvataggio frammenti | PROD-02 | M | Alta |
| ENG-03 | M1 | Engineering | Implementare scia luminosa guidata | Sequenza follow path stabile | ENG-02 | M | Alta |
| ENG-04 | M1 | Engineering | Implementare puzzle ricomposizione busta | Minigame base completabile | ENG-02 | M | Alta |
| ENG-05 | M1 | Engineering | Implementare scelta destinatario con feedback contestuale | UI deduzione funzionante | DES-02 | M | Alta |
| ENG-06 | M1 | Engineering | Implementare state machine del Capitolo 1 | Avanzamento chapter robusto | DES-01, PROD-02 | M | Alta |
| ENG-07 | M1 | Engineering | Implementare sistema dialoghi runtime base | Balloon, speaker, next, skip | PROD-02 | M | Alta |
| ENG-08 | M1 | Engineering | Implementare save/load minimo per flags del capitolo | Ripresa corretta del progresso | ENG-06 | M | Alta |
| ENG-09 | M1 | Engineering | Implementare gating per scena d'alba | Trigger finale robusto | ENG-06, ENG-07 | S | Alta |
| ART-01 | M1 | Art | Greybox mappa slice con 5 aree | Layout navigabile | DES-01 | M | Alta |
| ART-02 | M1 | Art | Placeholder props chiave: cassa blu, porta, forno, banco | Props leggibili | ART-01 | S | Alta |
| ART-03 | M1 | Art | Leggibilita visiva della stella e della scia | FX placeholder leggibili | ENG-03 | S | Alta |
| UI-01 | M1 | UI | Layout base per objective, hint, lettera e dialogo | Template integrati | ENG-01, ENG-07 | M | Alta |
| UI-02 | M1 | UI | Schermata lettera completa + frammenti | UI leggibile su mobile | ENG-04 | M | Alta |
| NAR-04 | M2 | Narrative | Implementare testi finali in runtime strings | CSV o DB importato | ENG-07 | S | Alta |
| NAR-05 | M2 | Narrative | Rifinire timing pause e staging della scena finale | Script con timing note | NAR-01 | S | Media |
| ART-04 | M2 | Art | Primo pass pixel art per 5 aree slice | Visual set coerente | ART-01 | L | Alta |
| ART-05 | M2 | Art | Variante world-state post-payoff forno acceso | Mappa prima/dopo | ART-04 | M | Alta |
| ART-06 | M2 | Art | Lighting pass alba | Mood finale leggibile | ART-04 | M | Media |
| ANIM-01 | M2 | Animation | Microanimazioni: stella, vapore forno, Beppe in piazza | Feedback di vita | ART-04 | M | Media |
| AUD-01 | M2 | Audio | Cue base raccolta frammento, scia, forno, acqua molo | Set audio minimo | Nessuna | S | Alta |
| AUD-02 | M2 | Audio | Layer ambiente pre/post payoff | Due stati sonori distinti | AUD-01 | S | Media |
| ENG-10 | M2 | Engineering | Collegare world-state change a mappa e NPC routines | Forno acceso + shortcut + path NPC | ENG-06, ART-05 | M | Alta |
| ENG-11 | M2 | Engineering | Import pipeline per runtime strings | Lettura da CSV o formato scelto | NAR-04 | M | Alta |
| QA-01 | M2 | QA | Smoke test del capitolo completabile | Lista bug bloccanti | ENG-10 | S | Alta |
| QA-02 | M2 | QA | Test leggibilita UI mobile | Report overflow e pacing | UI-02, NAR-04 | S | Alta |
| PT-01 | M3 | Playtest | Primo playtest interno con 3-5 tester | Note qualitative | QA-01, QA-02 | S | Alta |
| PT-02 | M3 | Playtest | Analisi dei punti morti nel flow | Lista friction points | PT-01 | S | Alta |
| ENG-12 | M3 | Engineering | Fix top issue di flow o blocco emerso dal playtest | Build piu stabile | PT-02 | M | Alta |
| NAR-06 | M3 | Narrative | Taglio o riscrittura linee troppo lunghe o poco chiare | Script finale slice | PT-01 | S | Media |
| UI-03 | M3 | UI | Polish leggibilita balloon e lettera su schermo piccolo | UI piu pulita | QA-02 | S | Media |
| PROD-03 | M3 | Production | Review go/no-go per espansione capitoli successivi | Decisione produzione | PT-01, ENG-12 | S | Alta |

## 5. Ordine di esecuzione raccomandato

### Settimana / Sprint 1
- PROD-01
- PROD-02
- NAR-01
- NAR-02
- DES-01
- DES-02
- DES-03
- ART-01

### Settimana / Sprint 2
- ENG-01 -> ENG-09
- UI-01
- UI-02
- ART-02
- ART-03

### Settimana / Sprint 3
- NAR-04
- ART-04
- ART-05
- AUD-01
- AUD-02
- ENG-10
- ENG-11

### Settimana / Sprint 4
- QA-01
- QA-02
- PT-01
- PT-02
- ENG-12
- NAR-06
- UI-03
- PROD-03

## 6. Dipendenze critiche da non invertire

- Non partire col polish art prima che la state machine sia stabile.
- Non fare playtest qualitativo prima che il capitolo sia completabile end-to-end.
- Non espandere i contenuti al Capitolo 2 prima della review `PROD-03`.
- Non legare la pipeline stringhe a un sistema troppo complesso: per il slice basta un import semplice e robusto.

## 7. Rischi operativi e contromisure

| Rischio | Effetto | Contromisura |
| --- | --- | --- |
| Il team costruisce tool prima del gioco | Ritardo senza validazione del concept | Usare pipeline minima per il slice |
| Il dialog system viene pensato per tutto il gioco | Overengineering | Supportare solo il necessario per C1 |
| Il puzzle di deduzione e poco chiaro | Blocchi e frustrazione | Usare un solo destinatario corretto e feedback contestuale |
| Il post-payoff non cambia abbastanza il mondo | Reward debole | Rendere subito visibili luce, vapore, shortcut e nuova routine NPC |
| L'asset load del slice cresce troppo | Ritardo art | Limitare la mappa a 5 aree e 2 stati visivi principali |

## 8. Definition of ready per partire davvero

Il team puo iniziare lo sviluppo concreto quando questi elementi sono presenti e approvati:

- `VERTICAL_SLICE_CAPITOLO_1.md`
- `CHAPTER_CARDS.md`
- `LETTERE_CARDINE.md`
- `C1_STATES_AND_TRIGGERS.md`
- `C1_RUNTIME_STRINGS.csv`

Se manca uno di questi cinque artefatti, il rischio di interpretazioni divergenti sale troppo per un team piccolo.
