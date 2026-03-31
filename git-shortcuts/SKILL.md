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
- Do not write a `Verification`, `Validation`, `Checks`, or similar section when the only content would be routine repo checks or expected green-path commands.
- Do not include `Validation` or `Verification` for routine repo checks like `test`, `typecheck`, or `lint`.
- Do not include placeholder lines such as `- bun run ci`, `- tests pass`, or `- lint/typecheck` unless the user explicitly asked for that reporting or those details are the main risk-relevant signal.
- Include validation details only when they are materially informative: non-standard checks, manual QA, meaningful caveats, partial coverage, failed or flaky checks, or when the user explicitly asks for them.
- If validation is worth mentioning, fold it into the most relevant section unless a dedicated section is clearly justified.
- Prefer no validation section over a low-value one.
- When summarizing multiple distinct updates or follow-up items in a PR body, prefer flat bullet lists over one long comma-separated sentence.
- In sections like `AI Review Follow-Up`, break distinct later changes into separate bullets instead of packing them into a single catch-all line.

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
