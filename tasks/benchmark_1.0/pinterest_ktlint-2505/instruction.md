# Implement the issue(s) in pinterest/ktlint:

## Issue #2504 https://github.com/pinterest/ktlint/issues/2504: Break dependency between `string-template-indent` and `multiline-expression-wrapping`

Currently the `string-template-indent` depends on the `multiline-expression-wrapping` to wrap the opening quotes of a multiline raw string literal in cases like below:
```
val foo = """
    some text
   """.trimIndent()
```

Although it is convenient from a technical perspective to rely on `multiline-expression-wrapping` to wrap the quotes, it forces the users to accept wrapping of all other multiline expressions as well.

As the wrapping logic for the opening quotes is not to complicated, it should be duplicated into the `string-template-indent` rule.

_Originally posted by @paul-dingemans in https://github.com/pinterest/ktlint/issues/2338#issuecomment-1890953266_
            
