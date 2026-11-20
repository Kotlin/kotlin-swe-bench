# Implement the issue(s) in pinterest/ktlint:

## Issue #2615 https://github.com/pinterest/ktlint/issues/2615: Import incorrectly dropped when correcting string template expression with redundant braces

## Expected Behavior
Given 
```
import java.io.File.separator

val s = "${separator} is a file separator"
```

upon formatting it should be

```
import java.io.File.separator

val s = "$separator is a file separator"
```

## Observed Behavior
Instead, the import is deleted

```
val s = "$separator is a file separator"
```

## Your Environment
* Version of ktlint used: 1.2.1
* Relevant parts of the `.editorconfig` settings: `ktlint_code_style = intellij_idea`
* Name and version (or code for custom task) of integration used (Gradle plugin, Maven plugin, command line, custom Gradle task): repros with CLI ktlint as well as intelliJ plugin.

## Work Around
Manually re-add imports or fix redundant braces before formatting.

