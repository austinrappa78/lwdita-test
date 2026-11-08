# AGENTS.md — Working Rules for AI Authoring

This repository is managed by **Pelcrow**, the reference desk and fact-checker for AI authoring agents.

<!-- pelcrow:managed:start -->
<!-- pelcrow:schema-version:sha256:1671d563b9542243 -->
<!-- Generated deterministically by Pelcrow from the live content index. -->
<!-- Do not edit inside this block: it is overwritten on every regeneration. -->

## Publication Placement and Authoring Paths

**Every new topic must be registered in a publication map.** Inspect the destination publication and existing folder conventions before drafting. Use the effective topic folder below, choosing the appropriate subject subfolder. Preserve map hierarchy and format; filesystem folders need not mirror outline headings.
Select the correct root publication and map position. If selection or placement is ambiguous, ask the user; never guess or leave an orphan. When no map exists, create a descriptive root map in the effective publication folder using the project format (.mditamap for MDITA, .ditamap for DITA). Preserve any existing .ditamap, .mditamap or bookmap; never convert formats implicitly. Other formats require their native navigation or publication structure, not an invented DITA map.
Treat the topic and supporting map edits as one change. Run validate_draft with file_path, publication_root and supporting_files containing the full proposed map contents. Draft validity alone does not prove publication completion. Publication readiness refers to the exact proposed bytes, not proof that local files were saved; inspect the saved topic and maps before reporting completion. Keep all agent writes local and uncommitted unless the user explicitly authorizes version-control or hosted writes.

| Repository | Topic folder | Publication root folder | Content ref | New map format when absent |
| --- | --- | --- | --- | --- |
| `docs` | `topics` | `.` | provider working tree/default ref | native publication structure |

## Core Operating Principles

