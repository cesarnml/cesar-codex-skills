---
name: skill-creator
description: Create or update skills. Keep them short, triggerable, and organized around reusable workflow, scripts, references, and assets.
metadata:
  short-description: Create or update a skill
---

# Skill Creator

Skills are AI-facing workflow packs. Optimize for trigger accuracy and low token cost.

## Principles

- Assume the model is already capable. Add only missing procedure or domain detail.
- Keep `SKILL.md` short.
- Put detailed material in `references/`.
- Put deterministic repeated work in `scripts/`.
- Put output resources in `assets/`.
- Do not add human-facing docs like `README.md` or `CHANGELOG.md`.

## Required Structure

- `SKILL.md`
- frontmatter with `name` and `description`

Recommended:
- `agents/openai.yaml`
- `scripts/`
- `references/`
- `assets/`

## Naming

- lower-case letters, digits, hyphens
- under 64 chars
- short, verb-led if possible
- folder name matches skill name

## Writing Rules

- Description must say when the skill should trigger.
- Body should describe what to do after trigger.
- Prefer bullets over long prose.
- Keep references one hop away from `SKILL.md`.
- For long reference files, include a table of contents.

## Validation Integrity

- Use subagents for validation only when useful.
- Give them minimal context.
- Validate generalization, not whether another model can reconstruct your intended answer.

## Creation Flow

1. Understand usage with concrete examples.
2. Decide what belongs in `SKILL.md`, `scripts/`, `references/`, and `assets/`.
3. Initialize the skill if needed.
4. Write or edit the skill.
5. Validate it.
6. Iterate from real usage.

## `agents/openai.yaml`

- Read `references/openai_yaml.md` before generating it.
- Keep UI text human-facing, but keep `SKILL.md` AI-facing.
- Regenerate if stale.
