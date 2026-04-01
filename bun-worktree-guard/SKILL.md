---
name: bun-worktree-guard
description: Use when working in a Bun-based repo and there is a risk of avoidable workflow failures from a fresh worktree or a pre-push verification gate. Trigger when a new worktree may be missing installed dependencies, before pushing to GitHub, or when a push failed because format, lint, typecheck, or spellcheck did not run locally first.
---

# Bun Worktree Guard

Use this skill to prevent routine Bun workflow failures before they interrupt the main task.

It covers two cases:

- fresh worktree bootstrap
- pre-push verification

## Workflow

### 1. Detect a Bun repo

Treat the repo as Bun-based when:

- `package.json` exists
- `bun.lock` exists, or the repo clearly uses Bun scripts and tooling

### 2. Fresh worktree bootstrap

Use this when entering a newly created or obviously unbootstrapped worktree.

Default action:

- if `node_modules` is missing, run `bun install`

Do not reinstall blindly if dependencies are already present unless there is evidence they are stale or broken.

If the repo exposes a setup command that is clearly part of normal local bootstrap, run it when appropriate. Example: `bun run hooks:install`.

### 3. Pre-push guard

Before any `git push`, look for the repo's main verification script in `package.json`.

Preferred order:

1. if `bun run verify` exists, run `bun run verify`
2. otherwise run the narrowest meaningful pre-push checks exposed by the repo
3. fix failures locally before retrying the push

Do not wait for the push hook to discover routine format, lint, typecheck, or spellcheck failures.

### 4. Failure handling

When bootstrap or verify fails:

- treat it as a workflow blocker to clear immediately
- prefer fixing the underlying issue over bypassing the check
- summarize the blocker briefly for the user only when it changes the plan or requires a decision

## Guardrails

- This skill is personal workflow guidance, not repo policy.
- Do not edit repo docs or repo instructions just to enforce this behavior.
- Prefer proactive checks over reactive push-hook failures.
- Keep the overhead low; the point is to remove common friction, not to run unnecessary setup constantly.

## Example triggers

- "bootstrap this fresh Bun worktree"
- "make sure this push won't fail the hook"
- "install deps if needed before we start"
- "run the repo checks before pushing"
