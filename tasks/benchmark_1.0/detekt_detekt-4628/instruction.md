# Implement the issue(s) in detekt/detekt:

## Issue #4626 https://github.com/detekt/detekt/issues/4626: UnnecessaryAbstractClass does not consider unimplemented base properties

## Expected Behavior
`UnnecessaryAbstractClass` should not warn for classes that don't implement the full interface of their base types. 

## Observed Behavior
The following code should not give an `UnnecessaryAbstractClass` warning for `Test`.

```
abstract class Test( val par: Int ) : BaseAbstract

interface BaseAbstract
{
    fun test(): Int
}
```

It gives this warning for the `Test` class.

> An abstract class without an abstract member can be refactored to a concrete class. [UnnecessaryAbstractClass]

## Context
<!-- How has this issue affected you? What are you trying to accomplish? -->
<!-- Providing context helps us come up with a solution that is most useful in the real world -->

## Your Environment
<!-- Include as many relevant details about the environment you experienced the bug in -->
* Version of detekt used: 1.20.0-RC1

