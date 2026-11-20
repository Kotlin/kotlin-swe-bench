# Implement the issue(s) in detekt/detekt:

## Issue #7448 https://github.com/detekt/detekt/issues/7448: ThrowingExceptionsWithoutMessageOrCause false positive

<!-- The bug you're experiencing might have already be reported! -->
<!-- Please search in the [issues](https://github.com/detekt/detekt/issues) before creating one. -->

## Expected Behavior
```kotlin
loader.errors().firstOrNull()?.exception()?.let { throw it }
```
The following code should work fine and don't violate ThrowingExceptionsWithoutMessageOrCause since we already have a message for an exception

## Observed Behavior
<!-- Tell us what happens instead of the expected behavior -->
```kotlin
loader.errors().firstOrNull()?.exception()?.let { throw it }
```
Throws ThrowingExceptionsWithoutMessageOrCause
Even the following code violates the rule
```kotlin
loader.errors().firstOrNull()?.exception()?.let { throw DataAccessException(it.message, it.cause) }
```
For some reason it reacts on method invocation `.exception()`

## Steps to Reproduce
<!-- Provide a link to a live example, or an unambiguous set of steps to -->
<!-- reproduce this bug. Include code to reproduce, if relevant -->

## Context
<!-- How has this issue affected you? What are you trying to accomplish? -->
<!-- Providing context helps us come up with a solution that is most useful in the real world -->
I'm using jooq Loader API
https://www.jooq.org/doc/latest/manual/sql-execution/importing/importing-api/

## Your Environment
<!-- Include as many relevant details about the environment you experienced the bug in -->
* Version of detekt used: 1.23.6
* Version of Gradle used (if applicable): 8.6
* Gradle scan link (add `--scan` option when running the gradle task):
* Operating System and version: MacOS
* Link to your project (if it's a public repository):

