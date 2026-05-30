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
