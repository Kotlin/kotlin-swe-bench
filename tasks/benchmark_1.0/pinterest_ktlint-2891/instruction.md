# Implement the issue(s) in pinterest/ktlint:

## Issue #2884 https://github.com/pinterest/ktlint/issues/2884: False positive for `standard:unnecessary-parentheses-before-trailing-lambda`

The rule `standard:unnecessary-parentheses-before-trailing-lambda` reports a false positive "Empty parentheses in function call followed by lambda are unnecessary" for the following code:

```kotlin
fun f(s1: () -> String): (() -> String) -> String = { s2 -> "${s1()} ${s2()}" }

fun main() {
    val s = f { "Hello" }() { "world" } // <--- HERE
    println(s)
}
```

The `f` function takes a lambda as parameter and returns a function which in turn will be invoked with a lambda parameter.
ktlint complains about the empty parentheses, however, the code doesn't compile without them (thus, `f { "hello" } { "world" }` is invalid: "Only one lambda expression is allowed outside a parenthesized argument list.")

Environment:
* reproducible with both gradle plugins ktlint-gradle 12.1.2 (having ktlint version set to 1.4.1) and detekt 1.23.7
* Gradle 8.10.2 
* Kotlin 2.0.21

