# Implement the issue(s) in detekt/detekt:

## Issue #4727 https://github.com/detekt/detekt/issues/4727: False-positive OutdatedDocumentation for generic parameters

<!-- The bug you're experiencing might have already be reported! -->
<!-- Please search in the [issues](https://github.com/detekt/detekt/issues) before creating one. -->

## Expected Behavior
<!-- Tell us what should happen -->
`@param T` supported for generic type documentation

## Observed Behavior
<!-- Tell us what happens instead of the expected behavior -->
`@param T` is reported as a false positive
`Documentation of JsonObject is outdated [OutdatedDocumentation]`

## Steps to Reproduce
<!-- Provide a link to a live example, or an unambiguous set of steps to -->
<!-- reproduce this bug. Include code to reproduce, if relevant -->
Run detekt with `OutdatedDocumentation` rule enabled on this code
```kotlin
/**
 * Some interesting description
 * @param T value type
 */
public abstract class Test<T : Any>
```

## Context
<!-- How has this issue affected you? What are you trying to accomplish? -->
<!-- Providing context helps us come up with a solution that is most useful in the real world -->

## Your Environment
<!-- Include as many relevant details about the environment you experienced the bug in -->
* Version of detekt used: 1.20.0
* Version of Gradle used (if applicable): 7.4
* Gradle scan link (add `--scan` option when running the gradle task):
* Operating System and version: Linux/Fedora 35
* Link to your project (if it's a public repository): https://github.com/mpetuska/npm-publish

