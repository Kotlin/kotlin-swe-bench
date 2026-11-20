# Implement the issue(s) in detekt/detekt:

## Issue: UnnecessaryAbstractClass false positive

## Expected Behavior
Don't report following code:
```
abstract class Fake : Base() // UnnecessaryAbstractClass
abstract class Base {
	open val order: Int get() = 0
	abstract fun String.foo()
}
```

## Observed Behavior

> "An abstract class without a concrete member can be refactored to an interface."

No, it can't:
 * `Fake` interface couldn't extend a class.
 * it has concrete members inherited from `Base`
 * I get a detection even if I add an actual class using the "abstractness":
```kotlin
class Foo : Fake() {
	override fun String.foo() = TODO("not implemented")
}
```
Note: `String.` might be a red herring, you can ignore that part, just wanted to report what I had. More minimal repro might exist.

## Steps to Reproduce


Just copy above code into a test or code checked by Detekt 1.20.0.

## Context
Real context is creating fakes for a test:
image is available at /task-assets/instruction/1cdb43db1d5d83bf.png.

The abstract method is never invoked in the test, so there's no need to implement it, hence using `abstract class`. The class must be unique because it's `::class` object is used.

## Your Environment
<!-- Include as many relevant details about the environment you experienced the bug in -->
* Version of detekt used: 1.20.0
* Version of Gradle used (if applicable): N/A
* Gradle scan link (add `--scan` option when running the gradle task): N/A
* Operating System and version: all
