# Implement the issue(s) in pinterest/ktlint:

## Issue #2202 https://github.com/pinterest/ktlint/issues/2202: Insert whitespace between suspend and opening parenthesis 

I just noticed the following parameter:

```kotlin
onBytesSentTotal: suspend(Long) -> Unit
```

Would be nice if ktlint could insert a space between `suspend` & `(`.
