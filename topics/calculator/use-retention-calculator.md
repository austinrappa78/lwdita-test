---
title: Use the retention calculator
status: draft
owner: Austin Rappa
audience: admin
platform: all
sources:
  - ticket:PEL-56
---

# Use the retention calculator

Use the Retention Calculator to estimate storage requirements and model compounding growth for backup retention policies.

## Configure calculator visibility

You can control whether the Retention Calculator is visible in the admin dashboard.

1. Navigate to **Org Settings** > **Features**.
2. Locate the **Enable Retention Calculator** setting.
3. Select the toggle to turn the calculator on or off.

> [!NOTE]
> The Retention Calculator is enabled by default. When turned off, the calculator panel is hidden from the retention policy page.

## Perform basic storage calculations

The Retention Calculator supports numeric inputs with up to two decimal places.

1. Navigate to **Policies** > **Retention** > **Estimate Storage**.
2. Enter the first numeric value into the input field.
3. Select an operator:
   - **+** for addition
   - **-** for subtraction
   - **x** for multiplication
   - **/** for division
4. Enter the second numeric value into the input field.
5. Review the calculated result.

> [!IMPORTANT]
> If you enter zero as a divisor during a division operation, the calculator displays the message `Cannot divide by zero` below the result field and retains the previous valid result.

## Perform exponent calculations

Use exponent mode to calculate compounding growth across retention cycles.

1. Navigate to **Policies** > **Retention** > **Estimate Storage**.
2. Select the exponent operator (**^**). The input fields are relabeled **Base** and **Exponent**.
3. Enter a numeric value in the **Base** field.
4. Enter a numeric value in the **Exponent** field.
5. Review the calculated result.

The following rules apply to exponent calculations:

- **Value limit**: The maximum value for either base or exponent is 20. Values above 20 display `Value exceeds maximum of 20` and do not compute.
- **Zero exponent**: Any non-zero base raised to the power of 0 returns 1.
- **Negative exponent**: A negative exponent produces a decimal fractional result.
- **Base zero with negative exponent**: Base 0 with a negative exponent displays `Cannot compute: undefined result`.

## Estimate compounding storage growth

To model multi-step compounding growth, perform sequential calculations by using the result of an exponent calculation in a subsequent multiplication step.

The following procedure demonstrates how to estimate storage for a 50 GB base snapshot growing by 5% per cycle over 12 cycles (`50 * (1.05 ^ 12)`).

1. Select the exponent operator (**^**).
2. Enter `1.05` in the **Base** field and `12` in the **Exponent** field to compute the growth multiplier (approximately `1.7959`).
3. Select the multiply operator (**x**).
4. Enter `1.7959` in the first value field and `50` in the second value field.
5. Review the final calculated storage estimate (approximately `89.8 GB`).
