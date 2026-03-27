---
name: plugin-creator
description: Scaffold local Codex plugins and optional marketplace entries.
---

# Plugin Creator

Use the scaffold script. Prefer generated structure over hand-written boilerplate.

## Core Command

```bash
python3 .agents/skills/plugin-creator/scripts/create_basic_plugin.py <plugin-name>
```

Optional:

```bash
python3 .agents/skills/plugin-creator/scripts/create_basic_plugin.py my-plugin --with-marketplace
python3 .agents/skills/plugin-creator/scripts/create_basic_plugin.py my-plugin --path <parent-dir> --with-skills --with-hooks --with-scripts --with-assets --with-mcp --with-apps --with-marketplace
```

## Output

- `<plugin>/.codex-plugin/plugin.json` is always created
- plugin name is normalized to lower-case hyphen-case
- placeholders stay until explicitly filled
- optional `skills/`, `hooks/`, `scripts/`, `assets/`, `.mcp.json`, `.app.json`

## Marketplace Rules

- file: `<repo-root>/.agents/plugins/marketplace.json`
- append unless the user asks to reorder
- always write:
  - `policy.installation`
  - `policy.authentication`
  - `category`
- default:
  - `installation: AVAILABLE`
  - `authentication: ON_INSTALL`
- add `policy.products` only if explicitly requested
- keep `source.path` as `./plugins/<plugin-name>`

Reference exact JSON in `references/plugin-json-spec.md`.

## Validation

```bash
python3 <path-to-skill-creator>/scripts/quick_validate.py .agents/skills/plugin-creator
```
