---
title: What is the Retention Calculator?
status: draft
owner: Dana Okafor
audience: admin
platform: web
sources: [ticket:VERA-482, spec:feature-spec-retention-calculator, email:sarah.chen]
---

# What is the Retention Calculator?

The Retention Calculator is a utility panel in the admin dashboard (located at **Policies > Retention > Estimate Storage**). It allows you to perform quick calculations on storage numbers without leaving the retention policy screen. 

This tool is especially useful for modeling storage growth, such as calculating the final size of compounding snapshot schedules over multiple retention cycles. Both Standard and Enterprise editions have full access to all calculator operations.

## Primary Toggle

The calculator is enabled by default for all organizations. However, if your organization requires strict change-control processes, you can disable the tool entirely. 

An administrator can turn it off by navigating to **Org Settings > Features** and turning off the **Enable Retention Calculator** primary toggle. Doing so completely removes the calculator panel from the Policies > Retention screen.