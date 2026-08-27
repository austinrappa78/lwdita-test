# AGENTS.md — Working Rules for AI Authoring

This repository is managed by **Pelcrow**, the reference desk and fact-checker for AI authoring agents.

<!-- pelcrow:managed:start -->
<!-- pelcrow:schema-version:sha256:0b880597c837eb3a -->
<!-- Generated deterministically by Pelcrow from the live content index. -->
<!-- Do not edit inside this block: it is overwritten on every regeneration. -->

## Core Operating Principles

1. **Search before writing**: call `search_documents` for existing topics, then use `search_keys` and `resolve_key` for reusable facts and passages. Never rewrite content that already exists.
2. **Stop before duplicating a topic**: when `search_documents` reports high duplicate risk, stop before drafting and ask the user to choose reuse, update, variant, or an intentionally separate topic. Reuse the existing topic through the publication map whenever it already satisfies the need.
3. **Reuse keys, not paths**: everything is addressed by namespaced key (`repo:key`), never by file path. Include shared passages by referencing their key.
4. **Never invent factual variables**: product names, version numbers, URLs, and environment flags must be referenced via keyrefs — never guessed or hardcoded.
5. **Use only verified source details**: only state behavior, UI labels, prerequisites, supported formats, and procedure steps supported by a cited source or verified existing documentation. Do not turn plausible assumptions into instructions.
6. **Record provenance**: every new or updated document must cite what produced it in a frontmatter `sources:` list (plural — not `source:`) — one or more opaque IDs such as `commit:abc123`, `ticket:JIRA-42`, or a spec name/URL. This is what staleness tracking keys off; a document with no `sources:` entry, or the wrong field name, can never be flagged stale when its source changes.
7. **Check before filing**: run every draft through `validate_draft` before committing content — this already includes terminology checking. Use `check_terminology` on its own to check a smaller piece of text (before it's assembled into a full draft) for banned/avoid terms and their preferred replacements.
8. **File through Pelcrow automatically**: after the checks pass, use `file_with_provenance` for every completed repository document and every supporting file changed to integrate it, including maps and navigation files. File each required change before claiming completion. Do not make users learn this tool name or add it to their prompt. Do not substitute a native filesystem write merely because one is available.
9. **Name files descriptively**: file names must be kebab-case and derived from the topic's actual subject, matching this repository's existing convention (e.g. `configure-retention-policies.dita`, `knox-compatibility-matrix.md`) — never generic names like `overview.md`, `usage.md`, or `index.md` that say nothing about what the topic covers.
10. **Look up ticket references yourself, don't trust a paraphrase**: Pelcrow has no access to any issue-tracker system (Jira, Linear, GitHub Issues, etc.) — if the task mentions a ticket ID that will end up in `sources:` as `ticket:ID`, and a ticket-tracker MCP server is also available to you in this session, search it directly for that ticket's actual current title, description, and status before drafting. A secondhand summary pasted into the conversation can be stale, incomplete, or wrong; the ticket itself is the source of truth you're citing.
11. **Search for a ticket before assuming there isn't one**: if you're asked to draft something without a ticket ID being named, and a ticket-tracker MCP server is available, search it for anything that plausibly matches the topic before you start — don't just proceed source-less because none was handed to you. If you find a real candidate, confirm with the user which one (if any) applies before citing it; never guess an ID. If nothing plausible turns up, or no tracker is available, that's fine — `sources:` accepts `commit:`, `spec:`, or a URL just as well, and a ticket citation specifically is never mandatory.

## Repository and Write Boundary

- **Destination repository**: the repository containing this `AGENTS.md` is the destination repository for authored content. Resolve every relative output path from this repository root, not from the location of an email, ticket export, specification, attachment, or other source document.
- **Write boundary**: create or update documentation only inside this destination repository unless the user explicitly names a different destination repository. Before writing, resolve the proposed path and verify that it remains inside this repository; if it does not, stop and correct the path.
- **External sources are read-only**: source material may live in Downloads, Documents, Jira, Confluence, another repository, or any other readable location. Reading a source never authorizes writing beside it, and its directory structure must never determine the output directory.
- **Follow the destination structure**: inspect this repository's maps and existing content hierarchy before choosing a path. In a DITA/MDITA repository that already uses a `topics/` hierarchy, place new authored topics under the appropriate `topics/<subject>/` subfolder in this repository.
- **Generated output is not source**: never read from, edit, or create authored content under the configured build-output directory (organization default: `out/`). Pelcrow excludes these directories from its content index and workspace.
- **Keep provenance separate from placement**: cite external inputs in `sources:` metadata, but keep the authored document in the destination repository's content hierarchy.
- **Governed writes only**: when `file_with_provenance` is available, it is the write path for completed documents in this repository. Native file-write tools are for temporary working material only, not the finished topic.
- **Govern the whole change**: if a topic also requires a map, navigation, manifest, or other supporting-file update, file every changed repository file through Pelcrow before claiming completion. Do not file the topic and then edit its map with a native filesystem tool.
- **Report the destination Pelcrow returns**: after filing, use the tool response’s repository-qualified `destination` or repository-relative `filePath` exactly. Never resolve that relative path against the agent workspace or MCP server directory, and never invent an absolute path or `file:` URI that Pelcrow did not return.

## MDITA Authoring Syntax

- **Variable**: `<span data-keyref="repo:key"></span>` (optional literal fallback text inside the span).
- **Block transclusion**: `<div data-conref="repo:key"></div>`; inline: `<span data-conref="repo:key"></span>`.
- **Conditional content**: use standard `data-props`. Generic values are whitespace-separated, e.g. `<p data-props="cloud internal">…</p>`. When the condition dimension matters, preserve it with parenthesized groups, e.g. `<p data-props="platform(cloud) audience(admin)">…</p>`. Both forms are valid; do not invent plain `platform=`, `audience=`, or `product=` HTML attributes.
- **Key definition**: `<div data-key="key-name">shared content</div>`, or frontmatter `id:` / `keys:` entries.

**Contiguous HTML constraint**: wrapping block tags (`data-props`, `data-conref`) and their contents must be authored as contiguous raw HTML with **no interior blank lines** after the opening tag or before the closing tag. Interior blank lines cause DITA-OT to split the element into un-paired siblings, letting conditional content silently escape filtering.

## Mandatory Metadata

Every document's YAML frontmatter must set: title, status, owner, audience, platform, type.
- `status`: required — one of draft | review | approved | published | deprecated
- `type`: required — one of concept | task | reference. DITA topic type: concept (explanations/architecture), task (ordered procedures/how-tos), or reference (APIs/schemas/tables).
The migration placeholders title: 'Untitled Document' and owner: 'unassigned' must be replaced before commit; the validation gate rejects them on strictly tracked files.
This list is managed centrally (org settings), not edited per-repo. `.pelcrow/config.json` in this repository is a **read-only synced copy** of it, kept here for visibility — regenerated from the source of truth on every push, so hand-editing it has no effect and any edits will be silently overwritten.
**Current document owner:** set `owner: pelcrow`. Pelcrow resolved this identity for the current authoring session. Do not replace it with a reporter, assignee, email sender/recipient, or another person named in source material.
**Don't guess `owner`.** A person named in an email, ticket, or spec (reporter, requester, stakeholder) is not automatically the document's owner. `file_with_provenance` overwrites this field with the operator's own git identity at commit time regardless of what you put there, so leave it as the placeholder value rather than inventing a plausible-looking name from the source material.

## Validation Gate (hard failures)

- **Unresolved references**: every `data-keyref`/`data-conref` must resolve to an existing key definition.
- **Duplicate definitions**: a key defined more than once in the global namespace is rejected.
- **Transclusion cycles**: reuse loops (A → B → A) are forbidden.
- **Missing metadata**: required frontmatter fields must be present (see Mandatory Metadata).
- **Invalid metadata value**: metadata values with permitted options must match one of the allowed values.
- **Malformed frontmatter**: YAML that fails to parse is rejected.
- **Banned terminology**: any term in the organization's termbase is flagged with its preferred replacement.

HTML elements inside fenced code blocks are treated as literal example code and are never indexed as live references.

**This is not optional and it is not this document asking nicely.** Every commit to this repository — filed through `file_with_provenance`, written by hand, or produced by a tool that never called any Pelcrow MCP tool — is re-validated against these exact rules before it can merge. Calling `validate_draft`/`check_terminology` while drafting only changes when you find out about a problem, not whether it will be caught. Treat a hard failure here as equivalent to a failing test blocking a merge, because that is what it is.

## Indexed Repositories

- `docs` — 8 document(s), 0 key(s)
- `pelcrow-testcases` — 0 document(s), 0 key(s)

## Current Keys & Variables

_No keys defined yet._

## DITA-OT Operational Rules

- **Hands off the local DITA-OT installation**: do NOT install, uninstall, reinstall, reintegrate, or edit any file inside a local DITA-OT installation (`DITA_HOME`/`DITA_OT` paths). The toolkit setup is managed by the user.
- **Windows invocation**: always use `dita.bat` when running builds under Windows/git-bash; the Unix `bin/dita` script produces classpath resolution errors on Windows.

## MCP Integration (Crucial)

**You MUST connect to and use the Pelcrow MCP server.** This repository is part of a larger, interconnected content graph managed by Pelcrow. If you are an AI assistant editing this content:

- **Do not guess or hallucinate.** Use `search_documents` to find existing topics and `search_keys`/`resolve_key` to find reusable variables and snippets.
- **Stop on duplicate risk.** If `search_documents` returns `actionRequired: true`, do not draft. Show the candidate to the user and ask whether to reuse it in the map, update it, create a distinct variant, or intentionally create a separate topic. Never choose or fabricate an override yourself.
- **Ground every claim.** Only include behavior, UI labels, prerequisites, supported formats, and procedure steps explicitly supported by cited sources or verified existing documentation. Omit unsupported details or identify them as needing confirmation; plausible inference is not evidence.
- **Validate before you save.** Before presenting a final plan or running a git commit, you must run your proposed changes through the `validate_draft` tool.
- **Respect terminology.** Use the `check_terminology` tool to ensure compliance with the organization's style guide.
- **Use the governed save path automatically.** When the user asks you to create, update, write, or finish repository documentation, call `file_with_provenance` after validation instead of writing the finished file with a native filesystem tool. The user does not need to know or name this internal tool. A normal request to create or update repository content authorizes this governed filing step; only stop before filing when the user explicitly asks for a preview/draft only, asks for no commit, or the tool is unavailable.
- **Never bypass governance silently.** If `file_with_provenance` is unavailable or rejects the document, do not quietly write the file another way. Return the validated draft and explain what prevented governed filing.

## Organization Writing Guide

**Guide: Technical documentation**

Clear, consistent guidance for product documentation.

### Voice & tone

#### Use a direct, helpful tone (warning)

Address the reader as “you.” Use a neutral, direct, and helpful tone. Avoid “simply,” “obviously,” and “just” when describing a task.

**Use:**

```markdown
Select Save to apply your changes.
```

**Avoid:**

```markdown
Obviously, the user should simply click Save.
```

### Headings

#### Use sentence case for headings (required)

Write headings in sentence case. Capitalize only the first word and proper nouns. Do not end headings with a period.

**Use:**

```markdown
Configure retention policies
```

**Avoid:**

```markdown
Configure Retention Policies.
```

### Procedures

#### Start steps with an action (required)

Start each procedure step with an imperative verb and keep one primary action in each step. Use numbered lists for sequential actions.

**Use:**

```markdown
1. Open the Settings page.
```

**Avoid:**

```markdown
1. The Settings page should be opened.
```

### Notes

#### Use one note format (required)

Format notes as a GitHub-style admonition with an uppercase label. Use only NOTE, TIP, IMPORTANT, CAUTION, or WARNING.

**Use:**

```markdown
> [!NOTE]
> Restart the service for the change to take effect.
```

**Avoid:**

```markdown
**Note:** Restart the service.
```

### Tables

#### Keep tables consistent (required)

Introduce each table with a complete sentence. Include a non-empty header row, use sentence case for headers, and left-align text columns.

**Use:**

```markdown
The following table lists the available settings.

| Setting | Description |
|:--|:--|
```

**Avoid:**

```markdown
| SETTING | DESCRIPTION |
|:-:|:-:|
```

### Lists

#### Use parallel list items (warning)

Begin items in the same list with the same grammatical form. Use bullets for nonsequential information and numbers for sequential actions.

### Accessibility

#### Write descriptive link text (required)

Use link text that identifies the destination without surrounding context. Do not use “click here,” “here,” or a raw URL as link text.

**Use:**

```markdown
See [Configure retention policies](…).
```

**Avoid:**

```markdown
For more information, [click here](…).
```

### Custom

#### Use only verified source details (required)

Only include product behavior, UI labels, prerequisites, supported formats, and procedure steps that are explicitly supported by cited sources or verified existing documentation. Do not infer missing steps or capabilities. Omit unsupported details or identify them as needing confirmation.

Why: A plausible procedure that is not supported by a source is still incorrect documentation.

**Use:**

```markdown
The denylist takes precedence over the allowlist.
```

**Avoid:**

```markdown
Select your project, enter an IPv6 CIDR range, and select Add. (when those details are not present in a cited source)
```

<!-- pelcrow:managed:end -->

## Customer Rules

<!-- pelcrow:customer:start -->
_Add your team's own rules here. Pelcrow never modifies this section._
<!-- pelcrow:customer:end -->
