# Implement the issue(s) in pinterest/ktlint:

## Issue #2188 https://github.com/pinterest/ktlint/issues/2188: Do not wrap a multiline spread operator expression `*`

See https://kotlinlang.org/spec/expressions.html#spread-operator-expressions for `*` operator.

Given code below:
```
fun foo(vararg items: String): Array<String> = arrayOf(*items)

fun bar(vararg items: String) = "bar"

val bar = bar(
    *foo(
        "a",
        "b"
    )
)
```
then it is formatted like:
```
fun foo(vararg items: String): Array<String> = arrayOf(*items)

fun bar(vararg items: String) = "bar"

val bar =
    bar(
        *
            foo(
                "a",
                "b",
            ),
    )
```
while it should have been kept unchanged. There is no sense in wrapping after the operator.
