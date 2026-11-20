# Implement the issue(s) in pinterest/ktlint:

## Issue #2492 https://github.com/pinterest/ktlint/issues/2492: Resolve conflict between `binary-expression-wrapping` and `chain-wrapping`

Given code below:
```
// Assume that the last allowed character is
// at the X character on the right                  X
val foo1 =
    foo(
        """longgggggggggggggggggggggggggggggggggg""" +
            """foo""",
    )
val foo2 =
    """longgggggggggggggggggggggggggggggggggggggg""" +
        """foo"""
```
then ktlint `1.1.0` reports following violations:
```
src/main/kotlin/Foo.kt:5:9: Line is exceeding max line length. Break line before expression (standard:binary-expression-wrapping)
src/main/kotlin/Foo.kt:5:54: Exceeded max line length (53) (standard:max-line-length)
src/main/kotlin/Foo.kt:9:54: Exceeded max line length (53) (standard:max-line-length)
```
(Interestingly, no error is reported on line 9.)

Wrapping the `+` operator at line 5 is however not allowed by `chain-wrapping`:
```
src/main/kotlin/Foo.kt:6:13: Line must not begin with "+" (standard:chain-wrapping)
```

`binary-expression-wrapping` should not suggest to wrap the left hand side of the expression when it is the root of the expression and only let the expression be reported by the `max-line-length` rule.
