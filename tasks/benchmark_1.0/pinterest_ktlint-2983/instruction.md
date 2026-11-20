# Implement the issue(s) in pinterest/ktlint:

## Issue #2955 https://github.com/pinterest/ktlint/issues/2955: Lint results in broken code for binary operation expression functions with an annotated expression

## Expected Behavior

Ktlint should not take compiling code and make it not compile. Here's the code that I'm linting:

```kotlin
fun foo() =
    @Suppress("DEPRECATION")
    false != true
```

Note that this does work for boolean operators like `&&` and `||` - but it seems the precedence rules for `!=`, `==`, `+`, etc., are different.

<!-- Note: Ktlint should not produce any code which conflict with IntelliJ default code formatting. So please verify that your expectation is accepted by IntelliJ default code formatting. -->

## Observed Behavior

Here's the output:

```kotlin
fun foo() =
    @Suppress("DEPRECATION")
    false
        != true
```

which does not compile.

## Steps to Reproduce
<!--- Provide a code example, or an unambiguous set of steps to -->
<!--- reproduce this bug. Minimize the example to the bare -->
<!--- minimum required to reproduce the bug. Small, well written -->
<!--- example are proven to be resolved quicker. -->

## Your Environment
* Version of ktlint used: 1.5.0
* Relevant parts of the `.editorconfig` settings

This is my whole editorconfig:

```
[*.kt]
ktlint_code_style = intellij_idea
ktlint_standard_trailing-comma-on-call-site = disabled
ktlint_standard_trailing-comma-on-declaration-site = disabled
ktlint_standard_function-signature = disabled
ktlint_standard_function-expression-body = disabled
ktlint_standard_class-signature = disabled
ktlint_standard_package-name = disabled
```
* Name and version (or code for custom task) of integration used (Gradle plugin, Maven plugin, command line, custom Gradle task): Spotless 6.25.0
* Version of Gradle used (if applicable): 8.13
* Operating System and version: Mac

