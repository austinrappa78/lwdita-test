---
title: Advanced Knox Configuration
---

## Configure Multi-node Deployment

1. Setup the primary Knox node.
2. Configure secondary nodes:
    - Set static IP address for each node.
    - Verify cluster synchronization:
        - Run: `knox-cluster status`
        - Confirm output shows "All nodes synced"
3. Apply the configuration to all nodes.

> **Tip:** Ensure all nodes are on the same firmware version.
