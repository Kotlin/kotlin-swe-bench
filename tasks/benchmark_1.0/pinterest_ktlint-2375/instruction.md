# Implement the issue(s) in pinterest/ktlint:

## Issue #2355 https://github.com/pinterest/ktlint/issues/2355: Format can causes compile error if function has multi line comments

## Expected Behavior

Input
```kotlin
fun zero():
        Float
// comment1
// comment2
{
    return 0.0f
}
```

Expected result
```kotlin
fun zero(): Float {
// comment1
// comment2
    return 0.0f
}
```
or other compilable code.

## Observed Behavior
Unfortunately we got non-compilable code.

```kotlin
fun zero(): Float
// comment1 { // comment2
        return 0.0f
    }

```

## Your Environment
<!--- Include as many relevant details about the environment you experienced the bug in -->
* Version of ktlint used: 1.0.1
* Relevant parts of the `.editorconfig` settings
* Name and version (or code for custom task) of integration used (Gradle plugin, Maven plugin, command line, custom Gradle task):Gradle
* Version of Gradle used (if applicable): 7.4.2
* Operating System and version: mac OS 14.0

