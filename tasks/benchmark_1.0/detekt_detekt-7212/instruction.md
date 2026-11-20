# Implement the issue(s) in detekt/detekt:

## Issue #7193 https://github.com/detekt/detekt/issues/7193: False Positive: TopLevelPropertyNaming applying to extension properties

<!-- The bug you're experiencing might have already be reported! -->
<!-- Please search in the [issues](https://github.com/detekt/detekt/issues) before creating one. -->

## Expected Behavior
I have code like this:
```kotlin
private val Foo.myProperty: String = "Hello"
```
and the `TopLevelPropertyNaming` rule is configured to enforce PascalCase for top level properties:
```yaml
  TopLevelPropertyNaming:
    active: true
    constantPattern: '(?:[A-Z][a-z0-9]+)(?:[A-Z]+[a-z0-9]*)*'
    propertyPattern: '(?:[A-Z][a-z0-9]+)(?:[A-Z]+[a-z0-9]*)*'
    privatePropertyPattern: '_?(?:[A-Z][a-z0-9]+)(?:[A-Z]+[a-z0-9]*)*'
```

I would expect `Foo.myProperty` to not be flagged, because this is an extension property on the `Foo` type, not an actual top level property.

## Observed Behavior
Detekt flags `Foo.myProperty` with the `TopLevelPropertyNaming` rule.

## Steps to Reproduce
Configure `TopLevelPropertyNaming` with the above options and test against an extension property.

## Context
We are trying to enforce PascalCase naming for top level properties on our project and many of these false positives are also being flagged.

## Your Environment
* Version of detekt used: 1.23.6
* Version of Gradle used (if applicable): 8.6

