# pc8201a-meshtastic

## This repo is PUBLIC

Never commit secrets or PII. This repo is published to GitHub
(`akostibas/pc8201a-meshtastic`).

**Specifically, never commit:**

- **Meshtastic channel PSKs or channel-set URLs** (`https://meshtastic.org/e/#...`).
  The "Shannon" channel key lives only on the physical nodes — share it
  out-of-band (URL/QR), never in git. Document channel *names* and public
  BayMesh radio params (MediumFast, slot 45) freely; the PSK is the secret.
- Private keys, API tokens, passwords.
- PII: real names, home address, precise GPS coordinates of nodes, email
  addresses, phone numbers.

A `gitleaks` pre-commit hook scans staged changes for secrets (including a
custom Meshtastic channel-URL rule). If it blocks a commit, do not bypass with
`--no-verify` — remove the secret instead.

## Workflow

Always push doc changes to GitHub after committing:
- **On a feature/coding branch** — push to that branch.
- **Doc-only changes on main** — push directly to main.

## Reference manuals (OCR'd)

All three 1983 NEC PC-8201A manuals have been OCR'd from scans into
per-chapter markdown under `docs/`. Consult these for hardware behavior,
memory layout, BASIC semantics, and serial/IO details before guessing:

- **Technical Reference** — `docs/pc-8201a-tech-ref/chapters/` (hardware,
  memory map, RAM file system, serial interface).
- **User's Guide** — `docs/pc-8201a-users-guide/chapters/` (operation,
  peripherals, TEXT/TELCOM, specs).
- **BASIC Reference** — `docs/pc-8201a-basic-ref/chapters/` (N82-BASIC
  instructions, files, machine-language programming, memory maps).

Supporting docs: `docs/pc-8201a-shared-glossary.md` (canonical spellings,
notation `^X`/`^B`, cross-title disambiguation — main-owned, single-writer),
and `docs/ocr-workflow.md` (the two-tier OCR pipeline if more pages need
processing). The source PDFs live under `docs/source/` and are **not** in git
(large/copyrighted).
