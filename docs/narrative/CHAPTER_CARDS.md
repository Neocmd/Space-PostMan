# Il Postino delle Stelle - Chapter Cards

Documento operativo per design, writing, scripting e produzione contenuti.
Assunzioni bloccate in questa versione:

- E presente un prologo giocabile molto breve prima del Capitolo 1.
- La lettera 4 e la lettera 5 sono due oggetti distinti.
- Il giocatore puo rileggere le lettere-cardine nell'archivio dell'ufficio postale dopo averle completate.
- Le lettere minori non sono necessarie per il vertical slice.

## Standard di produzione

Ogni capitolo deve rispettare questi vincoli:

- Playtime target: 18-30 minuti per capitolo completo.
- Sessioni target: 3 blocchi da 5-10 minuti.
- Dialoghi per scena: massimo 6 scambi brevi nei momenti emotivi principali.
- Nuove meccaniche: nessuna meccanica completamente nuova dopo il Capitolo 3.
- World-state change: almeno 1 cambiamento visivo e 1 cambiamento di routine NPC.

## Chapter Card 1 - Pane caldo

### Sintesi
Primo capitolo e tutorial invisibile del gioco. Introduce il core loop, il tono e la promessa emotiva: una lettera non ripara tutto, ma puo riaprire una porta chiusa da troppo tempo.

### Obiettivo emotivo
Mostrare che il silenzio tra due persone che si vogliono bene puo diventare abitudine, e che basta una piccola consegna per interromperlo.

### Player promise
Il giocatore impara che esplorazione, deduzione e consegna hanno un payoff concreto sul villaggio.

### Durata e scala
- Durata target: 20-25 minuti.
- Sessione 1: prologo + prima raccolta.
- Sessione 2: ricomposizione e deduzione.
- Sessione 3: consegna facilitata e payoff.

### Luoghi richiesti
- Ufficio Postale.
- Piazza del Pozzo.
- Forno Ferri.
- Vicolo verso il molo.
- Molo Vecchio.

### NPC richiesti
- Nico.
- Tilde.
- Rosa.
- Beppe.
- 1-2 abitanti di background senza arco.

### Lettera-cardine
- Titolo: Il pane del mattino.
- Mittente: Rosa Ferri.
- Destinatario: Beppe Ferri.
- Tema: orgoglio tra fratelli.

### Stato iniziale del mondo
- Il forno apre tardi e senza profumo in piazza.
- Beppe lavora al molo ma evita il centro del villaggio.
- La passerella corta del traghetto non e disponibile come shortcut.
- Rosa e Beppe non condividono piu la colazione dell'alba.

### Beat di capitolo
1. Prologo breve all'ufficio postale.
Tilde chiude l'ufficio e affida a Nico un ultimo giro. Il tono del villaggio viene presentato con due linee di dialogo e un'estetica quieta, non con esposizione.

2. Prima apparizione della lettera-stella.
Una luce compare sopra l'insegna del forno. Nico la vede, la segue e raccoglie il primo frammento.

3. Raccolta notturna tra forno e molo.
Il giocatore ricompone la busta e segue una scia fino alla cassa blu sul molo. I frammenti parlano di pane messo da parte e di una porta laterale mai chiusa davvero.

4. Deduzione del destinatario.
Al mattino, Nico puo associare i riferimenti a Rosa e Beppe osservando il forno e il molo. Il sistema di deduzione va validato qui con un solo destinatario corretto.

5. Consegna facilitata.
Beppe rifiuta una consegna diretta. Nico usa la chiave sotto la cassa blu per aprire la porta laterale del forno e crea le condizioni per un incontro all'alba.

6. Payoff.
Rosa e Beppe fanno colazione insieme in silenzio, poi scambiano poche parole vere. Il forno torna vivo e il traghetto breve riparte.

### Scene richieste
- C1_S01 Prologo all'ufficio postale.
- C1_S02 Prima luce sul forno.
- C1_S03 Raccolta frammenti nel vicolo.
- C1_S04 Molo Vecchio e cassa blu.
- C1_S05 Ricomposizione e lettura in ufficio.
- C1_S06 Confronto con Rosa.
- C1_S07 Confronto con Beppe.
- C1_S08 Colazione all'alba.
- C1_S09 Stinger di chiusura con nuova stella lontana.

