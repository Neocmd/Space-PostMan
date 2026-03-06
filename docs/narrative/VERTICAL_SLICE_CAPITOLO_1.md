# Il Postino delle Stelle - Vertical Slice Narrativo Capitolo 1

Documento di riferimento per implementare un vertical slice completo del Capitolo 1: `Pane caldo`.

## 1. Obiettivo del vertical slice

### Perche funziona
Il primo slice deve validare il cuore del gioco, non tutta la sua estensione. Se tono, loop e payoff del Capitolo 1 funzionano, il resto del progetto ha una base concreta.

### Output
Questo slice deve validare cinque cose:

- Il loop `notte -> raccolta -> deduzione -> consegna -> world change`.
- La leggibilita del tono su mobile con testi brevi.
- La tenuta di un piccolo payoff emotivo senza cinematics lunghe.
- La leggibilita del villaggio come spazio piccolo ma memorabile.
- La sostenibilita di puzzle semplici ma tematici.

### Success criteria del slice
- Un playtest interno deve capire il gioco senza tutorial testuali lunghi.
- Il payoff tra Rosa e Beppe deve essere compreso senza spiegazioni aggiuntive.
- Il world change finale deve essere visto e percepito come reward.

## 2. Scope del vertical slice

### In scope
- Prologo giocabile molto breve.
- Mappa ridotta con 5 aree connesse.
- 1 lettera-cardine completa.
- 3 sistemi di base: raccolta, ricomposizione, deduzione.
- 1 consegna facilitata non diretta.
- 1 world-state change persistente.
- 4 scene dialogate principali.
- 1 scena finale quasi muta.

### Out of scope
- Archivio lettere completo.
- Lettere minori.
- Campanile, locanda, serra.
- Sistemi di scelta ramificata.
- Voice over esteso.
- Mappa completa del villaggio.

## 3. Mappa e contenuti minimi

### Area giocabile
- Ufficio Postale interno ed esterno.
- Piazza del Pozzo.
- Forno Ferri esterno e retro.
- Vicolo corto verso il molo.
- Molo Vecchio.

### NPC presenti
- Nico.
- Tilde.
- Rosa.
- Beppe.
- 2 villager di sfondo con 1 bark ciascuno post-payoff.

### Props fondamentali
- Insegna del forno.
- Cassa blu sul molo.
- Porta laterale del forno.
- Banco del forno.
- Sacchi di farina.
- Tavolino o panca per la colazione all'alba.
- Banco di smistamento all'ufficio postale.

## 4. Loop di slice e durata target

| Fase | Contenuto | Durata target |
| --- | --- | --- |
| Prologo | Ufficio postale, uscita in piazza, prima luce | 3-4 min |
| Notte | Raccolta frammenti tra forno e molo | 5-7 min |
| Mattino | Ricomposizione e deduzione del destinatario | 4-5 min |
| Giorno | Confronto con Rosa e Beppe, apertura porta laterale | 5-7 min |
| Alba | Payoff visivo ed emotivo, world-state change | 2-3 min |

Playtime totale target: 19-26 minuti.

## 5. Flag di stato e requisiti di scripting

### Flag minimi
- prologue_seen
- first_star_seen
- fragment_1_collected
- fragment_2_collected
- fragment_3_collected
- fragment_4_collected
- envelope_rebuilt
- recipient_guess_beppe
- side_key_found
- bakery_side_door_open
- beppe_prompted
- dawn_scene_played
- bakery_lit
- ferry_shortcut_unlocked

### Regole di scripting
- La prima stella compare solo dopo l'uscita dall'ufficio postale.
- La ricomposizione si sblocca solo dopo 4 frammenti.
- Il confronto con Rosa puo avvenire prima o dopo aver parlato con Beppe, ma la scena d'alba richiede entrambe le interazioni e la porta aperta.
- Dopo il payoff, il villaggio deve ricaricare nello stato aggiornato senza cambiare area esterna principale.

## 6. Obiettivi UI del slice

Ordine consigliato per objective text a schermo:

1. `Chiudi l'ufficio e torna a casa`
2. `Raggiungi la luce sopra il forno`
3. `Raccogli i frammenti della lettera`
4. `Segui la scia verso il molo`
5. `Ricomponi la busta`
6. `Capisci a chi appartiene`
7. `Parla con Rosa`
8. `Parla con Beppe`
9. `Apri la porta laterale del forno`
10. `Torna al forno prima dell'alba`

Hint massimi consentiti:
- 1 hint per raccolta.
- 1 hint per ricomposizione.
- 1 hint per deduzione se il giocatore sbaglia il destinatario.

## 7. Beat sheet completo

### C1_VS_S01 - Prologo all'ufficio postale
- Trigger: start game.
- Luogo: interno ufficio postale.
- Durata: 60-90 secondi.
- Funzione: introdurre Nico, Tilde e il tono del villaggio senza exposition.
- Azione giocatore: camminare, interagire con 2 punti, uscire.

Dialogo draft:

