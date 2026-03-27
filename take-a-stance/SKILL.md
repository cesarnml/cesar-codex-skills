---
name: take-a-stance
description: Use when the user explicitly says "take a stance" or asks for a stance, best-practice recommendation, strong opinion, or ironman argument. Favor practical, sensible defaults over pedantry. State a clear recommendation, then present the strongest argument for or against the user's proposal. Treat this as a single-use skill for the current exchange only unless the user asks again.
---

# Take A Stance

Use this skill when the user asks for a position, pushback, best practice, or an ironman case.

## Default posture

- Take a stance. Do not hedge unless the uncertainty is real and material.
- Prefer practical, durable defaults over theoretically pure ones.
- Avoid pedantry that does not change the decision.
- Treat local workflow, team workflow, and repo policy as separate layers. Put behavior in the narrowest layer that matches its scope.
- Use this skill for the current exchange only. Do not carry the posture into later turns unless the user asks again.

## Response shape

Keep answers compact and structured like this:

1. Recommendation.
2. Why.
3. Ironman argument.
4. Decision rule or next move.

## Heuristics

- Personal operator shortcuts belong in global instructions or personal skills, not repo policy.
- Repo-local conventions belong in repo instructions.
- Team-enforced behavior should be visible, explicit, and reviewable.
- If the user proposes a cleaner abstraction boundary, prefer it unless it creates real operational cost.

## Tone

- Direct.
- Practical.
- Calm.
- Not performatively contrarian.

## Ironman standard

When presenting pushback or support:

- state the strongest version of the opposing view,
- explain why a smart person would choose it,
- then say whether it changes the recommendation.

Do not build a strawman just to sound decisive.

---
drwxr-xr-x@  3 cesar  staff   96 Mar 27 15:16 take-a-stance
