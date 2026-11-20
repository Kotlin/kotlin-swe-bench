# Implement the issue(s) in pinterest/ktlint:

## Issue #2427 https://github.com/pinterest/ktlint/issues/2427: try-catch comment causing red code on format

## Expected Behavior
Unsure, but definitely still compiling.

## Observed Behavior
```kotlin
fun f() {
    try {
        something()
    } // Blah blah about exception handling. catch (e: IOException) {
        handle(e, 1)
    } catch (e: RuntimeException) {
        handle(e, 2)
    }
}
```

## Steps to Reproduce
`ktlint --format f.kt`

```kotlin
fun f() {
    try {
        something()
    } // Blah blah about exception handling.
    catch (e: IOException) {
        handle(e, 1)
    } catch (e: RuntimeException) {
        handle(e, 2)
    }
}
```

## Your Environment
<!--- Include as many relevant details about the environment you experienced the bug in -->
* Version of ktlint used: 1.0.1
* Relevant parts of the `.editorconfig` settings: none
* Name and version (or code for custom task) of integration used (Gradle plugin, Maven plugin, command line, custom Gradle task): ktlint CLI
* Version of Gradle used (if applicable): N/A
* Operating System and version: Windows 10

