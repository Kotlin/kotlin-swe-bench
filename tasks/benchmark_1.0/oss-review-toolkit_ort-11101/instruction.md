# Implement the issue(s) in oss-review-toolkit/ort:

## Issue #10888 https://github.com/oss-review-toolkit/ort/issues/10888: Problems with commutative OR in SPDX expressions

### Describe the bug
* Scan result contains both "MIT OR Apache-2.0" and "Apache-2.0 OR MIT"
* I have the following license choice:
   ```
   - given: "Apache-2.0 OR MIT"
   - choice: "MIT"
   ```
* Sometimes it works, sometimes the "effectiveLicense" explodes, i.e. I get a very long SPDX-OR-expression

### Analysis
The problem is quite obvious in the code. `SpdxCompoundExpression` have a special equality operator (and hash function) that is order invariant. Therefore, expressions `A OR B` and `B OR A` are treated as equal. Therefore, the order does not matter - for the majority of the code, at least.

The effective license is constructed as set over all found license expressions. In my case, both `Apache-2.0 OR MIT` and `MIT OR Apache-2.0` are found, but only one of them makes it into the set. It is probably undefined behaviour which one, or at least should be treated as such, because it is not very reliable.

So far, this looks fine. However, the **license choices** use string search/replace (see https://github.com/oss-review-toolkit/ort/blob/68.0.0/utils/spdx/src/main/kotlin/SpdxExpression.kt#L351). Here, it very much makes a difference.

In my case, `MIT OR Apache-2.0` made it into the effective license. The expression `Apache-2.0 OR MIT` from the license choice is a valid subexpression, but does not occur in the stringified expression.

As a consequence, the second path is chosen, which essentially rebuilds the effective license as a (very big) OR-expression, connecting all `validChoices()`. In my case, there are more than one license choices, so the effective license grows exponentially.
