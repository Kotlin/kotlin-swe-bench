# Implement the issue(s) in pinterest/ktlint:

## Issue #2450 https://github.com/pinterest/ktlint/issues/2450: argument-list-wrapping should ignore comments at the end of the line

```Kotlin
// Assume that the last allowed character is at the X character on the right             X
val foo = Bar.builder().baz(0).build() // long comment at the end of the line regarding baz
```

## Expected Behavior
Rule should ignore the comment. This should rather be caught by `max-line-length`.

The comment might relate to something within the line and could be auto-formatted out of context.

## Current Behavior
```Kotlin
val foo = Bar.builder().baz(
    0,
).build() // long comment at the end of the line regarding baz
```

## Additional information
* Current version of ktlint: 1.1.0

