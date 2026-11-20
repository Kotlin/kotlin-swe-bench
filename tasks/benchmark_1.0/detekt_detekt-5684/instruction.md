# Implement the issue(s) in detekt/detekt:

## Issue #5631 https://github.com/detekt/detekt/issues/5631: UnnecessaryParentheses false positive when wrapping a unary operator and value

In this repro below, `-2.foo` triggers an IDE warning to use `(-2).foo` saying `Wrap unary operator and value with () `.

This is because the `foo` property takes precedence over the `unaryMinus` which is much less clear when using a primitive. The IDE wants you to be explicit and either use `(-2).foo` or `-(2.foo)`.

However, detekt flags it is an `UnnecessaryParentheses` violation.

```
class Foo(val value: Int) {
  operator fun unaryMinus() = Foo(value * -value)
}

val Int.foo: Foo get() = Foo(value = this)

val a = -2.foo
val b = (-2).foo
val c = -(2.foo)
```


---

## Issue #9 https://github.com/detekt/detekt/issues/9: Get rid of hamKrest for 1.1.1