### Puzzle e gating
- Ricomporre la busta: 1 volta, difficolta bassa.
- Seguire la scia: 1 volta, difficolta bassa.
- Deduzione destinatario: 1 scelta, feedback contestuale se errata.
- Interazione contestuale con chiave e porta laterale: 2 interazioni, nessuna nuova meccanica.

### World-state flags
- prologue_seen
- c1_star_seen
- c1_envelope_rebuilt
- c1_recipient_locked
- c1_side_door_open
- c1_delivery_complete
- bakery_lit
- ferry_shortcut_unlocked

### Cambiamenti persistenti nel mondo
- Forno Ferri emette luce e vapore dal camino.
- Rosa appare in piazza un'ora prima.
- Beppe attraversa di nuovo il centro almeno una volta al giorno.
- Shortcut molo <-> forno attivo.

### Deliverable contenutistici
- 1 lettera-cardine definitiva.
- 2 scene di dialogo principali da 8-12 battute totali.
- 1 micro-scena muta di payoff.
- 6-8 barks di reattivita post-capitolo.
- 3 hint UI massimi.

### Note di implementazione
- Questo capitolo deve insegnare il gioco senza finestra tutorial lunga.
- Il primo payoff deve arrivare entro 20-25 minuti max.
- Nessuna battuta deve spiegare cosa sono le lettere-stella oltre la pura osservazione del fenomeno.

### Criteri di accettazione
- Il giocatore comprende raccolta, ricomposizione, deduzione e consegna entro il primo capitolo.
- Il payoff emotivo e leggibile anche se il giocatore salta qualche bark ambientale.
- Il cambiamento del forno e del traghetto e immediatamente visibile al reload della mappa.

## Chapter Card 2 - La stanza in ordine

### Sintesi
Secondo capitolo piu interno e relazionale. Sposta il focus dal legame di sangue al legame scelto e introduce il tema del perdono incompleto.

### Obiettivo emotivo
Mostrare che chiedere scusa non significa cancellare il danno, ma smettere di proteggerlo dietro una versione comoda dei fatti.

### Player promise
Il giocatore capisce che alcune consegne non arrivano in mano, ma attraverso la preparazione di un luogo giusto per parlare.

### Durata e scala
- Durata target: 22-28 minuti.
- Sessione 1: raccolta alla locanda.
- Sessione 2: deduzione tra locanda e serra.
- Sessione 3: ricostruzione della stanza e confronto.

### Luoghi richiesti
- Locanda Luna Bassa.
- Cortile laterale della locanda.
- Serra di Irma.
- Piazza del Pozzo.

### NPC richiesti
- Nico.
- Marta.
- Irma.
- Rosa in cameo funzionale.

### Lettera-cardine
- Titolo: La stanza lasciata pronta.
- Mittente: Marta Valli.
- Destinatario: Irma Soli.
- Tema: vergogna e richiesta di perdono.

### Stato iniziale del mondo
- La locanda e ordinata ma poco vissuta.
- Irma consegna i fiori senza entrare.
- Una stanza al piano alto resta chiusa e pronta da anni.

### Beat di capitolo
1. Apparizione della lettera-stella nella stanza inutilizzata della locanda.
2. Nico raccoglie frammenti legati a dettagli della stanza e a un vaso della serra.
3. Deduzione: il testo parla di una partenza mai avvenuta e di una stanza tenuta pronta per vergogna, non per nostalgia romantica.
4. Puzzle principale: ricostruire la stanza come Irma la ricorda, usando 4 oggetti chiave.
5. Nico convince Irma a entrare consegnandole un vaso storto che riconosce come suo.
6. Marta chiede scusa senza difendersi. Irma non perdona pienamente, ma resta nella stanza.

### Scene richieste
- C2_S01 Notte alla locanda.
- C2_S02 Frammento nella stanza chiusa.
- C2_S03 Scena breve in serra.
- C2_S04 Ricomposizione lettera.
- C2_S05 Rimettere la stanza com'era.
- C2_S06 Confronto Marta/Irma.
- C2_S07 Nuova routine serale alla locanda.

