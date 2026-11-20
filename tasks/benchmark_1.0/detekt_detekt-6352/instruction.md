# Implement the issue(s) in detekt/detekt:

## Issue #6349 https://github.com/detekt/detekt/issues/6349: False negative for `NullableToStringCall` rule in lambdas

<!-- The bug you're experiencing might have already be reported! -->
<!-- Please search in the [issues](https://github.com/detekt/detekt/issues) before creating one. -->

## Expected Behavior
<!-- Tell us what should happen -->
The `NullableToStringCall` rule should work the same inside lambda expressions (e.g. `let`) as it does everywhere else:
```kotlin
fun detected(): String {
    val x: String? = null
    return "hi $x"
}
```

Other rules like `ForbiddenMethodCall` also find noncompliant calls inside lambda expressions:
```kotlin
fun forbiddenDetected(): String = 1.let {
    "hi ${println("foo")}"
}
```

## Observed Behavior
<!-- Tell us what happens instead of the expected behavior -->
Nullable variables in a string inside a lambda expressions are not detected by the rule.

## Steps to Reproduce
<!-- Provide a link to a live example, or an unambiguous set of steps to -->
<!-- reproduce this bug. Include code to reproduce, if relevant -->
Call the `toString()` function (implicit or explicit) of a nullable value inside a lambda. Neither values defined inside nor outside the lambda trigger the rule.
```kotlin
fun undetected1(): String = 1.let {
    val x: String? = null
    "hi $x"
}

fun undetected2(): String = 1.let {
    val x: Any? = null
    "hi ${x.toString()}"
}

fun undetected3(): String {
    val x: String? = null
    return 1.let {
        "hi $x"
    }
}

fun undetected4(): String {
    val x: String? = null
    return x.let { y ->
        "hi $y"
    }
}
```

## Context
<!-- How has this issue affected you? What are you trying to accomplish? -->
<!-- Providing context helps us come up with a solution that is most useful in the real world -->
I was wondering why my custom rule that detects some forbidden calls inside string templates missed a noncompliant string in a lambda expression, and checked how the `NullableToStringCall` implementation handled it. As we were doing roughly the same things, I tested if the `NullableToStringCall` rule actually worked with lambda expressions.

## Your Environment
<!-- Include as many relevant details about the environment you experienced the bug in -->
* Version of detekt used: 1.23.1
* Version of Gradle used (if applicable): 8.2.1
* Gradle scan link (add `--scan` option when running the gradle task): N/A
* Operating System and version: multiple (MacOS, Alpine Linux)
* Link to your project (if it's a public repository): N/A



---

## Issue #6378 https://github.com/detekt/detekt/issues/6378: False negative for NullableToStringCall rule in other class function calls.

## Expected Behavior
The NullableToStringCall rule should work the same when calling a function from another class.
```kotlin
class TestDetekt(val subClass: SubClass) {
    fun testDetekt(test: Int?) {
        test.toString() // detected
        test2(test.toString()) // detected
        subClass.test3(test.toString()) // not detected
    }

    private fun test2(value: String?) {}
}

class SubClass {
    fun test3(value: String?) {}
}
```

## Observed Behavior
The line `subClass.test3(test.toString())` is not flagged.

## Steps to Reproduce
You can use the code above to reproduce this issue.

## Context
We ended up having the string "null" instead of the null value.

## Your Environment
* Version of detekt used: 1.23.1
* Using detekt through detekt-maven-plugin version 1.23.1

