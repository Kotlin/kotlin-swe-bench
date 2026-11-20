# Implement the issue(s) in detekt/detekt:

## Issue #4242 https://github.com/detekt/detekt/issues/4242: UnusedPrivateMember false positive with operator `in`

## Expected Behavior

```kotlin
val isInside = "bar" in listOf("foo".toRegex())

private operator fun Iterable<Regex>.contains(a: String): Boolean {
    return any { it.matches(a) }
}
```

The extension function should not be flagged because it's used.

## Context
You can look at #4221. I found the issue there. In this commit: https://github.com/detekt/detekt/pull/4241/commits/59f97d9f92b74b22a3b94f8b4690235c8f616124

## Your Environment
* Version of detekt used: main - 1.19.0-RC1
