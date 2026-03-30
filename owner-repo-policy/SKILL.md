---
name: owner-repo-policy
description: Use when the user wants to set up or discuss GitHub repo merge and branch-protection policy for a repo they personally own. Prefer squash-only PR merges, linear history on main, and no mandatory PR-review gate unless the user explicitly wants stricter team-style controls.
---

# Owner Repo Policy

Use this skill when the repo is primarily operated by its owner and the user wants their preferred GitHub workflow applied or debated.

## Default stance

- Prefer squash-only PR merges.
- Prefer linear history on `main`.
- Do not require PR review by default.
- Keep direct pushes to `main` available unless the user asks for stricter controls.
- Treat team or shared repos differently. For those, ask whether mandatory PRs, reviews, or admin enforcement should apply.

## Policy boundary

- Personal workflow defaults belong here.
- Repo-local exceptions belong in the repo's `AGENTS.md` or equivalent policy file.
- Team-enforced behavior should be explicit and reviewable. Do not silently apply owner-style defaults to a shared repo.

## When applying this policy

1. Identify the GitHub repo from `origin`.
2. Check `gh auth status`.
3. Read the current repo merge settings.
4. Read the current protection state for `main`.
5. Apply the default settings unless the user asks otherwise.
6. Read back the final state and report the exact result.

## Default commands

Use `gh repo edit` to leave only squash merges enabled:

```bash
gh repo edit OWNER/REPO \
  --enable-squash-merge \
  --enable-merge-commit=false \
  --enable-rebase-merge=false \
  --squash-merge-commit-message pr-title-description
```

Use the branch protection API to keep linear history on `main` without forcing PR review:

```bash
tmp=$(mktemp)
printf '%s' '{
  "required_status_checks": null,
  "enforce_admins": false,
  "required_pull_request_reviews": null,
  "restrictions": null,
  "required_linear_history": true,
  "allow_force_pushes": false,
  "allow_deletions": false,
  "block_creations": false,
  "required_conversation_resolution": false,
  "lock_branch": false,
  "allow_fork_syncing": false
}' > "$tmp"

gh api --method PUT repos/OWNER/REPO/branches/main/protection \
  -H 'Accept: application/vnd.github+json' \
  --input "$tmp"

rm -f "$tmp"
```

## Verification checklist

- Confirm `squashMergeAllowed` is `true`.
- Confirm `mergeCommitAllowed` is `false`.
- Confirm `rebaseMergeAllowed` is `false`.
- Confirm `required_linear_history.enabled` is `true`.
- Confirm `required_pull_request_reviews` is absent or `null`.
- Confirm force pushes remain disabled unless the user explicitly asks for them.

## Discussion guidance

- If the user asks for a recommendation, separate personal workflow from team policy.
- Optimize for low-friction owner operation, not process theater.
- Steelman the stricter PR-only workflow, then say clearly whether it changes the recommendation.
- If the repo has multiple active maintainers, ask before applying this default.
