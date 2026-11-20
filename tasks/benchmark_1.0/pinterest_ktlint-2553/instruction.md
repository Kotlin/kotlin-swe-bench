# Implement the issue(s) in pinterest/ktlint:

## Issue #2530 https://github.com/pinterest/ktlint/issues/2530: string-template-indent changes content of string literal

## Expected Behavior

Using `string-template-indent` should not change the content of a string literal

## Observed Behavior

Using `string-template-indent` is changing a the content of a string literal

## Steps to Reproduce

1. Enable only the following rules:

```
ktlint_standard = disabled # disable all other rules
ktlint_standard_indent = enabled
ktlint_standard_multiline-expression-wrapping = enabled
ktlint_standard_string-template-indent = enabled
```

2. Input the code below to the rule


```kotlin
fun bug() {
    val strings = listOf("a")
    println(
        """
${strings.joinToString { "a" }}
        """.trimIndent()
    )
}
```

3. Observe the output is the following:

```
fun bug() {
    val strings = listOf("a")
    println(
        """
        ${strings.joinToString { "a" }}strings.joinToString { "a" }}
        """.trimIndent()
    )
}
```

## Your Environment
* Version of ktlint used: 1.1.1
* Using the API directly

