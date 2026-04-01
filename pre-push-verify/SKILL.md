---
name: pre-push-verify
description: Use before pushing changes from a repo that has a local verification gate. Trigger when preparing to run `git push`, when you want to catch routine format, lint, typecheck, or spellcheck failures locally first, or when a previous push was rejected by a verification hook.
---

# Pre-Push Verify

Use this skill to catch routine verification failures before they interrupt a push.

## Workflow

### 1. Find the repo's verification entry point

Inspect `package.json` or the repo's standard task runner and identify the narrowest meaningful command that matches the repo's pre-push gate.

Preferred order:

1. if `verify` exists, run the repo's verify command
2. otherwise run the smallest set of pre-push checks the repo clearly expects

For Bun repos, prefer:

- `bun run verify`

### 2. Clear failures locally before pushing

If verification fails:

- fix the underlying issue locally
- rerun verification
- only push after the gate is green

Do not wait for a push hook to rediscover routine format, lint, typecheck, or spellcheck failures.

### 3. Report only the useful part

If the check fails, summarize the blocker briefly for the user when it changes the plan or requires a decision.

## Guardrails

- This skill is personal workflow guidance, not repo policy.
- Do not edit repo docs or repo instructions just to enforce this behavior.
- Prefer the repo's existing verification entry point over inventing a custom command sequence.

## Example triggers

- "run the repo checks before pushing"
- "make sure this push won't fail the hook"
- "verify this branch before I push"