### Puzzle e gating
- Ricomporre la busta: 1 volta, media.
- Deduzione destinatario: 1 volta, media.
- Rimettere la stanza com'era: 1 volta, media.

### World-state flags
- c2_star_seen
- c2_room_opened
- c2_letter_read
- c2_layout_restored
- c2_confrontation_done
- inn_flowers_visible

### Cambiamenti persistenti nel mondo
- Fiori freschi e tavolo apparecchiato alla locanda.
- Irma entra in locanda in una routine serale.
- Una stanza della locanda diventa luogo di memoria e non di rimozione.

### Deliverable contenutistici
- 1 lettera-cardine definitiva.
- 1 scena centrale di confronto con 10-14 battute totali.
- 1 sequenza ambientale muta di stanza ricomposta.
- 6-8 barks reattivi.

### Note di implementazione
- Evitare ambiguita sentimentale non necessaria: il legame tra Marta e Irma puo essere letto come amicizia profondissima o affetto mancato, senza richiedere definizione.
- Il puzzle della stanza deve essere leggibile su mobile con pochi oggetti grandi.

### Criteri di accettazione
- Il capitolo aggiunge profondita emotiva senza introdurre nuova lore.
- La stanza ricostruita produce un payoff visivo forte e sobrio.
- Irma non deve sembrare gia guarita nel finale di capitolo.

## Chapter Card 3 - Le lancette ferme

### Sintesi
Terzo capitolo a maggiore densita sistemica. Porta il tema sulla fragilita e usa il campanile come grande oggetto simbolico e funzionale.

### Obiettivo emotivo
Mostrare che l'orgoglio puo nascere anche dalla vergogna di non essere piu capaci come prima.

### Player promise
Il giocatore sperimenta una consegna in cui il contesto meccanico e sonoro conta quanto il testo della lettera.

### Durata e scala
- Durata target: 24-30 minuti.
- Sessione 1: bottega e primo frammento.
- Sessione 2: campanile e deduzione.
- Sessione 3: riallineamento del tempo e payoff sonoro.

### Luoghi richiesti
- Bottega di Cesare.
- Scalata breve del campanile.
- Piazza del Pozzo come ascolto dei rintocchi.

### NPC richiesti
- Nico.
- Cesare.
- Lea.
- 1 abitante in piazza che reagisce al ritorno delle campane.

### Lettera-cardine
- Titolo: Le mani che tremano.
- Mittente: Cesare Monti.
- Destinatario: Lea Riva.
- Tema: fragilita e dignita.

### Stato iniziale del mondo
- La torre e silenziosa.
- Cesare lavora a bottega con gesti corti e difensivi.
- Lea evita la bottega ma passa dalla piazza per sentire se qualcosa cambia.

### Beat di capitolo
1. La lettera-stella appare dentro un orologio aperto in bottega.
2. I frammenti suggeriscono un'ora precisa e un incontro spezzato.
3. Nico capisce che Cesare non ha cacciato Lea per disprezzo, ma per vergogna.
4. Puzzle: regolare le lancette sull'ora di una memoria condivisa.
5. Puzzle: riattivare la corda del campanile con Lea presente.
6. Cesare chiede aiuto apertamente a Lea. Le campane tornano a segnare il paese.

### Scene richieste
- C3_S01 Ingresso in bottega.
- C3_S02 Primo tremore nascosto.
- C3_S03 Raccolta nel campanile.
- C3_S04 Lettura della lettera.
- C3_S05 Regolare le lancette.
- C3_S06 Confronto Cesare/Lea.
- C3_S07 Primo rintocco ritrovato.

### Puzzle e gating
- Ricomporre la busta: 1 volta, media.
- Regolare le lancette: 1 volta, media.
- Intrecciare la corda del campanile: 1 volta, media.

### World-state flags
- c3_star_seen
- c3_clock_set
- c3_rope_sequence_done
- c3_lea_present
- c3_bell_restored

