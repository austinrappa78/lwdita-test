---
title: API Gateway IP access control
status: draft
owner: Austin Rappa
audience: admin
platform: cloud
sources:
  - spec:feature-spec-ip-access-control.txt
  - email:email-ip-access-control.txt
---

# API Gateway IP access control

IP access control allows you to restrict access to the API Gateway by source IP address using allowlists and denylists.

## Independent access lists

API access is controlled by two independent lists configured per project in the admin dashboard (**Admin Dashboard** > **Security** > **API Access**):

* **Allowlist**: Specifies the CIDR ranges allowed to reach the API Gateway. When the allowlist contains at least one entry, only requests originating from IPs on the allowlist are permitted. All other traffic is rejected with a 403 status code.
* **Denylist**: Specifies CIDR ranges that are explicitly blocked from reaching the API Gateway. Requests originating from IPs on the denylist are always rejected.

> [!IMPORTANT]
> The denylist always takes precedence over the allowlist. If an IP address appears on both the denylist and the allowlist, the API Gateway rejects traffic from that IP. To allow traffic from a blocked IP address, you must remove the IP address from the denylist.

## Empty allowlist behavior

An empty allowlist does not block traffic to the API Gateway. When a project's allowlist contains no entries, the API Gateway operates in default-allow mode. All incoming traffic is allowed through, except for requests originating from IP addresses specified on the denylist.

## Organization-level primary allowlist

In addition to project-level access controls, organization owners can maintain a primary allowlist at the organization level (**Org Settings** > **Security** > **Primary Allowlist**).

The primary allowlist is separate from an individual project's allowlist:

* An IP address on the organization-level primary allowlist is permitted to access every project's API Gateway within the organization.
* Primary allowlist entries bypass project-level allowlist and denylist configurations.
* Use the primary allowlist for organization-wide IP ranges, such as corporate office networks or continuous integration (CI) runners.
