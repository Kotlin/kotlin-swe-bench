# Implement the issue(s) in pinterest/ktlint:

## Issue #2425 https://github.com/pinterest/ktlint/issues/2425: Allow empty constructur call in expected class declaration

Using 1.0.1 the following gets flagged:

```kotlin
@OptIn(ExperimentalMultiplatform::class)
@OptionalExpectation
@Target(AnnotationTarget.CLASS)
@Retention(AnnotationRetention.BINARY)
expect annotation class Parcelize()

@OptIn(ExperimentalMultiplatform::class)
@OptionalExpectation
@Target(AnnotationTarget.PROPERTY)
@Retention(AnnotationRetention.SOURCE)
expect annotation class IgnoredOnParcel()

@OptIn(ExperimentalMultiplatform::class)
@OptionalExpectation
@Retention(AnnotationRetention.SOURCE)
@Repeatable
@Target(AnnotationTarget.CLASS, AnnotationTarget.PROPERTY)
expect annotation class TypeParceler<T, P : Parceler<in T>>()
```

with:

```
commonParcelableApi.kt:11:34: No parenthesis expected (standard:class-signature)
commonParcelableApi.kt:17:40: No parenthesis expected (standard:class-signature)
commonParcelableApi.kt:24:60: No parenthesis expected (standard:class-signature)
```

And the formatting removes the `()` however this causes a compilation error: `e: Color.kt:35:2 This class does not have a constructor`

You can use https://github.com/vanniktech/ui/pull/100 to repro

