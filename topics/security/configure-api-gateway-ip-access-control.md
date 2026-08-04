---
title: Configure API Gateway IP access control
status: draft
owner: Austin Rappa
audience: admin
platform: cloud
sources:
  - spec:feature-spec-ip-access-control.txt
  - email:email-ip-access-control.txt
---

# Configure API Gateway IP access control

IP access control allows enterprise administrators to restrict access to the Veracity API Gateway based on source IP address or CIDR network range.

## How IP access control works

API access is controlled by two independent lists:

* **Allowlist**: When the allowlist contains at least one entry, only source IP addresses matching an entry on the allowlist can reach the API Gateway. Unlisted IP addresses receive an HTTP 403 Forbidden response. An empty allowlist allows all traffic by default.
* **Denylist**: IP addresses on the denylist are always blocked from reaching the API Gateway, regardless of whether the allowlist is active.

> [!IMPORTANT]
> The denylist always takes precedence over the allowlist. If an IP address is included on both lists, the request is rejected. You must remove the IP address from the denylist to restore access.

## Understand primary allowlist behavior

The organization-level primary allowlist operates independently from project-level allowlists:

* **Scope**: IP ranges added to the primary allowlist at the organization level are allowed access to every project within the organization.
* **Precedence**: Primary allowlist entries override project-specific allowlist and denylist restrictions.
* **Access permissions**: Only organization owners can configure the primary allowlist.

Use the primary allowlist for company-wide IP ranges, such as corporate office networks or continuous integration (CI) build servers.

## Configure IP access rules for a project

Follow these steps to configure allowlist or denylist rules for an individual project.

1. Log in to the Veracity Admin Dashboard.
2. Select your project.
3. Navigate to **Security** > **API Access**.
4. Select either the **Allowlist** tab or the **Denylist** tab.
5. Enter a valid IPv4 or IPv6 CIDR range.
6. Select **Add**.

## Configure the organization primary allowlist

Follow these steps to configure the organization-level primary allowlist.

1. Log in to the Veracity Admin Dashboard as an organization owner.
2. Navigate to **Org Settings** > **Security** > **Primary Allowlist**.
3. Enter the corporate CIDR range to allow across all projects.
4. Select **Add**.

## API Gateway access control options

The following table summarizes the behavior of IP access control configurations.

| Access control configuration | Gateway behavior |
|:--|:--|
| Empty allowlist and empty denylist | All source IP addresses are allowed access. |
| Allowlist contains entries | Only IP addresses matching the allowlist are permitted; all others receive HTTP 403. |
| IP address on denylist | Access is blocked even if the IP address is on the project allowlist. |
| IP address on primary allowlist | Access is permitted across all projects regardless of project rules. |
