---
name: "openai-docs"
description: "Use for OpenAI product or API questions that need current official docs, citations, model selection, or GPT-5.4 upgrade guidance. Prefer OpenAI docs MCP tools and only fall back to official OpenAI web sources."
---

# OpenAI Docs

OpenAI docs are the source of truth.

## Tool Order

1. `mcp__openaiDeveloperDocs__search_openai_docs`
2. `mcp__openaiDeveloperDocs__fetch_openai_doc`
3. `mcp__openaiDeveloperDocs__list_openai_docs` only for discovery
4. Fallback web search only if MCP is unavailable or useless

## Workflow

1. Classify the request:
- general docs lookup
- model selection
- GPT-5.4 upgrade
- GPT-5.4 prompt upgrade

2. Load references only if needed:
- `references/latest-model.md`
- `references/upgrading-to-gpt-5p4.md`
- `references/gpt-5p4-prompting-guide.md`

3. Search precisely.
4. Fetch the exact section.
5. Answer briefly with citations.

## Rules

- Verify volatile guidance against current docs.
- Keep quotes short.
- If docs conflict, cite both.
- If MCP fails, use only official OpenAI domains.
