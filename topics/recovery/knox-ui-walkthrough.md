---
title: Knox Recovery UI Walkthrough
---

## Knox Recovery UI Walkthrough

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