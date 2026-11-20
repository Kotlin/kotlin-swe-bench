# Implement the issue(s) in pinterest/ktlint:

## Issue #2543 https://github.com/pinterest/ktlint/issues/2543: New Rule Proposal: square-bracket-spacing



Currently, with the standard ruleset:

```kotlin
class SomeClass() {
    operator fun set(
        a: Int,
        b: Int,
        c: Int,
    ) = Unit

    fun set(
        a: Double,
        b: Double,
    ) = Unit
}

fun someFunction() {
    SomeClass() [ 1, 2 ] = 3 // allowed
    SomeClass().set( 1.0, 2.0 ) // Unexpected spacing after "(" (standard:paren-spacing)
    SomeClass().set(1.0, 2.0) // allowed
}
```

## Expected Rule behavior

```kotlin
SomeClass() [ 1, 2 ] = 3
```

Becomes

```kotlin
SomeClass()[1,2] = 3
```

I propose `square-bracket-spacing` have the same behavior as `paren-spacing`, but with square brackets.



## Additional information
* Current version of ktlint: 1.1.1


