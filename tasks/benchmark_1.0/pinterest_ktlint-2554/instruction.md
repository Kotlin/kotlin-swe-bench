# Implement the issue(s) in pinterest/ktlint:

## Issue #2539 https://github.com/pinterest/ktlint/issues/2539: Conflict between `range-spacing` and `curly-spacing`

## Expected Behavior

`range-spacing` and `curly-spacing` should work together.

## Observed Behavior

It is possible to write code which makes it impossible to satisfy both rules.

## Steps to Reproduce

Try to lint or format the following code.

```
val list = listOf(true)
println(list.count { it }..1)
```

If the `}` is directly before the `.`, `curly-spacing` will fail. If a space is added in between them, `range-spacing` will fail.

## Your Environment
* Version of ktlint used: 1.1.1
