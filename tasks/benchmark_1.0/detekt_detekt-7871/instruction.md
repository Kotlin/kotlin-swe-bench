# Implement the issue(s) in detekt/detekt:

## Issue #7717 https://github.com/detekt/detekt/issues/7717: Allow custom HelpUri in sarif output for custom rules

## Expected Behavior

When I add custom detekt rules the HelpUri in sarif output should link to my documentation for my rules.

## Current Behavior

When i add custom rules the HelpUri links to `detekt.dev` example below

```json
{
              "helpUri": "https://detekt.dev/agoda-kraft.html#ignoredreturnvaluerule",
              "id": "detekt.agoda-kraft.IgnoredReturnValueRule",
              "name": "IgnoredReturnValueRule",
              "shortDescription": {
                "text": "This rule reports when a function call's return value is ignored."
              }
            }
```

But [recently](https://github.com/detekt/detekt/pull/7686) this was removed entirely

## Context

In our internal tooling we comment on MRs, in line wiht the code change (like a code reviewer would but a bot) when changed code has a linting error or warning, helps the code reviewer do a final check, especially with warnings that might sneak through. When doing so we use meta data from the output to link the Engineer to documentation explain why the code smell is bad with good documentation on compliant and non-compliant code.

The goals is to turn static code analysis into an education tools, and less of a thing that complains and blocks me.

We are recently adding Koltin into our list of support languages and in experimenting with custom detekt rule sim happy it support sarif format so this is in the schema, but unable to customise it

![image](https://github.com/user-attachments/assets/6a90df2d-0709-4148-8553-922125aa1a1d)

## Suggested implementation

An optional Parameter on the `Issue` perhaps? that overrides the current behaviour, also if its a custom rule, i dont think that the helpUri should output at all right?

