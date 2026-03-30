#!/usr/bin/env bash
set -euo pipefail

pr_number="${1:-}"
login_prefix="${2:-qodo-code-review}"

if ! command -v gh >/dev/null 2>&1; then
  echo "gh CLI is required." >&2
  exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
  echo "jq is required." >&2
  exit 1
fi

if [[ -z "$pr_number" ]]; then
  pr_number="$(gh pr view --json number -q .number)"
fi

repo="$(gh repo view --json nameWithOwner -q .nameWithOwner)"
pr_json="$(gh pr view "$pr_number" --json number,title,url,headRefName,baseRefName,isDraft,state)"
issue_comments_json="$(gh api "repos/$repo/issues/$pr_number/comments?per_page=100")"
review_comments_json="$(gh api "repos/$repo/pulls/$pr_number/comments?per_page=100")"

echo "$pr_json" | jq -r '
  "PR #\(.number): \(.title)\nURL: \(.url)\nBranch: \(.headRefName) -> \(.baseRefName)\nState: \(.state)\(if .isDraft then " (draft)" else "" end)\n"
'

issue_count="$(
  echo "$issue_comments_json" | jq --arg prefix "$login_prefix" '
    map(select(.user.login | startswith($prefix))) | length
  '
)"
review_count="$(
  echo "$review_comments_json" | jq --arg prefix "$login_prefix" '
    map(select(.user.login | startswith($prefix))) | length
  '
)"

echo "Issue comments from ${login_prefix}: ${issue_count}"
if [[ "$issue_count" -gt 0 ]]; then
  echo "$issue_comments_json" | jq -r --arg prefix "$login_prefix" '
    map(select(.user.login | startswith($prefix)))[]
    | "- [issue] \(.user.login) at \(.updated_at)\n  \(.body | gsub("\r"; "") | gsub("\n"; "\n  "))\n  \(.html_url)"
  '
fi

echo
echo "Review comments from ${login_prefix}: ${review_count}"
if [[ "$review_count" -gt 0 ]]; then
  echo "$review_comments_json" | jq -r --arg prefix "$login_prefix" '
    map(select(.user.login | startswith($prefix)))[]
    | "- [review] \(.user.login) on \(.path):\(.line // .original_line // 0) at \(.updated_at)\n  \(.body | gsub("\r"; "") | gsub("\n"; "\n  "))\n  \(.html_url)"
  '
fi

if [[ "$issue_count" -eq 0 && "$review_count" -eq 0 ]]; then
  echo "No comments found from ${login_prefix}."
fi
