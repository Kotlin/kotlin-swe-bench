# Implement the issue(s) in pinterest/ktlint:

## Issue #2394 https://github.com/pinterest/ktlint/issues/2394: FunctionExpressionBodyRule should replace all expression bodies in a single run

Given code below, then multiple runs of ktlint are needed to replace all function bodies with body expressions:
```
fun foo1(): String {
    return "42"
}

fun foo2(): String {
    return "42"
}

fun foo3(): String {
    return "42"
}

fun foo4(): String {
    return "42"
}

fun foo5(): String {
    return "42"
}
```

Note that after first run of ktlint command, up to 3 function bodies are replaced, as ktlint will automatically run 3 times in case format violations have been fixed. Output after first run:
```
fun foo1(): String {
    return "42"
}

fun foo2(): String {
    return "42"
}

fun foo3(): String = "42"

fun foo4(): String = "42"

fun foo5(): String = "42"
```

Ktlint version: 1.0.1
