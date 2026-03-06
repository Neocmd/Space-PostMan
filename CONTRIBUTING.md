# Contributing

## Branch Model

Questo repository usa GitFlow con una piccola estensione pratica per i branch di automazione.

### Branch permanenti
- `main`: stato rilasciabile e sorgente delle tag di release.
- `develop`: branch di integrazione per il lavoro corrente.

### Branch temporanei
- `feature/<nome-breve>`: nuove feature o contenuti, sempre da `develop`.
- `release/<versione>`: stabilizzazione pre-release, da `develop` verso `main`.
- `hotfix/<versione>`: fix urgenti da `main`, da riportare anche su `develop`.
- `codex/<nome-breve>`: branch di automazione o bootstrap gestiti da Codex; devono rientrare su `develop`.

## Regole di merge

- Non fare push diretti su `main` o `develop` dopo l'attivazione delle branch protections.
- Le `feature/*` e `codex/*` aprono PR verso `develop`.
- Le `release/*` aprono PR verso `main` e, dopo il merge, vanno riportate anche su `develop`.
- Le `hotfix/*` aprono PR verso `main` e poi back-merge su `develop`.

## CI

La CI deve essere verde prima di ogni merge.

Check minimi richiesti:
- validazione dei contratti del repository
- test automatici dei dati e della documentazione runtime

## CD

La CD corrente pubblica un bundle versionato di documentazione e dati runtime.

Comportamento previsto:
- push su `develop`: artifact snapshot del foundation pack
- push su `main`: artifact candidate del foundation pack
- push di una tag `v*`: pubblicazione di un release bundle su GitHub Releases

Quando il progetto Godot verra bootstrapato, lo stesso workflow CD potra essere esteso a export di build reali.

## Test locali

Eseguire sempre prima di aprire una PR:

```powershell
python -m unittest discover -s tests -v
python scripts\repository_contracts.py
```

## Pull Request

Ogni PR deve includere:
- scopo del cambiamento
- impatto su narrativa, dati o pipeline
- test eseguiti
- eventuali step manuali richiesti su GitHub o nel motore

## Versioning

- usare tag SemVer: `v0.1.0`, `v0.2.0`, `v1.0.0`
- taggare solo da `main`
- usare `release/*` per congelare contenuti e fixare solo bug o polishing di release

## Branch protection consigliate

Applicare manualmente su GitHub:
- `main`: PR obbligatoria, 1 review minima, CI obbligatoria, nessun direct push
- `develop`: PR obbligatoria, CI obbligatoria, nessun direct push
