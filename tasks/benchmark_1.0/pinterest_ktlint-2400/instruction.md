# Implement the issue(s) in pinterest/ktlint:

## Issue #2399 https://github.com/pinterest/ktlint/issues/2399: Annotation rule reports false postive to add newline which is present

Given code below:
```
val path: List<
    @Baz("baz")
    Any,
>? = null
```
then ktlint `0.49.x` or later reports a redundant error:
```
4:1: Expected newline (standard:annotation)
```

