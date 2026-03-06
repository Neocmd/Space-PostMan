# GitFlow and Releases

Documento operativo per gestire branch, release e branch protection del repository.

## 1. Stato raccomandato del repository

Branch lunghi:
- `main`
- `develop`

Branch corti:
- `feature/*`
- `release/*`
- `hotfix/*`
- `codex/*`

## 2. Flusso standard

### Nuova feature
1. crea `feature/<nome>` da `develop`
2. lavora solo in quel branch
3. apri PR verso `develop`
4. merge dopo CI verde

### Bootstrap o automazione Codex
1. crea `codex/<nome>` da `develop`
2. implementa scaffolding o contenuti tecnici
3. apri PR verso `develop`

### Release
1. crea `release/<versione>` da `develop`
2. congela scope e fai solo fix di stabilizzazione
3. apri PR verso `main`
4. mergia in `main`
5. crea tag `v<versione>` su `main`
6. back-merge in `develop`

### Hotfix
1. crea `hotfix/<versione>` da `main`
2. risolvi il bug urgente
3. apri PR verso `main`
4. tagga la patch release
5. back-merge in `develop`

## 3. Branch protection da applicare su GitHub

### main
- Require a pull request before merging
- Require approvals: almeno 1
- Require status checks to pass before merging
- Required check: `repository-contracts`
- Block force pushes
- Block deletions

### develop
- Require a pull request before merging
- Require status checks to pass before merging
- Required check: `repository-contracts`
- Block force pushes
- Block deletions

## 4. CI e CD attese

### CI
Trigger:
- push su `main`, `develop`, `feature/*`, `release/*`, `hotfix/*`, `codex/*`
- PR verso `main` o `develop`

Contenuto:
- validazione naming branch
- test automatici dei contratti del repository

### CD
Trigger:
- push su `develop`
- push su `main`
- tag `v*`

Contenuto:
- packaging del foundation pack in `dist/`
- upload artifact su GitHub Actions
- pubblicazione di release bundle su tag

## 5. Decisioni pratiche per questo repository

- Fino a quando non esiste una codebase Godot, CI e CD validano e pubblicano documentazione e dati runtime.
- Quando esisteranno `project.godot` ed `export_presets.cfg`, la CD verra estesa con export di build.
- La qualità minima di merge e: CI verde, documentazione aggiornata, dati runtime coerenti.
