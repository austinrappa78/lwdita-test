---
title: Estimate Storage with Retention Calculator
status: approved
owner: Austin Rappa
audience: Administrators
platform: Cloud
sources:
  - ticket:PEL-56
  - spec:feature-spec-retention-calculator.txt
  - email:org-settings-toggle
  - email:retention-calculator-updates
---

# Estimate Storage with Retention Calculator

The Retention Calculator panel in the admin dashboard enables administrators to calculate projected backup storage usage. You can access the widget under **Policies** > **Retention** > **Estimate Storage**.

## Retention Calculator Operations

The Retention Calculator supports five mathematical operations across both Standard and Enterprise editions:

The following table lists the available calculator operations and their behaviors.

| Operation | Symbol | Description |
|:--|:--|:--|
| Addition | `+` | Adds snapshot sizes together. |
| Subtraction | `-` | Subtracts snapshot sizes. |
| Multiplication | `x` | Scales a base snapshot size across multiple retained copies. |
| Division | `/` | Splits a shared storage budget across retention policies. |
| Exponentiation | `^` | Models compounding growth across retention cycles. |

When you select exponent mode (`^`), the field labels change from **Value A** and **Value B** to **Base** and **Exponent**.

## Input Rules and Special Behaviors

Consider the following validation rules and behaviors when performing calculations:

- **Decimal values**: Both input fields accept numbers up to 2 decimal places.
- **Maximum input value**: The maximum accepted value for either field is 20. If an input exceeds 20, the widget displays the inline message `Value exceeds maximum of 20` and does not calculate a result.
- **Divide by zero**: Dividing a number by zero displays the inline message `Cannot divide by zero` under the result field. The calculator retains the last valid calculation result on screen.
- **Zero exponents**: Entering zero as an exponent returns 1 (unless the base is zero).
- **Negative exponents**: Negative exponents return a fractional decimal result.
- **Base zero with negative exponent**: Entering base 0 with a negative exponent displays the inline message `Cannot compute: undefined result`.

> [!NOTE]
> The calculator does not chain multiple operations automatically. Perform multi-step calculations sequentially by using the result of one calculation as the input for the next.

## Example: Calculate Compounding Storage Growth

To estimate storage for a 50 GB base snapshot retained daily with 5% compounding growth over 12 cycles, perform the calculation in two steps:

1. Calculate the growth factor using exponent mode:
   1. Select the exponent mode (`^`) operator.
   2. Enter `1.05` in the **Base** field.
   3. Enter `12` in the **Exponent** field to calculate `1.05 ^ 12` (approximately `1.7959`).
2. Scale the base snapshot size using multiplication mode:
   1. Select the multiplication (`x`) operator.
   2. Enter `1.7959` in the first value field.
   3. Enter `50` in the second value field to get the total estimated storage of approximately `89.8` GB.

## Manage Calculator Availability

You can control whether the Retention Calculator panel appears in the admin dashboard.

1. Navigate to **Org Settings** > **Features**.
2. Locate the **Enable Retention Calculator** setting.
3. Toggle the setting off to hide the Retention Calculator panel from **Policies** > **Retention**.

> [!NOTE]
> By default, the Retention Calculator is enabled for all organizations. Turning off the primary toggle completely hides the calculator panel from the dashboard rather than disabling it.
