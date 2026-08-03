---
title: Estimate storage with Retention Calculator
status: draft
owner: Austin Rappa
audience: admin
platform: cloud
sources:
  - ticket:PEL-56
  - spec:feature-spec-retention-calculator.txt
  - email:email-retention-calculator.txt
---

# Estimate storage with Retention Calculator

The Retention Calculator is an interactive utility panel in the admin dashboard located under **Policies** > **Retention** > **Estimate Storage**. You can use it to perform storage projections and mathematical calculations directly within the retention policy interface.

The Retention Calculator is available to all users on both Standard and Enterprise editions.

## Supported operations

The Retention Calculator supports five mathematical operations:

| Operation | Symbol | Description |
|:--|:--|:--|
| Add | + | Sum snapshot storage sizes. |
| Subtract | - | Calculate the difference between snapshot sizes. |
| Multiply | x | Scale a base snapshot size across multiple retained copies. |
| Divide | / | Divide a shared storage budget across retention policies. |
| Exponent | ^ | Model compounding storage growth across retention cycles. |

## Exponent mode

Selecting the exponent (`^`) operator puts the calculator in exponent mode. In exponent mode, the two input fields are relabeled **Base** and **Exponent**.

Exponent mode adheres to the following rules:

- **Decimals**: Base and exponent fields accept numeric input up to two decimal places.
- **Zero exponent**: Any base raised to the power of 0 returns 1.
- **Negative exponent**: A negative exponent returns a fractional decimal result.
- **Maximum value limit**: The maximum accepted value for either the base or exponent is 20. Entering a value greater than 20 displays the inline message `Value exceeds maximum of 20` and prevents computation.

## Input validation and error handling

The Retention Calculator validates inputs inline and handles edge cases without resetting previous calculation results.

The following table describes error conditions and the corresponding calculator behavior.

| Condition | Message | Calculator behavior |
|:--|:--|:--|
| Divide by zero | Cannot divide by zero | Displays the message under the result field and retains the last valid result. |
| Base 0 with negative exponent | Cannot compute: undefined result | Displays the message under the result field and does not calculate a result. |
| Input value over 20 in exponent mode | Value exceeds maximum of 20 | Displays the message under the result field and prevents calculation. |

## Estimate compounding growth

You can combine exponent and multiplication operations to calculate compounding storage growth over multiple retention cycles.

> [!NOTE]
> The Retention Calculator does not chain mathematical expressions automatically. Perform multi-step calculations sequentially, using the result of the first step as an input for the next step.

To estimate storage for a 50 GB base snapshot with a 5% compounding growth rate per cycle over 12 cycles:

1. Open the admin dashboard and navigate to **Policies** > **Retention** > **Estimate Storage**.
2. Select the exponent (`^`) operator to enter exponent mode.
3. Enter `1.05` in the **Base** field and `12` in the **Exponent** field to calculate the compounding growth factor (~1.7959).
4. Select the multiply (`x`) operator.
5. Multiply the growth factor (`1.7959`) by the base snapshot size (`50`) to calculate the total estimated storage (~89.8 GB).
