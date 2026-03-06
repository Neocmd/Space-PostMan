# Il Postino delle Stelle - Narrative Docs Index

Ordine consigliato di lettura e uso operativo per il pacchetto narrativo.
Per l'indice completo di produzione e tecnica vedi anche [Docs Index](../README.md).

## Documenti disponibili

1. [Foundation Pack](../../FOUNDATION_PACK_IL_POSTINO_DELLE_STELLE.md)
   Base narrativa del progetto: audit, pillars, struttura generale, personaggi, loop, finali, backlog e rischi.

2. [Chapter Cards](./CHAPTER_CARDS.md)
   Documento di produzione per design e scripting dei 5 capitoli.

3. [Lettere Cardine](./LETTERE_CARDINE.md)
   Testo finale e regia delle 5 lettere principali.

4. [Vertical Slice Capitolo 1](./VERTICAL_SLICE_CAPITOLO_1.md)
   Documento implementativo per il primo slice giocabile.

5. [Vertical Slice Backlog](./VERTICAL_SLICE_BACKLOG.md)
   Task backlog per production, narrative, design, engineering, art, audio, QA e playtest.

6. [C1 States and Triggers](./C1_STATES_AND_TRIGGERS.md)
   Spec tecnica di progression, flags, trigger, save/load e anti soft-lock del Capitolo 1.

7. [C1 Runtime Strings](./C1_RUNTIME_STRINGS.csv)
   Pacchetto CSV con objective text, UI labels, system toasts, bark, dialoghi e lettera 1 pronto per import.

## Ordine di lavoro consigliato

1. Allineare team su `FOUNDATION_PACK_IL_POSTINO_DELLE_STELLE.md`.
2. Spezzare `VERTICAL_SLICE_BACKLOG.md` in task effettivi di sprint.
3. Implementare flow e flags usando `C1_STATES_AND_TRIGGERS.md`.
4. Collegare UI/dialog system e importare `C1_RUNTIME_STRINGS.csv` o i dati separati in `data/`.
5. Implementare il contenuto del primo capitolo usando `VERTICAL_SLICE_CAPITOLO_1.md` e `LETTERE_CARDINE.md`.
6. Solo dopo il playtest del vertical slice, procedere con capitoli 2-5.

## Decisioni gia bloccate

- Protagonista: Nico Sera, adolescente apprendista postino.
- Villaggio: Rivaquieta.
- Struttura: 5 capitoli.
- Lettere-cardine: 5.
- Finale: aperto sul fantastico, chiaro sul piano emotivo.
- Lettera 4 e lettera 5: oggetti distinti.
- Capitolo 1: include prologo giocabile breve.
- Il destinatario corretto della prima lettera e sempre Beppe Ferri.
- Il vertical slice termina con un world-state change obbligatorio: forno acceso, shortcut del traghetto, nuova routine di Beppe.