Tilde: "Basta per stanotte. Il resto puo aspettare domani."
Nico: "Rosa voleva la ricevuta della farina."
Tilde: "Rosa vuole sempre qualcosa prima dell'alba."
Nico: "La porto domani."
Tilde: "Chiudi bene, allora. Questo paese perde tutto tranne le abitudini."

Note:
- Tilde deve risultare pratica, non misteriosa.
- Nessuna menzione alle lettere-stella.

### C1_VS_S02 - La prima luce
- Trigger: uscita in piazza.
- Luogo: piazza vista forno.
- Durata: 20-30 secondi.
- Funzione: prima apparizione del fantastico.
- Azione giocatore: fermarsi, guardare, raggiungere il forno.

Testo breve di Nico:
"Quella non era una lanterna."

Note:
- Nessun altro NPC reagisce.
- L'effetto visivo deve essere chiaro ma piccolo.

### C1_VS_S03 - Primo frammento sul forno
- Trigger: interazione con luce sull'insegna.
- Luogo: esterno Forno Ferri.
- Durata: 30-45 secondi.
- Funzione: insegnare raccolta frammento.
- Azione giocatore: tocco o avvicinamento, raccolta primo frammento.

UI text:
`Hai trovato un frammento di lettera.`

### C1_VS_S04 - Scia verso il vicolo
- Trigger: raccolta primo frammento.
- Luogo: retro forno -> vicolo.
- Durata: 60-90 secondi.
- Funzione: insegnare la scia.
- Azione giocatore: seguire particelle luminose fino al molo.

Hint eventuale:
`Le scie si vedono meglio se ti fermi un istante.`

### C1_VS_S05 - Cassa blu sul molo
- Trigger: arrivo al molo.
- Luogo: Molo Vecchio.
- Durata: 90-120 secondi.
- Funzione: raccogliere ultimi frammenti e introdurre l'oggetto chiave del capitolo.
- Azione giocatore: raccogliere frammenti, osservare cassa blu, notare spazio dove puo stare una chiave.

Dettaglio ambientale:
- La cassa blu deve essere riconoscibile anche da lontano.
- Una corda e una lampada rendono il molo memorabile con pochi asset.

### C1_VS_S06 - Ricomposizione e lettura
- Trigger: 4 frammenti raccolti.
- Luogo: banco di smistamento nell'ufficio postale o panchina in piazza.
- Durata: 2-3 minuti.
- Funzione: insegnare ricomposizione e mostrare la lettera completa.
- Azione giocatore: ricomporre 4 frammenti e leggere.

Letter text usato:
- Versione definitiva da `LETTERE_CARDINE.md`.

Feedback dopo ricomposizione:
`La lettera parla di pane, di una porta laterale e di una cassa blu.`

### C1_VS_S07 - Deduzione del destinatario
- Trigger: lettera ricomposta.
- Luogo: piazza / forno / molo.
- Durata: 2-3 minuti.
- Funzione: far capire che il giocatore deve osservare il villaggio.
- Azione giocatore: ispezionare forno e molo, poi scegliere il destinatario corretto.

Soluzione corretta:
- Destinatario: Beppe Ferri.

Feedback in caso di errore:
`La lettera conosce troppo bene il forno per essere destinata a chi ci entra tutti i giorni.`

### C1_VS_S08 - Confronto con Rosa
- Trigger: destinatario corretto identificato.
- Luogo: Forno Ferri.
- Durata: 1-2 minuti.
- Funzione: introdurre il rifiuto e il sottotesto familiare.
- Azione giocatore: parlare con Rosa.

Dialogo draft:

Nico: "Ho trovato una cosa tua."
Rosa: "Se e un conto, lascialo sul banco."
Nico: "Non e un conto."
Rosa: "Allora puo aspettare."
Nico: "Parla della porta laterale."
Rosa: "Mezza Rivaquieta conosce quella porta."
Nico: "La chiave e ancora sotto la cassa blu."
Rosa: "..."
Rosa: "Se lo vedi, digli solo che il forno apre prima domani."

Note:
- Rosa non deve ringraziare Nico.
- La pausa dopo la chiave e il primo vero cedimento del capitolo.

### C1_VS_S09 - Confronto con Beppe
- Trigger: dopo Rosa.
- Luogo: molo.
- Durata: 1-2 minuti.
- Funzione: mostrare il lato speculare del conflitto.
- Azione giocatore: parlare con Beppe.

Dialogo draft:

Nico: "Rosa apre prima domani."
Beppe: "Allora il paese avra pane. Bella notizia."
Nico: "La chiave e ancora dov'era."
Beppe: "Doveva buttarla anni fa."
Nico: "Non l'ha fatto."
Beppe: "Rosa non butta via niente. Neanche quello che punge."
Nico: "La porta sara aperta."
Beppe: "Tu fai sempre il postino o solo coi testardi?"
Nico: "Solo quando non parlano."

Note:
- Beppe ha ironia asciutta, non amarezza teatrale.
- L'ultima battuta di Nico deve essere detta piano, quasi senza volerla spiegare.

