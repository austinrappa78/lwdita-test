---
author:
  - Ausitn Rappa
source: Markdown
publisher: Publisher
permissions: Permissions
audience: Users
category: Category
keyword:
  - Keyword1
  - Keyword2
resourceid:
  - Resourceid1
  - Resourceid2
workflow: review
---

# Knox Recovery UI Walkthrough

This comprehensive walkthrough guides you through the Knox Recovery user interface, from initial installation to ongoing monitoring. Follow these collapsible sections to complete your Knox Recovery setup and familiarize yourself with key administrative tasks.

The Knox Recovery interface provides intuitive access to backup management, system monitoring, and configuration options. Each section below contains detailed steps and configuration parameters to ensure a successful deployment.

This works everywhere, but
<span data-props="cloud">this applies to Cloud only</span>.

<div data-props="onprem">
  This block applies to On-prem only.
</div>


<div data-props="platform=onprem">
   Follow these steps to configure logging on your appliance…
</div>


![Homer](../../images/homer.gif)

<details>
<summary>Step 1: Download and Install</summary>

1. Download the Knox installer from [Veracity Downloads](https://downloads.veracity.io/knox).
2. Run the installer:
   ```bash
   sudo ./install-knox.sh
   ```
</details>

<details>
<summary>Step 2: Configure Settings</summary>

| Field          | Description                     | Default Value |
| -------------- | ------------------------------- | ------------- |
| Port           | Port Knox listens on            | 9443          |
| Data Directory | Location for backup metadata    | /var/knox     |
| Enable Logs    | Whether to enable debug logging | true          |

</details>

<details>
<summary>Step 3: Validate and Monitor</summary>

- Access the Knox dashboard at [https://knox.veracity.io](https://knox.veracity.io).
- Check job status, logs, and alerts.
- Export logs for troubleshooting.

</details>

<!-- For tabs, you can use HTML or a Markdown extension if your output supports it. -->