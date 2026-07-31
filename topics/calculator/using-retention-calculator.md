---
title: Using the Retention Calculator
status: draft
owner: Dana Okafor
audience: admin
platform: web
sources: [ticket:VERA-482, spec:Retention-Calculator-Feature-Spec-v1.2.docx]
---

# Using the Retention Calculator

The Retention Calculator provides five operations to model storage size changes:

- **+ (Add)**
- **- (Subtract)**
- **x (Multiply)**
- **/ (Divide)**
- **^ (Exponent)**

All numeric input fields (Base, Exponent, Value A, Value B) accept decimal values up to 2 decimal places.

## Exponent Operation

The exponent operator acts as a mode toggle. When active, the input fields are labeled **Base** and **Exponent**.

- **Zero Exponents:** Zero is a valid exponent and always returns `1`, except when the base is `0`.
- **Negative Exponents:** Negative exponents are valid and produce a fractional (decimal) result (e.g., base 2, exponent -1 returns 0.5).
- **Errors:** A base of `0` with a negative exponent produces an error, displaying the message `Cannot compute: undefined result`.
- **Maximum Value:** The maximum accepted value for either the base or the exponent is `20`. If you enter a value larger than 20, the tool displays `Value exceeds maximum of 20` and will not compute a result.

## Division

When using the divide operator, dividing by zero displays an inline error message: `Cannot divide by zero`. The calculator does not crash or reset; it leaves your previously valid result visible until you perform a new, valid calculation.

## Worked Example

To estimate the size of a 50 GB base snapshot after 12 compounding growth cycles at a 5% growth rate per cycle, you would compute `50 * (1.05 ^ 12)`:

1. Enable the exponent mode (`^`).
2. Enter `1.05` as the Base and `12` as the Exponent. The result is approximately `1.7959`.
3. Switch to the multiply mode (`x`).
4. Multiply the previous result by `50` to get approximately `89.8` GB.

*Note: The calculator does not chain operations automatically. You must run the exponent step and multiply step separately, using the result of one as an input to the next.*