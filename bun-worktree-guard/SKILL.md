---
name: bun-worktree-guard
description: Use when entering a fresh or obviously unbootstrapped Bun-based worktree. Trigger when `node_modules` may be missing, dependencies may not be installed yet, or a newly created worktree needs the normal Bun bootstrap before deeper work starts.
---

# Bun Worktree Guard

Use this skill to clear the common "fresh worktree is missing dependencies" failure mode before it interrupts the main task.

## Workflow

### 1. Detect a Bun repo

Treat the repo as Bun-based when:

- `package.json` exists
- `bun.lock` exists, or the repo clearly uses Bun scripts and tooling

### 2. Check whether the worktree is bootstrapped

Use this skill when the worktree is new, ephemeral, or obviously missing installed dependencies.

Default action:

- if `node_modules` is missing, run `bun install`

Do not reinstall blindly if dependencies are already present unless there is evidence they are stale or broken.

### 3. Run normal local bootstrap extras when appropriate

If the repo exposes a setup command that is clearly part of normal local bootstrap, run it when appropriate.

Example:

- `bun run hooks:install`

## Guardrails

- This skill is personal workflow guidance, not repo policy.
- Do not edit repo docs or repo instructions just to enforce this behavior.
- Keep the overhead low; the point is to remove a common setup blocker, not to run setup constantly.

## Example triggers

- "bootstrap this fresh Bun worktree"
- "install deps if needed before we start"
- "this new worktree probably needs bun install"
