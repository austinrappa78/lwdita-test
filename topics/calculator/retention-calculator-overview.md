---
title: Retention calculator overview
status: draft
owner: Austin Rappa
audience: admin
platform: all
sources:
  - ticket:PEL-56
---

# Retention calculator overview

The Retention Calculator is a utility panel in the admin dashboard that allows administrators to estimate storage requirements and model storage growth directly within the retention policy interface.

## Operations and capabilities

The Retention Calculator supports basic calculations as well as growth projections across retention cycles. All functionality is available in both Standard and Enterprise editions.

The following table lists the available calculator operations.

| Operation | Symbol | Description |
|:--|:--|:--|
| Addition | + | Adds snapshot sizes together. |
| Subtraction | - | Subtracts snapshot sizes. |
| Multiplication | x | Scales a base snapshot size across multiple retained copies. |
| Division | / | Splits a shared storage budget across retention policies. |
| Exponentiation | ^ | Models compounding growth across retention cycles. |

## Functionality details

Calculations occur client-side within the user interface. Complex estimations requiring multiple operations are performed sequentially, as automatic expression chaining is not supported.
