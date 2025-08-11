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

| # | Use Case Description | Markdown? | DITA XML? | Example File(s) |
|---|----------------------|----------|----------------------------|------------------|
| 1 | Tables Within Procedural Steps | ✅ Yes | ✅ Yes (`<table>` inside `<step>` or `<li>`) | [knox-installation.md](topics/recovery/knox-installation.md) |
| 2 | Copy Tables and Inline Text | ⚠️ Not Yet | ✅ Yes | [Plugin Example](https://github.com/oxygenxml/web-author-sample-plugins/tree/master/web-author-paste-actions) |
| 3 | Nested Steps / Sub-Procedures | ✅ Yes | ✅ Yes (`<substeps>` in `<step>`, nested lists) | [knox-advanced-setup.md](topics/recovery/knox-advanced-setup.md) (multi-level bullets) |
| 4 | Conditional Content / Output Filtering | ✅ Yes | ✅ Yes (profiling attributes: product, audience, platform, etc.) | [knox-conditional-notes.md](topics/recovery/knox-conditional-notes.md), DITA topics with profiling attributes |
| 5 | Modular Topic Referencing (Reusability) | ✅ Yes | ✅ Yes (`<conref>`, `<keyref>`, `<topicref>`) | [knox-shared-snippets.md](topics/recovery/knox-shared-snippets.md), DITA maps |
| 6 | Rich Inline Elements | ✅ Yes | ✅ Yes (`<note>`, `<codeph>`, `<uicontrol>`, `<b>`, `<i>`) | All topics (inline notes, code, UI formatting, bold/italic) |
| 7 | Inline Hyperlinks, GIFs, Images, Tables | ✅ Yes | ✅ Yes (`<xref>`, `<image>`, `<table>`) | All topics (Markdown links/images, DITA `<xref>`, `<image>`, `<table>`) |
| 8 | Integrated Walkthroughs/Multi-Panel Layouts | ⚠️ Not Yet | ⚠️ Possible with HTML5 output/customization | Not shown, but possible in Markdown with HTML5 `<details>`, tabs; DITA needs specialization or HTML5 output |
| 9 | Output Support for Mixed Formats | ✅ Yes | ✅ Yes (DITA-OT supports HTML5, PDF, JSON/XML with plugins) | Workspace setup (DITA-OT, Markdown+DITA XML) |

---
