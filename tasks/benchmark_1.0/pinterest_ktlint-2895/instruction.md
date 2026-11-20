# Implement the issue(s) in pinterest/ktlint:

## Issue #2877 https://github.com/pinterest/ktlint/issues/2877: Backing property in a companion object triggers a backing-property-naming violation

Thank you so much for maintaining this library and for your attention to this issue.

Is this a bug, or is it intended behavior? If intended, I can open a feature request, because I don't think this should be a violation.

<!-- The bug you're experiencing might have already been reported!
Please search in the [issues](https://github.com/pinterest/ktlint/issues) before creating one. -->

## Expected Behavior
<!---Tell us what should happen. -->
<!-- If relevant, provide a link to the relevant section in the [Kotlin Coding Conventions](https://kotlinlang.org/docs/coding-conventions.html) or [Android Kotlin Style Guide](https://developer.android.com/kotlin/style-guide).  -->

<!-- Note: Ktlint should not produce any code which conflict with IntelliJ default code formatting. So please verify that your expectation is accepted by IntelliJ default code formatting. -->

no ktlint violations

## Observed Behavior
<!---Tell us what happens instead of the expected behavior -->
<!--- Provide the exact command which was executed but please -->
<!--- ensure that the flag "--log-level=debug" is added to the -->
<!--- command as well. Provide the output of this command. -->

```
Lint error > [standard:backing-property-naming] Backing property is only allowed when a matching property or function exists
```

## Steps to Reproduce
<!--- Provide a code example, or an unambiguous set of steps to -->
<!--- reproduce this bug. Minimize the example to the bare -->
<!--- minimum required to reproduce the bug. Small, well written -->
<!--- example are proven to be resolved quicker. -->

```kotlin
    companion object {
        private var _isEnabled = false
    }

    val isEnabled: Boolean
        get() = _isEnabled
```

## Your Environment
<!--- Include as many relevant details about the environment you experienced the bug in -->
* Version of ktlint used: 1.4.1
* Relevant parts of the `.editorconfig` settings: N/A
* Name and version (or code for custom task) of integration used (Gradle plugin, Maven plugin, command line, custom Gradle task): https://github.com/jeremymailen/kotlinter-gradle 4.5.0
* Version of Gradle used (if applicable): 8.11.1
* Operating System and version: macOS 14.7.1