1. **Search before writing**: call `search_documents` for existing topics, then use `search_keys` and `resolve_key` for reusable facts and passages. Never rewrite content that already exists.
2. **Stop before duplicating a topic**: when `search_documents` reports high duplicate risk, stop before drafting and ask the user to choose reuse, update, variant, or an intentionally separate topic. Reuse the existing topic through the publication map whenever it already satisfies the need. The same applies when you find a matching topic yourself while browsing files, and when `validate_draft` reports `existing-document` or `possible-duplicate-topic`. A request to write a new topic never authorizes changing an existing one: never overwrite or rewrite an existing document unless the user asked to change that document.
3. **Reuse keys, not paths**: reference shared content by key, never by file path. Write the bare key (`product-name`); it always means your own project's definition. Qualify a key (`other-repo:key`) only to deliberately use another project's. Pass `repoId` to `resolve_key` and it tells you which form to write.
4. **Never invent factual variables**: product names, version numbers, URLs, and environment flags must be referenced via keyrefs — never guessed or hardcoded.
5. **Use only verified source details**: only state behavior, UI labels, prerequisites, supported formats, and procedure steps supported by a cited source or verified existing documentation. Do not turn plausible assumptions into instructions.
6. **Record provenance**: every new or updated document must cite the original sources that produced it in a frontmatter `sources:` list (plural — not `source:`) — one or more opaque IDs such as `commit:abc123`, `ticket:JIRA-42`, or a spec name/URL. This is what staleness tracking keys off; a document with no `sources:` entry, or the wrong field name, can never be flagged stale when its source changes. `sources` holds original sources only: the ticket, commit, spec, email or URL the facts came from, never a repo document. When you build a document from existing repo documents, list those documents in a frontmatter `derivedFrom:` list, and add their original sources to `sources` only after checking them (`validate_draft` offers them as inherited and unverified). If none is known, cite none and say the original source is unknown; never cite the repo documents instead. State a document's sources only from its metadata or a Pelcrow response, never from a related document or memory. Take both lists from `validate_draft`'s `citations`, passing the same `taskId` on every call: it lists what Pelcrow can back (documents on the working branch your draft shares text or stated values with, restates or was delivered, the sources those documents cite, and sources reported on the task's change record). Add an entry it does not list only after reporting where it came from with `describe_change`; `validate_draft` flags every entry it cannot back.
7. **Check before saving**: run every draft through `validate_draft` before writing the finished content locally — this already includes terminology checking. Use `check_terminology` on its own to check a smaller piece of text (before it's assembled into a full draft) for banned/avoid terms and their preferred replacements.
8. **Save locally and stop**: after the checks pass, use native filesystem tools to create or update every required topic, map, navigation file, or manifest in the requested local output folder. Do not commit, push, open a pull request, or write through a hosted repository API unless the user separately and explicitly asks for that exact version-control action.
9. **Name files descriptively**: file names must be kebab-case and derived from the topic's actual subject, matching this repository's existing convention (e.g. `configure-retention-policies.dita`, `knox-compatibility-matrix.md`) — never generic names like `overview.md`, `usage.md`, or `index.md` that say nothing about what the topic covers.
10. **Look up ticket references yourself, don't trust a paraphrase**: Pelcrow has no access to any issue-tracker system (Jira, Linear, GitHub Issues, etc.) — if the task mentions a ticket ID that will end up in `sources:` as `ticket:ID`, and a ticket-tracker MCP server is also available to you in this session, search it directly for that ticket's actual current title, description, and status before drafting. A secondhand summary pasted into the conversation can be stale, incomplete, or wrong; the ticket itself is the source of truth you're citing.
11. **Search for a ticket before assuming there isn't one**: if you're asked to draft something without a ticket ID being named, and a ticket-tracker MCP server is available, search it for anything that plausibly matches the topic before you start — don't just proceed source-less because none was handed to you. If you find a real candidate, confirm with the user which one (if any) applies before citing it; never guess an ID. If nothing plausible turns up, or no tracker is available, that's fine — `sources:` accepts `commit:`, `spec:`, or a URL just as well, and a ticket citation specifically is never mandatory.
12. **Keep the job trace**: Pass the `taskId` from your first Pelcrow call on every later call for the same job; never reuse a `taskId` across unrelated jobs.

## Repository and Write Boundary

- **Destination repository**: the repository containing this `AGENTS.md` is the destination repository for authored content. Resolve every relative output path from this repository root, not from the location of an email, ticket export, specification, attachment, or other source document.
- **Write boundary**: create or update documentation only inside this destination repository unless the user explicitly names a different destination repository. Before writing, resolve the proposed path and verify that it remains inside this repository; if it does not, stop and correct the path.
- **External sources are read-only**: source material may live in Downloads, Documents, Jira, Confluence, another repository, or any other readable location. Reading a source never authorizes writing beside it, and its directory structure must never determine the output directory.
- **Follow the destination structure**: inspect this repository's maps and existing content hierarchy before choosing a path. In a DITA/MDITA repository that already uses a `topics/` hierarchy, place new authored topics under the appropriate `topics/<subject>/` subfolder in this repository.
- **Generated output is not source**: never read from, edit, or create authored content under the configured build-output directory (organization default: `out/`). Pelcrow excludes these directories from its content index and workspace.
- **Keep provenance separate from placement**: cite external inputs in `sources:` metadata, but keep the authored document in the destination repository's content hierarchy.
- **Local writes only by default**: write completed documents with native filesystem tools inside this repository’s local working tree. A documentation request does not authorize any remote repository mutation.
- **Complete the local change**: if a topic also requires a map, navigation, manifest, or other supporting-file update, make every required local edit before claiming the content is ready for review.
- **Leave Git to the user**: do not commit, push, open a pull request, or call a hosted write API unless the user separately and explicitly requests that exact action. Report the repository-relative paths changed so the user can review and check them in.

## MDITA Authoring Syntax

## MDITA Authoring Syntax

### Maps and publication structure

For a new LwDITA publication, prefer an `.mditamap` file. Use Markdown list links to define the topic order and nest list items to define the TOC hierarchy.

Example:

```markdown
# Product documentation

- [Introduction](introduction.md)
- [Installation](installation.md)
  - [System requirements](system-requirements.md)
  - [Install the product](install.md)
- [Configuration](configuration.md)
```

An existing XML `.ditamap` is also supported and can reference MDITA `.md` topics. If the project already uses a `.ditamap`, preserve that format and update its `<topicref>` structure. Do not convert between `.mditamap` and `.ditamap` unless the user explicitly requests it.

Example:

```xml
<map>
  <title>Product documentation</title>
  <topicref href="introduction.md" format="mdita"/>
  <topicref href="installation.md" format="mdita">
    <topicref href="system-requirements.md" format="mdita"/>
    <topicref href="install.md" format="mdita"/>
  </topicref>
  <topicref href="configuration.md" format="mdita"/>
</map>
```

Use these rules:

- New LwDITA map: prefer `.mditamap`.
- Existing `.mditamap`: continue using `.mditamap`.
- Existing `.ditamap`: continue using `.ditamap`.
- MDITA topic referenced by XML: use `format="mdita"`.
- Preserve the existing topic order, hierarchy, attributes, keys, metadata, and map references unless the task requires changing them.
- Do not introduce YAML map declarations.
- Do not place XML `<topicref>` markup inside an `.mditamap`.
- Do not place Markdown list syntax inside a `.ditamap`.
- Do not convert an XML `.bookmap` into an `.mditamap`. Bookmap is a full-DITA structure.

### Variables in MDITA

Use `[variable]` to insert a variable.

Example:

```markdown
Welcome to [product-name].
```

Use variables already defined for the publication. Do not define variables inside an ordinary topic. Write the bare key for your own project's variables. Qualify it as `other-repo:key` only to deliberately use another project's key; a DITA-OT build can't resolve a qualified key.

- **XML `.ditamap` key definitions are map-scoped, never in the topic or its frontmatter**: for an existing full-DITA `.ditamap`, declared via `<keydef keys="key-name" href="topics/target.dita"/>` (or any `keys`-bearing `<topicref>`). Frontmatter (`id:`, singular `key:`, etc.) is document metadata, never a key registry on its own; `data-key` (singular) is not the specification's `data-keys` and is not a recognized key-definition mechanism.
- **Key value (generate this form)**: `<topicmeta><keywords><keyword>Effective Value</keyword></keywords></topicmeta>` inside the `<keydef>` — Pelcrow's current generated standard for a pure variable, matching what Pelcrow's own Map Editor "Add Variable" UI writes. `<topicmeta><linktext>Effective Value</linktext></topicmeta>` is also a valid DITA effective-key-content representation (permitted as general fallback effective content, not only a link's display label) and Pelcrow reads it as a fallback, but do not generate it for a new pure variable — a future organization-level policy may select it as the enforced form instead. Both forms normalize to the same internal key/value semantics.
- **Block transclusion**: `<div data-conref="key"></div>`; inline: `<span data-conref="key"></span>`.
- **Conditional content**: use standard `data-props`. Generic values are whitespace-separated, e.g. `<p data-props="cloud internal">…</p>`. When the condition dimension matters, preserve it with parenthesized groups, e.g. `<p data-props="platform(cloud) audience(admin)">…</p>`. Both forms are valid; do not invent plain `platform=`, `audience=`, or `product=` HTML attributes.

**Contiguous HTML constraint**: wrapping block tags (`data-props`, `data-conref`) and their contents must be authored as contiguous raw HTML with **no interior blank lines** after the opening tag or before the closing tag. Interior blank lines cause DITA-OT to split the element into un-paired siblings, letting conditional content silently escape filtering.

## Publication Variable Files

Add or update variable definitions only in the file named for that publication. Select the publication by its root map; do not create a second variables file.

| Publication map | Variables file | Chosen from |
| --- | --- | --- |
| `admin-guide.ditamap` | `keys.ditamap` | existing definitions |

## Mandatory Metadata

Every document's YAML frontmatter must set: title, owner, type, journeyStage, useCases, audience, platform.
- `type`: required — one of concept | task | reference | troubleshooting.
- `journeyStage`: required. Where in the customer journey this topic sits.
- `useCases`: required. Which of the organization's defined use cases this topic covers.

## Validation Gate (hard failures)

- **Unresolved references**: every `[key-name]`/`data-keyref`/`data-conref` must resolve to an existing key definition (keys are declared in a map, not the topic or its frontmatter).
- **Duplicate definitions**: a key defined more than once in the global namespace is rejected.
- **Transclusion cycles**: reuse loops (A → B → A) are forbidden.
- **Missing metadata**: required frontmatter fields must be present.

## Pelcrow Repositories

Valid repository IDs for Pelcrow tools, and for qualifying another project's key: `azure-docs`, `docs`, `lwdita-code-samples`, `pelcrow-test-dita`, `pelcrow-testcases`.

## DITA-OT Operational Rules

- **Hands off the local DITA-OT installation**: do NOT install, uninstall, reinstall, reintegrate, or edit any file inside a local DITA-OT installation (`DITA_HOME`/`DITA_OT` paths). The toolkit setup is managed by the user.
- **Windows invocation**: always use `dita.bat` when running builds under Windows/git-bash; the Unix `bin/dita` script produces classpath resolution errors on Windows.

## MCP Integration (Crucial)

**You MUST connect to and use the Pelcrow MCP server.** This repository is part of a larger, interconnected content graph managed by Pelcrow. If you are an AI assistant editing this content:

- **Do not guess or hallucinate.** Use `search_documents` to find existing topics and `search_keys`/`resolve_key` to find reusable variables and snippets.
- **Pass the context the user named.** When the request names a product, version, platform or audience, pass it as `context` to `search_documents`, `fetch`, `resolve_key` and `find_reuse` (`search_documents` takes the version as `version`). Content for any other context is then left out or cut, and `excludedForContext` or `variant` says why. If `eligibility.status` is `unavailable`, the results were not scoped: tell the user rather than treating them as applicable.
- **Stop on duplicate risk.** If `search_documents` returns `actionRequired: true`, do not draft. Show the candidate to the user and ask whether to reuse it in the map, update it, create a distinct variant, or intentionally create a separate topic. Never choose or fabricate an override yourself. The same applies to a matching topic you find on your own and to a `validate_draft` `existing-document` or `possible-duplicate-topic` finding: a request for a new topic is never permission to overwrite an existing one.
- **Ground every claim.** Only include behavior, UI labels, prerequisites, supported formats, and procedure steps explicitly supported by cited sources or verified existing documentation. Omit unsupported details or identify them as needing confirmation; plausible inference is not evidence.
- **Validate before you save.** Before writing a finished topic to the local working tree, run the proposed content through the `validate_draft` tool.
- **Declare factual prose claims.** Call `validate_draft` with `prose_blocks: true`, then again with `claims` (schema `pel-379-v1`): copy spans exactly from the returned block text, keep qualifiers ("at most", "primarily", "does not") as operator and qualifier spans, and never declare advice, design goals or a "but not in X" exclusion as a claim. Declarations never block a save; claims with unverified spans go to review.
- Then run `check_claims` with the same declaration as `declaration` and the source files you used as `evidence`. It checks exactly your declared claims and returns each one’s verdict in `declaredClaims`. Resolve every contradicted, stale or other-product claim before saving.
- When you finish a job, call record_answer with the job's taskId, the traceIds you relied on, a SHA-256 of your answer, and each claim with the itemIds it relies on. Citing an item does not mean it supports your claim; Pelcrow checks that separately.
- **Respect terminology.** Use the `check_terminology` tool to ensure compliance with the organization's style guide.
- **Save finished content locally.** Save the topic and every required map edit together. New topics always belong to a publication. Pass `publication_root` and proposed map bytes in `supporting_files` to `validate_draft`; a valid topic alone is not publication readiness. Verify saved files match the validated bytes before reporting completion.
- **Stop before version-control actions.** Creating or updating documentation does not authorize a commit, push, pull request, or remote repository write. Leave the validated files in the local working tree for the user to review and check in. Only run a version-control action when the user separately and explicitly requests that exact action.

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
