# AGENTS.md — Working Rules for AI Authoring

This repository is managed by **Pelcrow**, the reference desk and fact-checker for AI authoring agents.

<!-- pelcrow:managed:start -->
<!-- Generated deterministically by Pelcrow from the live content index. -->
<!-- Do not edit inside this block: it is overwritten on every regeneration. -->

## Core Operating Principles

1. **Search before writing**: query the content index (`search_keys`, `resolve_key`) before drafting. Never rewrite content that already exists.
2. **Reuse keys, not paths**: everything is addressed by namespaced key (`repo:key`), never by file path. Include shared passages by referencing their key.
3. **Never invent factual variables**: product names, version numbers, URLs, and environment flags must be referenced via keyrefs — never guessed or hardcoded.
4. **Record provenance**: every new or updated document must record its source (commit SHA, ticket, PR, or specification document).
5. **Check before filing**: run every draft through `validate_draft` before committing content — this already includes terminology checking. Use `check_terminology` on its own to check a smaller piece of text (before it's assembled into a full draft) for banned/avoid terms and their preferred replacements.

## MDITA Authoring Syntax

- **Variable**: `<span data-keyref="repo:key"></span>` (optional literal fallback text inside the span).
- **Block transclusion**: `<div data-conref="repo:key"></div>`; inline: `<span data-conref="repo:key"></span>`.
- **Conditional content**: grouped `data-props` form, e.g. `<p data-props="platform(cloud) audience(admin)">…</p>`.
- **Key definition**: `<div data-key="key-name">shared content</div>`, or frontmatter `id:` / `keys:` entries.

**Contiguous HTML constraint**: wrapping block tags (`data-props`, `data-conref`) and their contents must be authored as contiguous raw HTML with **no interior blank lines** after the opening tag or before the closing tag. Interior blank lines cause DITA-OT to split the element into un-paired siblings, letting conditional content silently escape filtering.

## Mandatory Metadata

Every document's YAML frontmatter must set: title, status, owner, audience, platform.
The migration placeholders title: 'Untitled Document' and owner: 'unassigned' must be replaced before commit; the validation gate rejects them on strictly tracked files.

## Validation Gate (hard failures)

- **Unresolved references**: every `data-keyref`/`data-conref` must resolve to an existing key definition.
- **Duplicate definitions**: a key defined more than once in the global namespace is rejected.
- **Transclusion cycles**: reuse loops (A → B → A) are forbidden.
- **Missing metadata**: required frontmatter fields must be present (see Mandatory Metadata).
- **Malformed frontmatter**: YAML that fails to parse is rejected.
- **Banned terminology**: any term in the organization's termbase is flagged with its preferred replacement.

HTML elements inside fenced code blocks are treated as literal example code and are never indexed as live references.

**This is not optional and it is not this document asking nicely.** Every commit to this repository — filed through `file_with_provenance`, written by hand, or produced by a tool that never called any Pelcrow MCP tool — is re-validated against these exact rules before it can merge. Calling `validate_draft`/`check_terminology` while drafting only changes when you find out about a problem, not whether it will be caught. Treat a hard failure here as equivalent to a failing test blocking a merge, because that is what it is.

## Indexed Repositories

- `docs` — 8 document(s), 0 key(s)

## Current Keys & Variables

_No keys defined yet._

## DITA-OT Operational Rules

- **Hands off the local DITA-OT installation**: do NOT install, uninstall, reinstall, reintegrate, or edit any file inside a local DITA-OT installation (`DITA_HOME`/`DITA_OT` paths). The toolkit setup is managed by the user.
- **Windows invocation**: always use `dita.bat` when running builds under Windows/git-bash; the Unix `bin/dita` script produces classpath resolution errors on Windows.

## MCP Integration (Crucial)

**You MUST connect to and use the Pelcrow MCP server.** This repository is part of a larger, interconnected content graph managed by Pelcrow. If you are an AI assistant editing this content:

- **Do not guess or hallucinate.** You must use the `search_keys` and `resolve_key` MCP tools to find existing variables, topics, and snippets.
- **Validate before you save.** Before presenting a final plan or running a git commit, you must run your proposed changes through the `validate_draft` tool.
- **Respect terminology.** Use the `check_terminology` tool to ensure compliance with the organization's style guide.

<!-- pelcrow:managed:end -->

## Customer Rules

<!-- pelcrow:customer:start -->
_Add your team's own rules here. Pelcrow never modifies this section._
<!-- pelcrow:customer:end -->