### Cambiamenti persistenti nel mondo
- Campanile sonoro a orari chiave.
- Cesare lavora con Lea in alcune finestre orarie.
- La piazza usa di nuovo il rintocco come riferimento.

### Deliverable contenutistici
- 1 lettera-cardine definitiva.
- 1 scena di conflitto ruvido ma breve.
- 1 payoff sonoro con poca parola.
- 6 barks reattivi centrati sul ritorno delle campane.

### Note di implementazione
- Il puzzle delle lancette deve essere chiaro visivamente e supportare tocco grosso su schermo piccolo.
- Il ritorno del suono deve essere usato come reward di sistema, non solo emotivo.

### Criteri di accettazione
- Il capitolo aumenta la varieta senza spezzare il loop.
- Cesare non deve diventare tenero all'improvviso: cambia, ma resta ruvido.
- Lea deve emergere come persona autonoma, non come semplice assistente emotiva.

## Chapter Card 4 - La posta morta

### Sintesi
Quarto capitolo di inversione. Il villaggio esterno si restringe e il conflitto entra nell'ufficio postale. La verita tocca direttamente Nico.

### Obiettivo emotivo
Mostrare che proteggere qualcuno dal dolore puo trasformarsi in una forma di espropriazione.

### Player promise
Il giocatore capisce che il mistero centrale non va verso una spiegazione cosmica, ma verso una verita personale.

### Durata e scala
- Durata target: 18-24 minuti.
- Sessione 1: notte nell'ufficio postale.
- Sessione 2: archivio e sorting.
- Sessione 3: confronto Tilde/Nico.

### Luoghi richiesti
- Ufficio Postale.
- Archivio postale.
- Retrobottega con cassetto bloccato.

### NPC richiesti
- Nico.
- Tilde.
- Presenza evocata di Livia tramite oggetti e testo.

### Lettera-cardine
- Titolo: La lettera mai timbrata.
- Mittente: Tilde Neri.
- Destinatario: Nico Sera.
- Tema: protezione che diventa omissione.

### Stato iniziale del mondo
- L'ufficio e ancora il luogo piu ordinato e meno sincero del villaggio.
- Nico si fida di Tilde piu che di chiunque altro.
- L'archivio morto e fisicamente presente ma non accessibile.

### Beat di capitolo
1. Una lettera-stella compare all'interno dell'ufficio postale, violando il pattern dei capitoli precedenti.
2. Nico segue una scia che porta direttamente all'archivio morto.
3. Puzzle principale: ordinare la posta morta per sbloccare il cassetto di Livia.
4. Tilde consegna una lettera scritta da lei e poi il plico originale di Livia.
5. Confronto breve ma duro tra Nico e Tilde.
6. Nico prende la lettera della madre ma sceglie di non aprirla ancora.

### Scene richieste
- C4_S01 Luce nell'ufficio chiuso.
- C4_S02 Archivio morto.
- C4_S03 Sorting e cassetto bloccato.
- C4_S04 Lettera di Tilde.
- C4_S05 Confronto Nico/Tilde.
- C4_S06 Chiusura con lettera sigillata in tasca.

### Puzzle e gating
- Seguire la scia: 1 volta, bassa.
- Ordinare la posta morta: 1 volta, media.
- Nessuna consegna esterna classica.

### World-state flags
- c4_star_seen
- archive_unlocked
- c4_tilde_letter_read
- c4_livia_letter_received
- c4_trust_broken

### Cambiamenti persistenti nel mondo
- Archivio lettere sbloccato come menu o stanza visitabile.
- Ufficio postale piu luminoso e meno rigido.
- Tilde cambia posizione fisica nello spazio, non piu dietro il banco nelle scene successive.

### Deliverable contenutistici
- 1 lettera-cardine definitiva di Tilde.
- 1 scena chiave di confronto con sottotesto e trattenimento.
- 4-5 interazioni ambientali su oggetti di Livia.

### Note di implementazione
- Non trasformare Tilde in antagonista. Il gesto e grave, ma nasce da paura e attaccamento.
- Il capitolo deve essere piu raccolto e meno dispersivo, quasi un camera play interattivo.

