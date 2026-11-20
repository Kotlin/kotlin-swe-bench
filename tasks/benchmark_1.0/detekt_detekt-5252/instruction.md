# Implement the issue(s) in detekt/detekt:

## Issue #5251 https://github.com/detekt/detekt/issues/5251: [UnusedPrivateMember] false positive when using backticked identifiers

## Expected Behavior

No report. The parameter is used.

## Observed Behavior

```
Function parameter `x` is unused. [UnusedPrivateMember]
```

## Steps to Reproduce

```kotlin
// This function reports `x` unused.
fun borked(x: Int) = `x`

// This function does not. The only difference is the backticks.
fun fine(x: Int) = x
```

## Context
I came across this when I tried to name a parameter `as`, which must be backticked because otherwise it would be interpreted as the keyword. My workaround for now is to use a different name.

## Your Environment
* Version of detekt used: 1.21.0

