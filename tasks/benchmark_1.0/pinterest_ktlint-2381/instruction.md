# Implement the issue(s) in pinterest/ktlint:

## Issue #2360 https://github.com/pinterest/ktlint/issues/2360: Formatting does not work well in classes with generics and explicit constructor

## Expected Behavior
I have some classes with generics for which I need to explicitly declare the `constructor`, either to document it, annotate it or add a visibility modifier to it. I expect to find a way to format these without getting ktlint errors.

## Observed Behavior
I am getting errors from the `type-parameter-list-spacing` and `discouraged-comment-location` rules.

## Steps to Reproduce
A few code examples:

```kotlin
class ClassWithGenericsAndAVeryLongName<FirstGeneric : FirstGenericType, SecondGeneric : SecondGenericType>
internal constructor(param: SomeType)
// throws `type-parameter-list-spacing`
```

```kotlin
class ClassWithGenericsAndAVeryLongName<
    FirstGeneric : FirstGenericType,
    SecondGeneric : SecondGenericType
    >
@RestrictTo(RestrictTo.Scope.LIBRARY_GROUP)
constructor(param: SomeType)
// throws `type-parameter-list-spacing`
```

```kotlin
/**
 * Documentation for ClassWithGenericsAndAVeryLongName.
 */
class ClassWithGenericsAndAVeryLongName<
    FirstGeneric : FirstGenericType,
    SecondGeneric : SecondGenericType
    >
/**
 * Constructor to initialize ClassWithGenericsAndAVeryLongName. Should only show if you use this constructor.
 * There's another constructor inside the class.
 */
constructor(param: SomeType)
// throws `type-parameter-list-spacing` and `discouraged-comment-location`.
```

## Your Environment
* Version of ktlint used: 1.0.1
* Relevant parts of the `.editorconfig` settings: `ktlint_code_style = android_studio`
* Name and version (or code for custom task) of integration used (Gradle plugin, Maven plugin, command line, custom Gradle task): Gradle with Android studio, for an Android library.
* Version of Gradle used (if applicable): 8.4
* Operating System and version: MacOS Sonoma.

