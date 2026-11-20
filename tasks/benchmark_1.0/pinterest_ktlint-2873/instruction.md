# Implement the issue(s) in pinterest/ktlint:

## Issue #2872 https://github.com/pinterest/ktlint/issues/2872: `ktlint_function_signature_body_expression_wrapping=always` behavior question

## Expected Behavior

I'd like to format my multiline expression functions like so:

```kotlin
fun foo() =
    "bar"

fun foo(
    bar: BarBarBarBarBarBarBarBarBarBarBarBar,
    baz: BarBarBarBarBarBarBarBarBarBarBarBar,
    baf: BarBarBarBarBarBarBarBarBarBarBarBar,
    bag: BarBarBarBarBarBarBarBarBarBarBarBar,
) =
    Foo(
        bar = bar,
        baz = baz
    )

```

## Observed Behavior

Instead the second declaration is formatted as:

```
fun foo(
    bar: BarBarBarBarBarBarBarBarBarBarBarBar,
    baz: BarBarBarBarBarBarBarBarBarBarBarBar,
    baf: BarBarBarBarBarBarBarBarBarBarBarBar,
    bag: BarBarBarBarBarBarBarBarBarBarBarBar,
) = Foo(
    bar = bar,
    baz = baz
)
```

## Steps to Reproduce

My editorconfig has `ktlint_function_signature_body_expression_wrapping = always` and a max line length to force this parameter list to wrap. The expression wrapping works when the function declaration is a single line (the first function declaration) but not when the function declaration spans lines (the second). Is it possible to achieve what I'm looking for? Thanks!

## Your Environment
<!--- Include as many relevant details about the environment you experienced the bug in -->
* Version of ktlint used: 1.4.1
* Relevant parts of the `.editorconfig` settings:
```
        "max_line_length" to 120,
        "ktlint_class_signature_rule_force_multiline_when_parameter_count_greater_or_equal_than" to 1,
        "ktlint_function_signature_body_expression_wrapping" to "always",
```
* Name and version (or code for custom task) of integration used (Gradle plugin, Maven plugin, command line, custom Gradle task): Spotless v7 beta 3
* Version of Gradle used (if applicable): 8.10
* Operating System and version: Mac 

