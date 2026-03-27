---
name: skill-installer
description: List and install curated or repo-hosted skills into $CODEX_HOME/skills.
metadata:
  short-description: Install curated skills from openai/skills or other repos
---

# Skill Installer

Use helper scripts. Default source is curated OpenAI skills. Experimental and repo-based installs are also supported.

## Use Cases

- list available skills
- install a curated skill
- install from a GitHub repo or repo path

## Scripts

- `scripts/list-skills.py`
- `scripts/list-skills.py --format json`
- `scripts/list-skills.py --path skills/.experimental`
- `scripts/install-skill-from-github.py --repo <owner>/<repo> --path <path>`
- `scripts/install-skill-from-github.py --url https://github.com/<owner>/<repo>/tree/<ref>/<path>`

## Rules

- These scripts use network.
- Installed destination: `$CODEX_HOME/skills/<skill-name>` or `~/.codex/skills`.
- Abort if the destination already exists.
- Public repos prefer direct download, then sparse checkout fallback.
- Private repos may use existing credentials or `GITHUB_TOKEN` / `GH_TOKEN`.
- `.system` skills are already installed.

## Communication

- When listing, show available skills and mark already installed ones.
- After install, tell the user to restart Codex.
