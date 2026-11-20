# Implement the issue(s) in pinterest/ktlint:

## Issue #2771 https://github.com/pinterest/ktlint/issues/2771: False positive Unnecessary semicolon (standard:no-semi)

The following gets flagged by the `no-semi` rule: 

```kotlin
enum class Test {
  ;

  val test = ordinal + 1
}
```

Also the `;` is removed when using the auto format option; however then it is a compile error since the `;` is required. So for enums that contain NO entries but variables or other statements the `;` is required.
