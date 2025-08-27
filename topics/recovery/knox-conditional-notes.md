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

# Feature Behavior by Version

Knox Recovery provides different features and capabilities depending on your deployment type, user role, and platform. This topic outlines the key differences and considerations for each configuration to help you understand what functionality is available in your environment.

Use this information to plan your Knox Recovery implementation and ensure you're aware of any limitations or special requirements for your specific setup.

<p product="self-managed">
  Self-managed deployments require manual key rotation every 90 days.
</p>

<p product="saas">
  SaaS version handles key rotation automatically via the Knox Control Plane.
</p>

<p audience="admin" platform="linux">
  Advanced recovery scripts are available for Linux admins only.
</p>

<p audience="user" platform="windows">
  Some features may be unavailable on Windows desktop clients.
</p>

<p product="v7.3">
  Version 7.3 includes legacy backup encryption using AES-128. Manual certificate renewal required every 6 months.
</p>

<p product="v7.5">
  Version 7.5 introduces enhanced encryption with AES-256 and automatic certificate management through Knox Vault.
</p>

<p product="v7.3" audience="admin">
  Administrators using v7.3 must run the legacy health check utility monthly:
  <code>knox-healthcheck --legacy-mode</code>
</p>

<p product="v7.5" audience="admin">
  Administrators can now use the new unified dashboard for real-time monitoring and automated health checks.
</p>

<p product="v7.3" platform="linux">
  Linux deployments on v7.3 require manual log rotation configuration in <code>/etc/knox/logrotate.conf</code>.
</p>

<p product="v7.5" platform="linux">
  Linux deployments on v7.5 include automatic log management with configurable retention policies.
</p>

For optimal performance and security, ensure your Knox Recovery deployment matches the recommended configuration for your environment. Contact Veracity Support if you need assistance determining the best setup for your organization's requirements.

<p product="v7.3">
  **Version 7.3 End-of-Life Notice**: Support for Knox Recovery v7.3 will end December 2025. Plan your migration to v7.5 or later.
</p>

<p product="v7.5">
  **New in v7.5**: Enhanced disaster recovery capabilities with cross-region failover and zero-downtime updates.
</p>

Review the Knox Compatibility Matrix to verify that your current infrastructure meets the minimum requirements for your selected deployment model.

!!! info inline end "Important Deployment Note"

  Knox Recovery features and availability may vary based on your organization's deployment model, user roles, and platform. Review the documentation and compatibility matrix to ensure your environment is configured for optimal security and performance.
