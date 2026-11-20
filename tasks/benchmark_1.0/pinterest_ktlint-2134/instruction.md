# Implement the issue(s) in pinterest/ktlint:

## Issue #2128 https://github.com/pinterest/ktlint/issues/2128: Endless loop in wrapping binary expression after elvis operator

Given code below:
```
val foo =
    bar
        ?:
        throw UnsupportedOperationException("xxxxxxxxxxx")
```
and `.editorconfig`:
```
root = true

[**/*.{kt,kts}]
max_line_length = 60
ktlint_code_style = ktlint_official
ktlint_experimental = enabled
ktlint_standard = enabled
```
then ktlint `0.50.0` is not able to format this in 3 consecutive runs:
```
20:32:35.107 [pool-1-thread-1] WARN com.pinterest.ktlint.rule.engine.api.KtLintRuleEngine - Format was not able to resolve all violations which (theoretically) can be autocorrected in file src/main/kotlin/Foo.kt in 3 consecutive runs of format.
```

As a line may not end with `?:` ktlint merges the last two lines. This however results in wrapping the line again to the original situation. As of that an endless loop results.
