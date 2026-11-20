# Implement the issue(s) in pinterest/ktlint:

## Issue #2331 https://github.com/pinterest/ktlint/issues/2331: [standard:function-literal] Crash with reduntant lambda arrow

<!-- The bug you're experiencing might have already been reported!
Please search in the [issues](https://github.com/pinterest/ktlint/issues) before creating one. -->

## Expected Behavior
ktlint should not crash
<!---Tell us what should happen. -->
<!-- If relevant, provide a link to the relevant section in the [Kotlin Coding Conventions](https://kotlinlang.org/docs/coding-conventions.html) or [Android Kotlin Style Guide](https://developer.android.com/kotlin/style-guide).  -->

<!-- Note: Ktlint should not produce any code which conflict with IntelliJ default code formatting. So please verify that your expectation is accepted by IntelliJ default code formatting. -->

## Observed Behavior
ktlint crashes
<!---Tell us what happens instead of the expected behavior -->
<!--- Provide the exact command which was executed but please -->
<!--- ensure that the flag "--log-level=debug" is added to the -->
<!--- command as well. Provide the output of this command. -->

## Steps to Reproduce
```kotlin
fun foo(block: () -> Unit): Unit = foo { -> block() }
```
<!--- Provide a code example, or an unambiguous set of steps to -->
<!--- reproduce this bug. Minimize the example to the bare -->
<!--- minimum required to reproduce the bug. Small, well written -->
<!--- example are proven to be resolved quicker. -->

## Your Environment
<!--- Include as many relevant details about the environment you experienced the bug in -->
* Version of ktlint used: 1.0.1
* Relevant parts of the `.editorconfig` settings: none, although `function-literal` seems to be crashing even with `ktlint_code_style = intellij_idea`, whereas the documentation states the rule runs only with kotlin_official code style
* Name and version (or code for custom task) of integration used (Gradle plugin, Maven plugin, command line, custom Gradle task): [ktlint-gradle-plugin](https://github.com/usefulness/ktlint-gradle-plugin/)
* Version of Gradle used (if applicable): 8.3
* Operating System and version:

