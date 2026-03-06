# Rulesets

Payload JSON per configurare le ruleset del repository `Neocmd/Space-PostMan`.

## File inclusi

- `main-ruleset.json`
  Regola applicabile subito per `main`.
- `develop-ruleset.json`
  Regola applicabile subito per `develop`.
- `main-ruleset.admin-bypass.template.json`
  Template con bypass admin in modalita `pull_request` per `main`.
- `develop-ruleset.admin-bypass.template.json`
  Template con bypass admin in modalita `pull_request` per `develop`.

## Perche ci sono due versioni

Le versioni `*.json` sono applicabili subito.

I template `*.admin-bypass.template.json` esistono perche il campo `bypass_actors[].actor_id` richiede un identificatore numerico del ruolo repository admin. Nelle docs ufficiali GitHub usate per costruire questi payload il tipo di attore e documentato, ma non e documentato in modo stabile un valore numerico universale da inserire qui senza verificarlo nel tuo account o via UI/API.

Per questo motivo:
- i file `main-ruleset.json` e `develop-ruleset.json` sono sicuri da applicare subito;
- il bypass admin per emergenze e meglio aggiungerlo da UI, oppure compilando il template dopo avere verificato il valore corretto nel tuo ambiente.

## Impostazioni scelte in base alle tue risposte

- unico maintainer per ora
- PR obbligatoria su `main` e `develop`
- nessuna approval obbligatoria per non auto-bloccarti
- status check richiesto: solo `repository-contracts`
- blocco force push e cancellazione dei branch protetti
- richiesta di risolvere le review threads nelle PR

## Applicazione via GitHub CLI

### 1. Creare la ruleset di `main`
```powershell
gh api repos/Neocmd/Space-PostMan/rulesets --method POST --input rulesets/main-ruleset.json
```

### 2. Creare la ruleset di `develop`
```powershell
gh api repos/Neocmd/Space-PostMan/rulesets --method POST --input rulesets/develop-ruleset.json
```

## Applicazione via UI

1. Vai su `Settings` > `Rules` > `Rulesets`
2. `New ruleset` > `Import ruleset`
3. importa `main-ruleset.json`
4. ripeti con `develop-ruleset.json`
5. se vuoi il bypass admin, aggiungilo nella UI della ruleset dopo l'import

## Fonti ufficiali usate

- [Creating rulesets for a repository](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/creating-rulesets-for-a-repository)
- [Available rules for rulesets](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/available-rules-for-rulesets)
- [REST API - Create a repository ruleset](https://docs.github.com/en/rest/repos/rules#create-a-repository-ruleset)
