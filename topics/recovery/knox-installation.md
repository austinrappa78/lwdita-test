---
title: Installing Knox Recovery
---

## Steps to Install

1. Download the latest Knox installer from [Veracity Downloads](https://downloads.veracity.io/knox).
2. Run the installer using the following command:
   ```bash
   sudo ./install-knox.sh

3. Review the following settings before proceeding:

| Field          | Description                     | Default Value |
| -------------- | ------------------------------- | ------------- |
| Port           | Port Knox listens on            | 9443          |
| Data Directory | Location for backup metadata    | /var/knox     |
| Enable Logs    | Whether to enable debug logging | true          |