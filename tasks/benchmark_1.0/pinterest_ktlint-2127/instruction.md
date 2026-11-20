# Implement the issue(s) in pinterest/ktlint:

## Issue #920 https://github.com/pinterest/ktlint/issues/920: ")" unexpectedly indented in expression but not in `if`

Given ktlint 0.39.0 and some code that looks like this:

```
val pass = if (condition1) {                 
        (
            condition2
        )
    } else {
        condition3
    }
```

## Expected Behavior:
this code seems to be formatted reasonably to us; we think ktlint should report no problems.

## Observed Behavior:
Instead we're observing it to request indenting "condition2" and ")" to get this:

```
val pass = if (condition1) {                 
        (
                condition2
            )
    } else {
        condition3
    }
```

At first I thought this seemed reasonable to me because it was presumably being treated as a line continuation, but then I checked what would happen if condition1 were multiple lines, and found in that case that ktlint requested that the parentheses of the `if` statement should be lined up:

```
if (
    condition1
) { // indendation matching the corresponding "("
    (
            condition2
        ) // indentation not matching the corresponding "("
} else {
    condition3
}
```

## Your Environment
We encounter this when upgrading from ktlint 0.36.0 to 0.39.0

The full code in question: https://android-review.googlesource.com/c/platform/frameworks/support/+/1432017/2/compose/animation/animation-core/src/test/java/androidx/compose/animation/core/SpringEstimationTest.kt#139
