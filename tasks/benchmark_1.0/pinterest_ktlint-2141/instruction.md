# Implement the issue(s) in pinterest/ktlint:

## Issue #2140 https://github.com/pinterest/ktlint/issues/2140: Mutable collection property name should not be SCREAMING_SNAKE_CASE

<!-- The bug you're experiencing might have already been reported!
Please search in the [issues](https://github.com/pinterest/ktlint/issues) before creating one. -->

## Expected Behavior
Mutable collection property name should not be SCREAMING_SNAKE_CASE - https://developer.android.com/kotlin/style-guide#non-constant_names
```kotlint
object : DumObjectName {
    val someMap: MutableMap<SomeKey, SomeValue> = ...
}
```

## Observed Behavior
ktlint require SCREAMING_SNAKE_CASE:
```kotlint
object : DumObjectName {
    val SOME_MAP: MutableMap<SomeKey, SomeValue> = ...
}
```

## Steps to Reproduce
Create object, with mutable collection property. 

## Your Environment
<!--- Include as many relevant details about the environment you experienced the bug in -->
* Version of ktlint used: 0.50.0

