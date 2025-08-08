---
title: Advanced Knox Configuration
author: Austin Rappa
---

# Configure Multi-node Deployment

1. Setup the primary Knox node.
1. Configure secondary nodes:
    - Set static IP address for each node.
    - Verify cluster synchronization:
        - Run: `knox-cluster status`
        - Confirm output shows "All nodes synced"
1. Apply the configuration to all nodes.

## Windows-Specific Configuration

For Windows environments, additional configuration steps are required to ensure proper cluster communication and security:

1. Configure Windows Firewall exceptions:
   ```powershell
   New-NetFirewallRule -DisplayName "Knox Cluster" -Direction Inbound -Protocol TCP -LocalPort 9443,8080
   ```
2. Set up Windows Service dependencies:
   - Open **Services.msc**
   - Navigate to **Knox Recovery Service**
   - Set dependency on **Network Location Awareness**
3. Configure registry settings for cluster timeouts:
   ```
   HKEY_LOCAL_MACHINE\SOFTWARE\Veracity\Knox\ClusterTimeout = 30000
   ```
4. Restart the Knox service and verify cluster connectivity.

## Linux-Specific Configuration

Linux deployments require additional security hardening and system-level configurations:

1. Configure SELinux policies (if enabled):
   ```bash
   sudo setsebool -P knox_cluster_connect on
   sudo semanage port -a -t knox_port_t -p tcp 9443
   ```
2. Set up systemd service dependencies:
   ```bash
   sudo systemctl edit knox-recovery.service
   ```
   Add the following content:
   ```ini
   [Unit]
   After=network-online.target
   Wants=network-online.target
   ```
3. Configure kernel parameters for cluster performance:
   ```bash
   echo "net.core.rmem_max = 16777216" >> /etc/sysctl.conf
   echo "net.core.wmem_max = 16777216" >> /etc/sysctl.conf
   sudo sysctl -p
   ```
4. Verify iptables rules allow cluster communication:
   ```bash
   sudo iptables -A INPUT -p tcp --dport 9443 -j ACCEPT
   sudo iptables-save > /etc/iptables/rules.v4
   ```

See: [Knows UI Walkthrough](knox-ui-walkthrough.md "Walkthrough")