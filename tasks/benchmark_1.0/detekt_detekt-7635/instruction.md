# Implement the issue(s) in detekt/detekt:

## Issue #7634 https://github.com/detekt/detekt/issues/7634: Regression: 1.23.7 - `UndocumentedPublicClass` flags unnamed public companion object

## Expected Behavior
`UndocumentedPublicClass` is _configurable_ to flag unnamed `companion object`. 

## Observed Behavior
`UndocumentedPublicClass` flags `companion object` newly in 1.23.7

## Steps to Reproduce
```kotlin
/** Some doc **/
public class Foo {
  public companion object // Flagged
}
```

## Context

In #7219, this behaviour was enabled. The rule is written/described such that this is expected. However, this was a breaking change as it caused significant amount of violations within our code base. 

## Your Environment
* Version of detekt used: 1.23.7
* Version of Gradle used (if applicable): 8.10
* Operating System and version: macos

