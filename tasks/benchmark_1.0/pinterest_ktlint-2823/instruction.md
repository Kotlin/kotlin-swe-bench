# Implement the issue(s) in pinterest/ktlint:

## Issue #2816 https://github.com/pinterest/ktlint/issues/2816: Wrong indentation for lambdas with many parameters

The parameter list of a multiline lambda does not have the correct indentation. The corresponding unit test seems to do it wrong on purpose: https://github.com/pinterest/ktlint/blob/master/ktlint-ruleset-standard/src/test/kotlin/com/pinterest/ktlint/ruleset/standard/rules/IndentationRuleTest.kt#L2607

## Expected Behavior
Consider the last code block from [https://kotlinlang.org/docs/coding-conventions.html#lambdas](https://kotlinlang.org/docs/coding-conventions.html#lambdas):

```kotlin
foo {
   context: Context,
   environment: Env
   ->
   context.configureEnv(environment)
}
```

The lambda parameters have the same indentation as the arrow and the following statement.

## Observed Behavior
When turning on the `Wrapping` rule with `autoCorrect` enabled via detekt, the code is formatted like this:
```kotlin
foo {
        context: Context,
        environment: Env,
    ->
    context.configureEnv(environment)
}
``` 

## Steps to Reproduce
Enable the `Wrapping` rule and let the check run for the following code:

```kotlin
class Env
class Context {
    fun configureEnv(env: Env) {}
}
fun foo(action: (context: Context, environment: Env) -> Unit) {}

fun bar() {
    foo {
        context: Context,
        environment: Env,
        ->
        context.configureEnv(environment)
    }
}
```

## Your Environment
<!--- Include as many relevant details about the environment you experienced the bug in -->
* Version of ktlint used: I am using ktlint via detekt 1.23.7
* Name and version (or code for custom task) of integration used (Gradle plugin, Maven plugin, command line, custom Gradle task): `./gradlew detekt --auto-correct`