### Criteri di accettazione
- Il reveal e comprensibile senza exposition dump.
- Il giocatore sente una rottura reale tra Nico e Tilde.
- La scelta di non aprire subito la lettera finale appare attiva, non artificiale.

## Chapter Card 5 - L'ultima consegna

### Sintesi
Capitolo finale di risonanza. Il villaggio intero diventa memoria attraversata. Nessuna escalation cosmica: solo l'ultima lettera, il ritorno ai luoghi vissuti e una risposta scelta.

### Obiettivo emotivo
Chiudere l'arco di Nico con una verita che non cancella la perdita ma le restituisce forma e voce.

### Player promise
Il giocatore raccoglie il senso di tutto cio che ha fatto e lo rilegge attraverso il protagonista.

### Durata e scala
- Durata target: 20-26 minuti.
- Sessione 1: apertura della lettera e prima interruzione.
- Sessione 2: percorso notturno di risonanza.
- Sessione 3: belvedere, lettura finale, risposta, epilogo.

### Luoghi richiesti
- Ufficio Postale.
- Forno Ferri.
- Locanda Luna Bassa.
- Campanile o piazza sonora.
- Molo Vecchio.
- Belvedere.

### NPC richiesti
- Nico.
- Tilde.
- Presenza diffusa del villaggio come eco.
- Livia come voce di lettera, non come apparizione piena.

### Lettera-cardine
- Titolo: La casa che resta accesa.
- Mittente: Livia Sera.
- Destinatario: Nico Sera.
- Tema: assenza, amore, scelta.

### Stato iniziale del mondo
- Nico possiede la lettera ma non l'ha ancora letta.
- Il villaggio porta gia i segni delle consegne precedenti.
- Tilde non spinge, ma resta disponibile.

### Beat di capitolo
1. Nico apre la lettera di Livia ma il contenuto resta incompleto.
2. Una nuova scia lo porta nei luoghi gia trasformati dai capitoli precedenti.
3. Puzzle finale: ricostruire il percorso emotivo corretto del villaggio, non quello geografico piu breve.
4. A ogni luogo, Nico raccoglie una risonanza che completa il testo della lettera.
5. Al belvedere legge la versione intera, cartacea e stellare.
6. Nico scrive una risposta e la lascia nella cassetta sul colle.
7. Epilogo: le finestre del villaggio si accendono una a una; una stella resta lontana.

### Scene richieste
- C5_S01 Lettera aperta a meta.
- C5_S02 Primo luogo di risonanza.
- C5_S03 Secondo luogo di risonanza.
- C5_S04 Terzo luogo di risonanza.
- C5_S05 Belvedere e lettura completa.
- C5_S06 Risposta di Nico.
- C5_S07 Epilogo finestre accese.

### Puzzle e gating
- Ricostruire il percorso finale: 1 volta, media.
- Rilettura lettere precedenti: opzionale, nessun gating.
- Nessuna punizione per errore nel puzzle finale.

### World-state flags
- c5_letter_opened
- c5_resonance_1
- c5_resonance_2
- c5_resonance_3
- c5_final_path_complete
- c5_reply_written
- epilogue_unlocked

### Cambiamenti persistenti nel mondo
- Finestre accese in piu punti del villaggio.
- Ultima stella lontana in skybox notturna.
- Tilde e Nico condividono lo spazio dell'ufficio senza distanza rigida.

### Deliverable contenutistici
- 1 lettera-cardine definitiva di Livia.
- 1 risposta scritta di Nico, mostrata solo in parte.
- 1 epilogo quasi muto.
- 8-10 barks o linee corte di risonanza nei luoghi gia visitati.

### Note di implementazione
- Livia non deve apparire come fantasma parlante. La sua presenza e solo testo, memoria, voce interiore o eco percettiva.
- Il finale deve essere leggibile emotivamente anche se il giocatore non interpreta il lato fantastico in modo univoco.

### Criteri di accettazione
- Il capitolo chiude il gioco senza introdurre nuovo sistema o nuova lore.
- Il percorso finale restituisce il senso delle consegne precedenti.
- Il finale lascia una domanda aperta solo sul fantastico, non sull'arco del protagonista.
