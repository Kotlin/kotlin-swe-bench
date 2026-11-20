# Implement the issue(s) in pinterest/ktlint:

## Issue #2269 https://github.com/pinterest/ktlint/issues/2269: Compilation error due to `function-expression-body`

Given code below:
```
fun foo(): Any {
    return if (true) {
        Foo()
    } else {
        return Bar()
    }
}
```

this is formatted by Ktlint 1.0.0 (with experimental enabled) to:
```
fun foo(): Any =
    if (true) {
        Foo()
    } else {
        return Bar()
    }
```

and results in a compilation error as a body expression may not contain a return statement
