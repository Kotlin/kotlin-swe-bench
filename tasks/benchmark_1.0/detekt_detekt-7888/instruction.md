# Implement the issue(s) in detekt/detekt:

## Issue #7438 https://github.com/detekt/detekt/issues/7438: `additionalOperators` config in `UnusedImport` should be configurable and have an empty default

## Expected Behavior of the rule
Follow up to #7361.

`additionalOperators` should be configurable and have no default.

## Context
We have a philosophy of keeping rules agnostic and generally applicable, avoiding having rules or config that is only applicable for certain tools, libraries or frameworks.

Perhaps it doesn't make sense to be so strict on that convention in this case, since any valid operator that it used would mean that a related import is not unused, so it doesn't make sense to require configuration for this, but it's worth having the discussion.
