---
title: Advanced Knox Configuration
author: Austin Rappa
---

## Configure Multi-node Deployment


1. Setup the primary Knox node.
1. Configure secondary nodes:
	- Set static IP address for each node.
	- Verify cluster synchronization:
		- Run: `knox-cluster status`
        - Confirm output shows "All nodes synced"
1. Apply the configuration to all nodes.

> **Tip:** Ensure all nodes are on the same firmware version.

See: [Knows UI Walkthrough](knox-ui-walkthrough.md "Walkthrough")