### C1_VS_S10 - Chiave e porta laterale
- Trigger: dopo aver parlato con entrambi.
- Luogo: molo -> retro forno.
- Durata: 60-90 secondi.
- Funzione: trasformare la consegna in gesto pratico.
- Azione giocatore: recuperare la chiave sotto la cassa blu e aprire la porta laterale del forno.

UI text:
`La porta laterale e aperta.`

Note:
- Nessun puzzle nuovo.
- Il gesto deve sembrare piccolo ma decisivo.

### C1_VS_S11 - Colazione all'alba
- Trigger: porta aperta + confronti completati.
- Luogo: interno o retro Forno Ferri.
- Durata: 90-120 secondi.
- Funzione: payoff emotivo breve.
- Azione giocatore: entrare nello spazio e assistere.

Dialogo draft:

Rosa: "Si raffredda."
Beppe: "Lo so."
Rosa: "Ne ho fatto troppo."
Beppe: "Lo fai sempre."
Rosa: "Resta finche e caldo."
Beppe: "Per oggi posso."

Regia:
- Pausa lunga tra la quarta e la quinta battuta.
- Nico resta in campo ma non interviene.
- Il profumo del pane e la luce del forno portano la maggior parte del payoff.

### C1_VS_S12 - Epilogo di sistema
- Trigger: fine scena d'alba.
- Luogo: piazza e molo.
- Durata: 30-45 secondi.
- Funzione: mostrare il world-state change e chiudere il slice.
- Azione giocatore: breve controllo libero sul villaggio aggiornato.

Elementi visivi obbligatori:
- Camino del forno acceso.
- Shortcut del traghetto disponibile.
- Beppe attraversa la piazza una volta.
- Stinger con una stella lontana non raggiungibile.

## 8. Dialoghi secondari e bark minimi

### Barks pre-payoff
- Villager 1: "Il forno fa meno rumore del solito."
- Villager 2: "Beppe lavora anche al buio, ormai."

### Barks post-payoff
- Villager 1: "Hai sentito? Il pane oggi profuma da meta piazza."
- Villager 2: "Era da un po' che non vedevo Beppe passare di qui."
- Rosa, ambientale: "Non toccare quel vassoio. Quello resta li."
- Beppe, ambientale: "Prendo solo questo e torno al molo. Forse."

## 9. Audio, mood e regia

### Mood target
- Notte: quieta, non inquietante.
- Mattino: sospeso.
- Alba: calda, con sollievo trattenuto.

### Cue audio minimi
- Fruscio leggero della stella.
- Suono morbido di frammento raccolto.
- Legno e acqua al molo.
- Forno che si riaccende nel payoff.

### Regole di regia
- Niente camera troppo dinamica.
- Le scene emotive vanno sostenute da luce e pause, non da zoom aggressivi.
- La scena finale deve poter funzionare anche quasi muta.

## 10. Rischi del vertical slice e contromisure

| Rischio | Effetto | Contromisura |
| --- | --- | --- |
| Il slice sembra troppo semplice | Si perde la promessa del gioco | Dare grande cura a regia, dialoghi e world-state change |
| Il tutorial risulta invisibile al punto da non insegnare | Confusione nei primi minuti | Usare objective text brevi e 1 hint per sistema |
| Il payoff sembra troppo piccolo | L'emozione non arriva | Curare pausa, staging e ritorno del forno acceso |
| Rosa e Beppe sembrano stereotipi | Il tema perde autenticita | Tenere dialoghi concreti e non melodrammatici |

## 11. Checklist di produzione

### Narrative
- Finalizzare script scene C1_VS_S01, S08, S09, S11.
- Integrare lettera definitiva 1 in UI lettera e frammenti.
- Scrivere 4 barks ambientali finali.

### Design
- Implementare i 3 sistemi base del loop.
- Definire il flow di deduzione con 1 risposta corretta.
- Scripting di gate per la scena d'alba.

### Art
- Preparare 5 aree con due stati principali: prima e dopo payoff.
- Preparare props chiave: cassa blu, porta laterale, tavolo colazione, camino acceso.
- Preparare 1 variazione di luce per alba.

### Audio
- Preparare 4 cue minimi.
- Preparare layer di ambiente forno acceso vs forno spento.

### QA / Playtest
- Verificare che il destinatario corretto sia deducibile senza trial and error puro.
- Verificare che ogni scena si legga bene su schermo piccolo.
- Verificare tempo totale sotto i 26 minuti per run pulita.

## 12. Definizione di done del vertical slice

### Perche funziona
Chiude l'ambiguita operativa e consente al team di capire quando il primo capitolo e davvero pronto.

### Output
Il vertical slice del Capitolo 1 e `done` quando:

- Un giocatore nuovo completa il capitolo senza spiegazioni esterne.
- Comprende che Nico vede qualcosa che gli altri non vedono, senza bisogno di lore.
- Capisce che Rosa e Beppe si vogliono bene ma si sono irrigiditi nel silenzio.
- Vede almeno un cambiamento persistente nel villaggio dopo la consegna.
- Esce dal slice con curiosita per la prossima lettera e fiducia nella formula del gioco.
