# Implement the issue(s) in detekt/detekt:

## Issue #4735 https://github.com/detekt/detekt/issues/4735: False positive on `UnnecessaryInnerClass`

## Expected Behavior
If an `inner class` uses a lambda that is on its parent `UnnecessaryInnerClass` should not be raise any issue.

## Observed Behavior
`UnnecessaryInnerClass` right now raises an issue.

## Steps to Reproduce
```kotlin
@Test
fun `to call a lambda of the member`() {
    val code = """
        class A {
            val foo: () -> Unit = {}
            
            inner class B {
                fun printFizz() {
                    foo()
                }
            }
        }
    """.trimIndent()

    assertThat(subject.lintWithContext(env, code)).isEmpty()
}
```

## Context
It is normal to see this kind of patterns in Android adapters. The ViewHolders are `inner class`es inside the `Adapter` that have some `callback`s that are lambdas.

## Your Environment
* Version of detekt used:1.20.0

