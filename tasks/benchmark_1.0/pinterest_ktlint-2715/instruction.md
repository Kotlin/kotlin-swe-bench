# Implement the issue(s) in pinterest/ktlint:

## Issue #2688 https://github.com/pinterest/ktlint/issues/2688: [1.3.0] Running `-format` adds extra spaces to class & function definition

<!-- The bug you're experiencing might have already been reported!
Please search in the [issues](https://github.com/pinterest/ktlint/issues) before creating one. -->

## Expected Behavior
<!---Tell us what should happen. -->
<!-- If relevant, provide a link to the relevant section in the [Kotlin Coding Conventions](https://kotlinlang.org/docs/coding-conventions.html) or [Android Kotlin Style Guide](https://developer.android.com/kotlin/style-guide).  -->
Running `format` with autoCorrect produces valid codestyle 

<!-- Note: Ktlint should not produce any code which conflict with IntelliJ default code formatting. So please verify that your expectation is accepted by IntelliJ default code formatting. -->

## Observed Behavior
<!---Tell us what happens instead of the expected behavior -->
<!--- Provide the exact command which was executed but please -->
<!--- ensure that the flag "--log-level=debug" is added to the -->
<!--- command as well. Provide the output of this command. -->
Running `check` after successful `format` fails

## Steps to Reproduce
<!--- Provide a code example, or an unambiguous set of steps to -->
<!--- reproduce this bug. Minimize the example to the bare -->
<!--- minimum required to reproduce the bug. Small, well written -->
<!--- example are proven to be resolved quicker. -->
Given the following snippet:
```kotlin
class KotlinClass{

    private fun hi(){
        println("OK")
    }
}

```
runing `ktlint -F` produces:
```kotlin
class KotlinClass  {

    private fun hi()  {
        println("OK")
    }
}

```
 (notice the double spaces before `{`)

which then fails on regular ktlint run with
```
.../test/KotlinClass.kt:1:19: Unnecessary long whitespace (standard:no-multi-spaces)
.../test/KotlinClass.kt:1:20: Expected a single space before class body (standard:class-signature)
.../test/KotlinClass.kt:3:22: Unnecessary long whitespace (standard:no-multi-spaces)
.../test/KotlinClass.kt:3:23: Expected a single white space before start of function body (standard:function-start-of-body-spacing)
.../test/KotlinClass.kt:3:23: Expected a single space before body block (standard:function-signature)
22:35:13.777 [main] WARN com.pinterest.ktlint.cli.internal.KtlintCommandLine -- Lint has found errors than can be autocorrected using 'ktlint --format'

Summary error count (descending) by rule:
  standard:no-multi-spaces: 2
  standard:class-signature: 1
  standard:function-signature: 1
  standard:function-start-of-body-spacing: 1
  ```

## Your Environment
<!--- Include as many relevant details about the environment you experienced the bug in -->
* Version of ktlint used: 1.3.0
* Relevant parts of the `.editorconfig` settings
```editorconfig
root = true

[*]
insert_final_newline = true

[*.{kt,kts}]
max_line_length = 140
indent_size = 4
ij_kotlin_allow_trailing_comma = true
ij_kotlin_allow_trailing_comma_on_call_site = true
ktlint_code_style = intellij_idea
```
* Name and version (or code for custom task) of integration used (Gradle plugin, Maven plugin, command line, custom Gradle task): https://github.com/usefulness/ktlint-gradle-plugin/pull/227
* Version of Gradle used (if applicable): 8.8
* Operating System and version: ubuntu-latest, windows-latest

