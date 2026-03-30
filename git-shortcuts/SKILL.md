---
name: git-shortcuts
description: Use for the keyword triggers `cc`, `ccb`, `pr`, or `branch`. Generates terse git-facing outputs for the current repo while respecting repo and local AGENTS.md policy.
---

# Git Shortcuts

Use this skill only when the user explicitly asks for `cc`, `ccb`, `pr`, or `branch`, or clearly asks for the same output.

Read repo/local `AGENTS.md` first if present. Repo/local policy overrides this skill.

## Trigger outputs

### `cc`

- Return plain text only.
- One line only.
- No Markdown.
- No explanation.
- Output a one-line Conventional Commit for all outstanding workspace changes.

### `ccb`

- Return plain text only.
- Subject line, blank line, concise body.
- No Markdown.
- No explanation.
- Output a Conventional Commit subject + body for all outstanding workspace changes.

### `pr`

- Return exactly one fenced code block and nothing else.
- First line: Conventional-Commit-style PR title.
- Then a blank line.
- Then a concise Markdown PR body.
- Base the PR on all outstanding changes vs `origin/main`.
- If the current worktree lacks enough context, use the primary `main` worktree as fallback context.
- If repo policy defines PR title format or ticket suffix rules, follow it.
- Omit a `Verification` section by default.
- Do not include `Validation` or `Verification` for routine repo checks like `test`, `typecheck`, or `lint`.
- Include validation details only when they are materially informative: non-standard checks, manual QA, meaningful caveats, partial coverage, or when the user explicitly asks for them.

### `branch`

- Return plain text only.
- One line only.
- No Markdown.
- No explanation.
- Suggest a branch name for the current work.
- Prefer `codex/` as the prefix unless repo policy or the user says otherwise.
- Use short kebab-case.
- If a delivery ticket is clear, include it tersely in the slug.

## Working rules

- Use Conventional Commit style for commit messages and PR titles.
- Prefer the smallest accurate scope.
- Omit ticket IDs unless repo/local policy requires them.
- Infer the change from the actual diff, branch, and nearby docs. Do not invent scope or ticket suffixes.
- If there are no relevant changes, still return the best terse output for the user’s request instead of explaining the absence of changes.
