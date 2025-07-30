# lwdita-test

This project demonstrates key authoring and publishing use cases for Lightweight DITA (LwDITA) and Markdown, validating compatibility with enterprise documentation requirements.

## How to Build

### Generate PDF Output
```sh
dita -i admin-guide.ditamap -f pdf -o out/pdf/admin-guide
```

### Generate HTML5 Output
```sh
dita -i admin-guide.ditamap -f html5 -o out/html/admin-guide
```

## Use Case Coverage

| # | Use Case Description | Success? | Example File(s) | Can it be done in DITA XML? |
|---|----------------------|----------|------------------|----------------------------|
| 1 | Tables Within Procedural Steps | ✅ Yes | knox-installation.md (Step 3 table) | ✅ Yes (`<table>` inside `<step>` or `<li>`) |
| 2 | Copy Tables and Inline Text | ✅ Yes | knox-compatibility-matrix.md | ✅ Yes (`<table>`, `<ph>`, `<xref>`, etc.) |
| 3 | Nested Steps / Sub-Procedures | ✅ Yes | knox-advanced-setup.md (multi-level bullets) | ✅ Yes (`<substeps>` in `<step>`, nested lists) |
| 4 | Conditional Content / Output Filtering | ✅ Yes | knox-conditional-notes.md, DITA topics with profiling attributes | ✅ Yes (profiling attributes: product, audience, platform, etc.) |
| 5 | Modular Topic Referencing (Reusability) | ✅ Yes | knox-shared-snippets.md, DITA maps | ✅ Yes (`<conref>`, `<keyref>`, `<topicref>`) |
| 6 | Rich Inline Elements | ✅ Yes | All topics (inline notes, code, UI formatting, bold/italic) | ✅ Yes (`<note>`, `<codeph>`, `<uicontrol>`, `<b>`, `<i>`) |
| 7 | Inline Hyperlinks, GIFs, Images, Tables | ✅ Yes | All topics (Markdown links/images, DITA `<xref>`, `<image>`, `<table>`) | ✅ Yes (`<xref>`, `<image>`, `<table>`) |
| 8 | Integrated Walkthroughs/Multi-Panel Layouts | ⚠️ Not Yet | Not shown, but possible in Markdown with HTML5 `<details>`, tabs; DITA needs specialization or HTML5 output | ⚠️ Possible with HTML5 output/customization |
| 9 | Output Support for Mixed Formats | ✅ Yes | Workspace setup (DITA-OT, Markdown+DITA XML) | ✅ Yes (DITA-OT supports HTML5, PDF, JSON/XML with plugins) |

---
